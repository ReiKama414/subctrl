import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/services/export_service.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:subctrl/data/repositories/catalog_repository.dart';
import 'package:subctrl/data/repositories/purchase_repository.dart';
import 'package:subctrl/data/repositories/subscription_repository.dart';
import 'package:subctrl/data/seed/bootstrap.dart';

void main() {
  test('restore requires confirmation and can overwrite ledger', () async {
    final db = AppDatabase.memory();
    await BootstrapService(db).ensureInitialized();
    final subs = SubscriptionRepository(db);
    final finance = FinanceRepository(db);
    final export = ExportService(db, subs, finance, PurchaseRepository(db));

    await subs.create(
      serviceId: 'spotify',
      categoryId: 'music',
      profileId: personalProfileId,
      status: SubscriptionStatus.active,
      startDate: DateTime(2026, 1, 1),
      nextBillingDate: DateTime(2026, 11, 1),
      autoRenew: true,
      currency: 'TWD',
      currentPrice: 149,
      billingCycle: 'monthly',
    );
    expect(await subs.listAll(), hasLength(1));

    final backup = await export.toJsonMap();
    final raw = jsonEncode(backup);

    expect(
      () => export.restoreFromJson(raw, confirmedOverwrite: false),
      throwsA(isA<RestoreNeedsConfirmation>()),
    );

    await subs.create(
      serviceId: 'netflix',
      categoryId: 'video',
      profileId: personalProfileId,
      status: SubscriptionStatus.active,
      startDate: DateTime(2026, 2, 1),
      nextBillingDate: DateTime(2026, 11, 2),
      autoRenew: true,
      currency: 'TWD',
      currentPrice: 270,
      billingCycle: 'monthly',
    );
    expect(await subs.listAll(), hasLength(2));

    final result = await export.restoreFromJson(raw, confirmedOverwrite: true);
    expect(result.subscriptionCount, 1);
    final after = await subs.listAll();
    expect(after, hasLength(1));
    expect(after.single.serviceName, 'Spotify');
  });

  test('category budget upsert and profile assignment', () async {
    final db = AppDatabase.memory();
    await BootstrapService(db).ensureInitialized();
    final finance = FinanceRepository(db);
    final settings = SettingsRepository(db);
    final subs = SubscriptionRepository(db);

    await finance.upsertBudget(
      id: 'budget-cat-ai',
      scope: 'category',
      categoryId: 'ai',
      amount: 2000,
      currency: 'TWD',
    );
    final budgets = await finance.budgets();
    expect(budgets.any((b) => b.scope == 'category' && b.categoryId == 'ai'), isTrue);

    final workId = await settings.createCustomProfile('Client A');
    final id = await subs.create(
      serviceId: 'chatgpt',
      categoryId: 'ai',
      profileId: personalProfileId,
      status: SubscriptionStatus.active,
      startDate: DateTime(2026, 1, 1),
      nextBillingDate: DateTime(2026, 11, 1),
      autoRenew: true,
      currency: 'USD',
      currentPrice: 20,
      billingCycle: 'monthly',
    );
    await subs.setProfile(id, workId);
    final view = await subs.getById(id);
    expect(view!.profileId, workId);
  });

  test('manual FX override persists', () async {
    final db = AppDatabase.memory();
    await BootstrapService(db).ensureInitialized();
    final finance = FinanceRepository(db);
    await finance.upsertRates({'TWD': 31.5}, manual: true, at: DateTime.now());
    final rates = await finance.rates();
    expect(rates['TWD'], 31.5);
  });
}
