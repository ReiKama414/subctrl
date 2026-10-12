import 'package:flutter_test/flutter_test.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:subctrl/data/repositories/subscription_repository.dart';
import 'package:subctrl/data/seed/bootstrap.dart';

void main() {
  test('cancelled subscription becomes expired after accessEndDate', () async {
    final db = AppDatabase.memory();
    await BootstrapService(db).ensureInitialized();
    final repo = SubscriptionRepository(db);
    final id = await repo.create(
      serviceId: 'youtube',
      categoryId: 'video',
      profileId: personalProfileId,
      status: SubscriptionStatus.cancelled,
      startDate: DateTime(2026, 1, 1),
      nextBillingDate: DateTime(2026, 9, 1),
      accessEndDate: DateTime(2026, 9, 30),
      autoRenew: false,
      currency: 'TWD',
      currentPrice: 179,
      billingCycle: 'monthly',
    );
    final before = await repo.getById(id);
    expect(before!.status, SubscriptionStatus.cancelled);
    final changed = await repo.expireIfNeeded(before, DateTime(2026, 10, 1));
    expect(changed, isTrue);
    final after = await repo.getById(id);
    expect(after!.status, SubscriptionStatus.expired);
  });
}
