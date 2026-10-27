import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:subctrl/core/config/app_env.dart';
import 'package:subctrl/core/constants/currencies.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:subctrl/data/repositories/catalog_repository.dart';
import 'package:subctrl/data/seed/catalog.dart';
import 'package:uuid/uuid.dart';

const prefsId = 'prefs';
const accountId = 'local-account';
const personalProfileId = 'profile-personal';

class BootstrapService {
  BootstrapService(this.db);
  final AppDatabase db;
  final _uuid = const Uuid();

  Future<void> ensureInitialized() async {
    final existing = await db.select(db.userPreferences).getSingleOrNull();
    if (existing != null) return;

    final now = DateTime.now();
    await db.batch((b) {
      b.insert(
        db.userAccounts,
        UserAccountsCompanion.insert(id: accountId, createdAt: now, displayName: const Value('Local')),
      );
      if (!AppEnv.requireAccountLogin) {
        b.insert(
          db.linkedIdentities,
          LinkedIdentitiesCompanion.insert(
            id: 'identity-guest',
            accountId: accountId,
            provider: AuthProviderId.guest.name,
            linkedAt: now,
          ),
        );
      }
      b.insert(
        db.userProfiles,
        UserProfilesCompanion.insert(
          id: personalProfileId,
          name: 'PERSONAL',
          type: ProfileType.personal.name,
          isDefault: const Value(true),
        ),
      );
      for (final extra in [
        ('profile-work', 'WORK', ProfileType.work.name),
        ('profile-family', 'FAMILY', ProfileType.family.name),
      ]) {
        b.insert(
          db.userProfiles,
          UserProfilesCompanion.insert(id: extra.$1, name: extra.$2, type: extra.$3),
        );
      }
      for (final c in catalogCategories) {
        b.insert(
          db.categories,
          CategoriesCompanion.insert(id: c.$1, slug: c.$1, name: c.$2, sortOrder: c.$3),
        );
      }
      for (final s in catalogServices) {
        b.insert(
          db.services,
          ServicesCompanion.insert(
            id: s.id,
            name: s.name,
            categoryId: s.category,
            logoKey: Value(s.id),
            officialWebsiteUrl: Value(s.site),
            manageSubscriptionUrl: Value(s.manage),
            isBuiltin: const Value(true),
          ),
        );
        for (final p in s.plans) {
          b.insert(
            db.plans,
            PlansCompanion.insert(
              id: '${s.id}-${p.name.toLowerCase().replaceAll(' ', '-')}',
              serviceId: s.id,
              name: p.name,
              billingCycle: p.cycle,
              suggestedPrice: Value(p.price),
              suggestedCurrency: Value(p.currency),
            ),
          );
        }
      }
      for (final e in AppCurrencies.usdFallbacks.entries) {
        b.insert(
          db.currencyRates,
          CurrencyRatesCompanion.insert(code: e.key, unitsPerUsd: e.value, updatedAt: now),
        );
      }
      b.insert(
        db.userPreferences,
        UserPreferencesCompanion.insert(
          id: prefsId,
          baseCurrency: 'TWD',
          foreignFeePercent: 0,
          themePreset: ThemePreset.voidTheme.name,
          activeProfileId: const Value(personalProfileId),
          ratesUpdatedAt: Value(now),
        ),
      );
      b.insert(
        db.budgets,
        BudgetsCompanion.insert(
          id: 'budget-total',
          scope: 'total',
          monthlyAmount: 5000,
          currency: 'TWD',
        ),
      );
    });
  }

  Future<void> ensureCatalogFresh() async {
    for (final c in catalogCategories) {
      await db.into(db.categories).insert(
            CategoriesCompanion.insert(id: c.$1, slug: c.$1, name: c.$2, sortOrder: c.$3),
            mode: InsertMode.insertOrIgnore,
          );
    }
    for (final s in catalogServices) {
      await db.into(db.services).insert(
            ServicesCompanion.insert(
              id: s.id,
              name: s.name,
              categoryId: s.category,
              logoKey: Value(s.id),
              officialWebsiteUrl: Value(s.site),
              manageSubscriptionUrl: Value(s.manage),
              isBuiltin: const Value(true),
              isCustom: const Value(false),
            ),
            mode: InsertMode.insertOrIgnore,
          );
      for (final p in s.plans) {
        await db.into(db.plans).insert(
              PlansCompanion.insert(
                id: '${s.id}-${p.name.toLowerCase().replaceAll(' ', '-')}',
                serviceId: s.id,
                name: p.name,
                billingCycle: p.cycle,
                suggestedPrice: Value(p.price),
                suggestedCurrency: Value(p.currency),
              ),
              mode: InsertMode.insertOrIgnore,
            );
      }
    }
    // Drop accidental empty custom rows left from earlier add-flow bugs.
    await CatalogRepository(db).purgeUnusedCustomServices();
  }

  String newId() => _uuid.v4();
}

Map<String, dynamic>? decodeMap(String? raw) {
  if (raw == null || raw.isEmpty) return null;
  return jsonDecode(raw) as Map<String, dynamic>;
}
