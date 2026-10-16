import 'package:flutter_test/flutter_test.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:subctrl/data/repositories/catalog_repository.dart';
import 'package:subctrl/data/repositories/subscription_repository.dart';
import 'package:subctrl/data/seed/bootstrap.dart';

void main() {
  test('custom service create + subscribe hydrates', () async {
    final db = AppDatabase.memory();
    await BootstrapService(db).ensureInitialized();
    final catalog = CatalogRepository(db);
    final subs = SubscriptionRepository(db);
    final svc = await catalog.createCustomService(name: 'My App', categoryId: 'other');
    expect(svc.isCustom, true);
    expect(svc.plans, isNotEmpty);

    final id = await subs.create(
      serviceId: svc.id,
      planId: svc.plans.first.id,
      categoryId: svc.categoryId,
      profileId: personalProfileId,
      status: SubscriptionStatus.active,
      startDate: DateTime(2026, 1, 1),
      nextBillingDate: DateTime(2026, 2, 1),
      autoRenew: true,
      currency: 'TWD',
      currentPrice: 99,
      billingCycle: 'monthly',
    );

    // Orphan Custom rows can be purged; in-use ones cannot.
    final orphan = await catalog.createCustomService(name: 'Custom', categoryId: 'other');
    expect(await catalog.purgeUnusedCustomServices(), 1);
    expect((await catalog.services()).any((s) => s.id == orphan.id), isFalse);
    expect((await catalog.services()).any((s) => s.id == svc.id), isTrue);

    final view = await subs.getById(id);
    expect(view!.serviceName, 'My App');
    expect(view.categorySlug, 'other');

    expect(() => catalog.deleteCustomService('chatgpt'), throwsA(isA<StateError>()));
    await db.close();
  });
}
