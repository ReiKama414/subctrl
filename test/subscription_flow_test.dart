import 'package:flutter_test/flutter_test.dart';
import 'package:subctrl/core/constants/enums.dart';
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
}
