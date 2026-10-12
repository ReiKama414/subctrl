import 'package:drift/drift.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:subctrl/data/models/views.dart';
import 'package:uuid/uuid.dart';

class CatalogRepository {
  CatalogRepository(this.db);
  final AppDatabase db;
  final _uuid = const Uuid();

  Future<List<ServiceView>> services() async {
    final rows = await (db.select(db.services)..orderBy([(t) => OrderingTerm.asc(t.name)])).get();
    final plans = await db.select(db.plans).get();
    final cats = {for (final c in await db.select(db.categories).get()) c.id: c};
    return rows.map((s) {
      return ServiceView(
        id: s.id,
        name: s.name,
        categoryId: s.categoryId,
        categorySlug: cats[s.categoryId]?.slug ?? s.categoryId,
        logoKey: s.logoKey,
        officialWebsiteUrl: s.officialWebsiteUrl,
        manageSubscriptionUrl: s.manageSubscriptionUrl,
        isCustom: s.isCustom,
        plans: plans
            .where((p) => p.serviceId == s.id)
            .map(
              (p) => PlanView(
                id: p.id,
                serviceId: p.serviceId,
                name: p.name,
                billingCycle: p.billingCycle,
                suggestedPrice: p.suggestedPrice,
                suggestedCurrency: p.suggestedCurrency,
              ),
            )
            .toList(),
      );
    }).toList();
  }

  Future<ServiceView> createCustomService({
    required String name,
    required String categoryId,
    String? site,
    String? manage,
  }) async {
    final id = _uuid.v4();
    await db.into(db.services).insert(
          ServicesCompanion.insert(
            id: id,
            name: name,
            categoryId: categoryId,
            officialWebsiteUrl: Value(site),
            manageSubscriptionUrl: Value(manage),
            isCustom: const Value(true),
            isBuiltin: const Value(false),
          ),
        );
    final planId = _uuid.v4();
    await db.into(db.plans).insert(
          PlansCompanion.insert(
            id: planId,
            serviceId: id,
            name: 'Custom',
            billingCycle: BillingCycle.monthly.name,
          ),
        );
    return (await services()).firstWhere((s) => s.id == id);
  }

  Future<List<Category>> categories() =>
      (db.select(db.categories)..orderBy([(t) => OrderingTerm.asc(t.sortOrder)])).get();
}

class FinanceRepository {
  FinanceRepository(this.db);
  final AppDatabase db;
  final _uuid = const Uuid();

  Future<List<PaymentView>> payments({String? subscriptionId}) async {
    final q = db.select(db.paymentRecords);
    if (subscriptionId != null) {
      q.where((t) => t.subscriptionId.equals(subscriptionId));
    }
    q.orderBy([(t) => OrderingTerm.desc(t.date)]);
    final rows = await q.get();
    return rows
        .map(
          (e) => PaymentView(
            id: e.id,
            subscriptionId: e.subscriptionId,
            date: e.date,
            originalAmount: e.originalAmount,
            originalCurrency: e.originalCurrency,
            exchangeRate: e.exchangeRate,
            convertedAmount: e.convertedAmount,
            baseCurrency: e.baseCurrency,
            foreignFee: e.foreignFee,
            actualChargedAmount: e.actualChargedAmount,
            paymentMethodId: e.paymentMethodId,
            note: e.note,
          ),
        )
        .toList();
  }

  Future<void> addPayment(PaymentView p) async {
    await db.into(db.paymentRecords).insert(
          PaymentRecordsCompanion.insert(
            id: p.id.isEmpty ? _uuid.v4() : p.id,
            subscriptionId: p.subscriptionId,
            date: p.date,
            originalAmount: p.originalAmount,
            originalCurrency: p.originalCurrency,
            exchangeRate: p.exchangeRate,
            convertedAmount: p.convertedAmount,
            baseCurrency: p.baseCurrency,
            foreignFee: p.foreignFee,
            actualChargedAmount: p.actualChargedAmount,
            paymentMethodId: Value(p.paymentMethodId),
            note: Value(p.note),
          ),
        );
  }

  Future<List<PaymentMethodView>> methods() async {
    final rows = await db.select(db.paymentMethods).get();
    return rows
        .map(
          (m) => PaymentMethodView(
            id: m.id,
            label: m.label,
            type: PaymentMethodType.values.byName(m.type),
            brand: m.brand,
            last4: m.last4,
            expiry: m.expiry,
          ),
        )
        .toList();
  }

  Future<String> addMethod(PaymentMethodView m) async {
    final id = m.id.isEmpty ? _uuid.v4() : m.id;
    await db.into(db.paymentMethods).insert(
          PaymentMethodsCompanion.insert(
            id: id,
            label: m.label,
            type: m.type.name,
            brand: m.brand,
            last4: Value(m.last4),
            expiry: Value(m.expiry),
          ),
        );
    return id;
  }

