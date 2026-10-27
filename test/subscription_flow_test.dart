import 'package:drift/drift.dart' show Value;
import 'package:flutter_test/flutter_test.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/utils/billing_math.dart';
import 'package:subctrl/core/utils/forecast_engine.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:subctrl/data/repositories/catalog_repository.dart';
import 'package:subctrl/data/repositories/subscription_repository.dart';
import 'package:subctrl/data/seed/bootstrap.dart';

void main() {
  test('create subscription with phase and reminder appears in calendar and forecast', () async {
    final db = AppDatabase.memory();
    await BootstrapService(db).ensureInitialized();
    final subs = SubscriptionRepository(db);
    final finance = FinanceRepository(db);
    final settings = SettingsRepository(db);
    final id = await subs.create(
      serviceId: 'chatgpt',
      planId: 'chatgpt-plus',
      categoryId: 'ai',
      profileId: personalProfileId,
      status: SubscriptionStatus.active,
      startDate: DateTime(2026, 10, 1),
      nextBillingDate: DateTime(2026, 10, 8),
      autoRenew: true,
      currency: 'USD',
      currentPrice: 20,
      billingCycle: 'monthly',
      officialWebsiteUrl: 'https://chatgpt.com',
      phases: [
        PricePhasesCompanion.insert(
          id: 'phase-1',
          subscriptionId: 'pending',
          type: PricePhaseType.regular.name,
          startDate: DateTime(2026, 10, 1),
          price: 20,
          currency: 'USD',
          billingCycle: 'monthly',
        ),
      ],
      reminders: [
        RemindersCompanion.insert(
          id: 'rem-1',
          subscriptionId: 'pending',
          kind: ReminderKind.upcomingRenewal.name,
          offsetKind: ReminderOffset.days3.name,
          fireAt: DateTime(2026, 10, 5),
          notificationId: 1,
        ),
      ],
    );
    final list = await subs.listAll();
    expect(list.single.id, id);
    expect(list.single.phases, isNotEmpty);
    expect(await subs.remindersFor(id), isNotEmpty);
    final prefs = await settings.get();
    final rates = await finance.rates();
    final fx = CurrencyEngine(
      ratesVsUsd: rates,
      baseCurrency: prefs.baseCurrency,
      feePercent: prefs.foreignFeePercent,
    );
    final events = CalendarEngine.events(list, fx, month: DateTime(2026, 10));
    expect(events.any((e) => e.kind == 'payment' && e.date.day == 8), isTrue);
    final forecast = ForecastEngine(fx).nextTwelveMonths(list, from: DateTime(2026, 10, 1));
    expect(forecast.first.totalBase, greaterThan(0));
  });

  test('monthly regular price with a free year then continues paid', () async {
    final db = AppDatabase.memory();
    await BootstrapService(db).ensureInitialized();
    final subs = SubscriptionRepository(db);
    final start = DateTime(2026, 10, 21);
    final trialEnd = BillingMath.addFreePeriod(start, 365);
    final firstCharge = trialEnd.add(const Duration(days: 1));
    final id = await subs.create(
      serviceId: 'chatgpt',
      planId: 'chatgpt-plus',
      categoryId: 'ai',
      profileId: personalProfileId,
      status: SubscriptionStatus.trial,
      startDate: start,
      nextBillingDate: firstCharge,
      autoRenew: true,
      currency: 'TWD',
      currentPrice: 650,
      billingCycle: 'monthly',
      phases: [
        PricePhasesCompanion.insert(
          id: 'free-year',
          subscriptionId: 'pending',
          type: PricePhaseType.free.name,
          startDate: start,
          endDate: Value(trialEnd),
          price: 0,
          currency: 'TWD',
          billingCycle: 'monthly',
          regularPrice: const Value(650),
          regularCurrency: const Value('TWD'),
          trialEndDate: Value(trialEnd),
          firstChargeDate: Value(firstCharge),
        ),
        PricePhasesCompanion.insert(
          id: 'regular-after',
          subscriptionId: 'pending',
          type: PricePhaseType.regular.name,
          startDate: firstCharge,
          price: 650,
          currency: 'TWD',
          billingCycle: 'monthly',
        ),
      ],
    );
    final view = await subs.getById(id);
    expect(trialEnd, DateTime(2027, 10, 21));
    expect(view!.currentPrice, 650);
    expect(view.billingCycle, 'monthly');
    expect(view.phaseOn(DateTime(2026, 11, 1))?.price, 0);
    expect(view.phaseOn(firstCharge)?.price, 650);

    final fx = CurrencyEngine(ratesVsUsd: const {'USD': 1, 'TWD': 1}, baseCurrency: 'TWD', feePercent: 0);
    expect(fx.monthlyBase(view, on: DateTime(2026, 11, 1)), 0);
    expect(fx.monthlyBase(view, on: DateTime(2027, 10, 22)), 650);
    await db.close();
  });

  test('confirming resume price after free year activates subscription', () async {
    final db = AppDatabase.memory();
    await BootstrapService(db).ensureInitialized();
    final subs = SubscriptionRepository(db);
    final start = DateTime(2025, 10, 21);
    final trialEnd = DateTime(2026, 10, 20);
    final firstCharge = DateTime(2026, 10, 21);
    final id = await subs.create(
      serviceId: 'chatgpt',
      planId: 'chatgpt-plus',
      categoryId: 'ai',
      profileId: personalProfileId,
      status: SubscriptionStatus.trial,
      startDate: start,
      nextBillingDate: firstCharge,
      autoRenew: true,
      currency: 'TWD',
      currentPrice: 650,
      billingCycle: 'monthly',
      phases: [
        PricePhasesCompanion.insert(
          id: 'free-year',
          subscriptionId: 'pending',
          type: PricePhaseType.free.name,
          startDate: start,
          endDate: Value(trialEnd),
          price: 0,
          currency: 'TWD',
          billingCycle: 'monthly',
          regularPrice: const Value(650),
          regularCurrency: const Value('TWD'),
          trialEndDate: Value(trialEnd),
          firstChargeDate: Value(firstCharge),
        ),
        PricePhasesCompanion.insert(
          id: 'regular-after',
          subscriptionId: 'pending',
          type: PricePhaseType.regular.name,
          startDate: firstCharge,
          price: 650,
          currency: 'TWD',
          billingCycle: 'monthly',
        ),
      ],
    );
    final before = await subs.getById(id);
    expect(before!.needsPriceReview(now: DateTime(2026, 10, 21)), isTrue);
    expect(before.proposedResumePrice(now: DateTime(2026, 10, 21)), 650);

    await subs.confirmPostOfferPrice(
      id: id,
      price: 790,
      currency: 'TWD',
      billingCycle: 'monthly',
    );
    final after = await subs.getById(id);
    expect(after!.status, SubscriptionStatus.active);
    expect(after.currentPrice, 790);
    expect(after.needsPriceReview(now: DateTime(2026, 10, 21)), isFalse);
    expect(after.phaseOn(firstCharge)?.price, 790);
    final events = await subs.events(id);
    expect(events.any((e) => e.type == SubscriptionEventType.priceReviewed), isTrue);
    await db.close();
  });
}
