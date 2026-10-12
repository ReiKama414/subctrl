import 'package:flutter_test/flutter_test.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/utils/forecast_engine.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:subctrl/data/repositories/subscription_repository.dart';
import 'package:subctrl/data/seed/bootstrap.dart';

void main() {
  testWidgets('integration: create subscription through repositories', (tester) async {
    final db = AppDatabase.memory();
    await BootstrapService(db).ensureInitialized();
    final subs = SubscriptionRepository(db);
    await subs.create(
      serviceId: 'spotify',
      categoryId: 'music',
      profileId: personalProfileId,
      status: SubscriptionStatus.active,
      startDate: DateTime(2026, 10, 1),
      nextBillingDate: DateTime(2026, 10, 8),
      autoRenew: true,
      currency: 'TWD',
      currentPrice: 149,
      billingCycle: 'monthly',
    );
    final list = await subs.listAll();
    expect(list, isNotEmpty);
    final fx = CurrencyEngine(ratesVsUsd: const {'TWD': 32.6, 'USD': 1}, baseCurrency: 'TWD', feePercent: 0);
    expect(CalendarEngine.events(list, fx, month: DateTime(2026, 10)), isNotEmpty);
  });
}