  Future<Map<String, double>> rates() async {
    final rows = await db.select(db.currencyRates).get();
    return {for (final r in rows) r.code: r.unitsPerUsd};
  }

  Future<void> upsertRates(Map<String, double> rates, {required bool manual, required DateTime at}) async {
    await db.batch((b) {
      for (final e in rates.entries) {
        b.insert(
          db.currencyRates,
          CurrencyRatesCompanion.insert(
            code: e.key,
            unitsPerUsd: e.value,
            updatedAt: at,
            isManual: Value(manual),
          ),
          onConflict: DoUpdate(
            (old) => CurrencyRatesCompanion(
              unitsPerUsd: Value(e.value),
              updatedAt: Value(at),
              isManual: Value(manual),
            ),
          ),
        );
      }
    });
  }

  Future<List<Budget>> budgets() => db.select(db.budgets).get();

  Future<void> upsertBudget({
    required String id,
    required String scope,
    String? categoryId,
    String? profileId,
    required double amount,
    required String currency,
  }) {
    return db.into(db.budgets).insertOnConflictUpdate(
          BudgetsCompanion.insert(
            id: id,
            scope: scope,
            categoryId: Value(categoryId),
            profileId: Value(profileId),
            monthlyAmount: amount,
            currency: currency,
          ),
        );
  }

  Future<void> deleteBudget(String id) {
    return (db.delete(db.budgets)..where((t) => t.id.equals(id))).go();
  }
}

class SettingsRepository {
  SettingsRepository(this.db);
  final AppDatabase db;

  Stream<PreferenceView> watch() {
    return (db.select(db.userPreferences)..where((t) => t.id.equals('prefs'))).watchSingle().map(_map);
  }

  Future<PreferenceView> get() async {
    final row = await (db.select(db.userPreferences)..where((t) => t.id.equals('prefs'))).getSingle();
    return _map(row);
  }

  PreferenceView _map(UserPreference row) => PreferenceView(
        baseCurrency: row.baseCurrency,
        foreignFeePercent: row.foreignFeePercent,
        themePreset: row.themePreset,
        customThemeJson: row.customThemeJson,
        reduceMotion: row.reduceMotion,
        biometricLock: row.biometricLock,
        hideAmounts: row.hideAmounts,
        cancelSafetyBufferDays: row.cancelSafetyBufferDays,
        onboardingComplete: row.onboardingComplete,
        demoSeedEnabled: row.demoSeedEnabled,
        activeProfileId: row.activeProfileId,
        ratesUpdatedAt: row.ratesUpdatedAt,
        lastFxError: row.lastFxError,
        localeCode: row.localeCode,
      );

  Future<void> patch(UserPreferencesCompanion companion) {
    return (db.update(db.userPreferences)..where((t) => t.id.equals('prefs'))).write(companion);
  }

  Future<List<LinkedIdentity>> identities() => db.select(db.linkedIdentities).get();

  Future<void> linkIdentity({
    required String provider,
    String? providerUserId,
    String? email,
    String? displayName,
  }) async {
    final existing = await (db.select(db.linkedIdentities)..where((t) => t.provider.equals(provider))).getSingleOrNull();
    if (existing != null) {
      await (db.update(db.linkedIdentities)..where((t) => t.id.equals(existing.id))).write(
        LinkedIdentitiesCompanion(
          providerUserId: Value(providerUserId),
          email: Value(email),
          displayName: Value(displayName),
          linkedAt: Value(DateTime.now()),
        ),
      );
      return;
    }
    await db.into(db.linkedIdentities).insert(
          LinkedIdentitiesCompanion.insert(
            id: 'identity-$provider',
            accountId: 'local-account',
            provider: provider,
            providerUserId: Value(providerUserId),
            email: Value(email),
            displayName: Value(displayName),
            linkedAt: DateTime.now(),
          ),
        );
  }

  Future<List<UserProfile>> profiles() =>
      (db.select(db.userProfiles)..orderBy([(t) => OrderingTerm.asc(t.name)])).get();

  Future<String> createCustomProfile(String name) async {
    final id = 'profile-custom-${DateTime.now().millisecondsSinceEpoch}';
    await db.into(db.userProfiles).insert(
          UserProfilesCompanion.insert(
            id: id,
            name: name.toUpperCase(),
            type: ProfileType.custom.name,
          ),
        );
    return id;
  }

  Future<void> setActiveProfile(String? profileId) {
    return patch(UserPreferencesCompanion(activeProfileId: Value(profileId)));
  }
}
