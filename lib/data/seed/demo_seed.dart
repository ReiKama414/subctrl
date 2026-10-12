import 'package:drift/drift.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/utils/billing_math.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:subctrl/data/repositories/subscription_repository.dart';
import 'package:subctrl/data/seed/bootstrap.dart';
import 'package:uuid/uuid.dart';

class DemoSeed {
  DemoSeed(this.db, this.subs);
  final AppDatabase db;
  final SubscriptionRepository subs;
  final _uuid = const Uuid();

  Future<void> load() async {
    final existing = await (db.select(db.subscriptions)..where((t) => t.isDemo.equals(true))).get();
    if (existing.isNotEmpty) return;

    final now = DateTime(2026, 10, 6);
    await _chatGpt(now);
    await _claude(now);
    await _netflix(now);
    await _spotify(now);
    await _discord(now);
    await _googleOne(now);
    await _adobe(now);
    await _youtube(now);
    await db.into(db.paymentMethods).insert(
          PaymentMethodsCompanion.insert(
            id: 'pm-visa',
            label: 'Visa everyday',
            type: PaymentMethodType.visa.name,
            brand: 'Visa',
            last4: const Value('1234'),
            expiry: Value(DateTime(2027, 8, 31)),
          ),
          mode: InsertMode.insertOrIgnore,
        );
    await (db.update(db.userPreferences)..where((t) => t.id.equals(prefsId)))
        .write(const UserPreferencesCompanion(demoSeedEnabled: Value(true)));
  }

  Future<void> _chatGpt(DateTime now) async {
    final start = DateTime(2026, 1, 6);
    final id = await subs.create(
      serviceId: 'chatgpt',
      planId: 'chatgpt-plus',
      categoryId: 'ai',
      profileId: personalProfileId,
      status: SubscriptionStatus.active,
      startDate: start,
      nextBillingDate: DateTime(2026, 10, 6),
      autoRenew: true,
      currency: 'USD',
      currentPrice: 20,
      billingCycle: 'monthly',
      paymentMethodId: 'pm-visa',
      officialWebsiteUrl: 'https://chatgpt.com',
      manageSubscriptionUrl: 'https://chatgpt.com/#settings',
      isDemo: true,
      phases: [
        PricePhasesCompanion.insert(
          id: _uuid.v4(),
          subscriptionId: 'pending',
          type: PricePhaseType.regular.name,
          startDate: start,
          price: 20,
          currency: 'USD',
          billingCycle: 'monthly',
        ),
      ],
    );
    await subs.addPriceHistory(
      subscriptionId: id,
      oldPrice: 20,
      newPrice: 20,
      currency: 'USD',
      effectiveDate: start,
      reason: 'Plan start',
    );
    await _pay(id, DateTime(2026, 9, 6), 20, 'USD', 32.6);
  }

  Future<void> _claude(DateTime now) async {
    final trialStart = DateTime(2026, 9, 27);
    final trialEnd = DateTime(2026, 10, 27);
    final deadline = DateTime(2026, 10, 26);
    final firstCharge = DateTime(2026, 10, 28);
    final id = await subs.create(
      serviceId: 'claude',
      planId: 'claude-pro',
      categoryId: 'ai',
      profileId: personalProfileId,
      status: SubscriptionStatus.trial,
      startDate: trialStart,
      nextBillingDate: firstCharge,
      autoRenew: true,
      currency: 'USD',
      currentPrice: 20,
      billingCycle: 'monthly',
      officialWebsiteUrl: 'https://claude.ai',
      manageSubscriptionUrl: 'https://claude.ai/settings',
      isDemo: true,
      phases: [
        PricePhasesCompanion.insert(
          id: _uuid.v4(),
          subscriptionId: 'pending',
          type: PricePhaseType.free.name,
          startDate: trialStart,
          endDate: Value(trialEnd),
          price: 0,
          currency: 'USD',
          billingCycle: 'monthly',
          regularPrice: const Value(20),
          regularCurrency: const Value('USD'),
          promotionName: const Value('Free period'),
          cancelDeadline: Value(deadline),
          firstChargeDate: Value(firstCharge),
          trialEndDate: Value(trialEnd),
          reminderDate: Value(BillingMath.applySafetyBuffer(deadline, 2)),
        ),
        PricePhasesCompanion.insert(
          id: _uuid.v4(),
          subscriptionId: 'pending',
          type: PricePhaseType.regular.name,
          startDate: firstCharge,
          price: 20,
          currency: 'USD',
          billingCycle: 'monthly',
          sortOrder: const Value(1),
        ),
      ],
      reminders: [
        RemindersCompanion.insert(
          id: _uuid.v4(),
          subscriptionId: 'pending',
          kind: ReminderKind.trialEnd.name,
          offsetKind: ReminderOffset.days3.name,
          fireAt: DateTime(2026, 10, 24),
          notificationId: 101,
        ),
        RemindersCompanion.insert(
          id: _uuid.v4(),
          subscriptionId: 'pending',
          kind: ReminderKind.cancelDeadline.name,
          offsetKind: ReminderOffset.days1.name,
          fireAt: DateTime(2026, 10, 25),
          notificationId: 102,
        ),
      ],
    );
    await subs.addPriceHistory(
      subscriptionId: id,
      oldPrice: 0,
      newPrice: 20,
      currency: 'USD',
      effectiveDate: firstCharge,
      reason: 'After trial',
    );
  }

  Future<void> _netflix(DateTime now) async {
    final id = await subs.create(
      serviceId: 'netflix',
      planId: 'netflix-standard',
      categoryId: 'video',
      profileId: personalProfileId,
      status: SubscriptionStatus.active,
      startDate: DateTime(2025, 3, 3),
      nextBillingDate: DateTime(2026, 10, 8),
      autoRenew: true,
      currency: 'TWD',
      currentPrice: 270,
      billingCycle: 'monthly',
      isDemo: true,
      phases: [
        PricePhasesCompanion.insert(
          id: _uuid.v4(),
          subscriptionId: 'pending',
          type: PricePhaseType.regular.name,
          startDate: DateTime(2025, 3, 3),
          price: 270,
          currency: 'TWD',
          billingCycle: 'monthly',
        ),
      ],
    );
    await _pay(id, DateTime(2026, 9, 8), 270, 'TWD', 1);
  }

  Future<void> _spotify(DateTime now) async {
    final id = await subs.create(
      serviceId: 'spotify',
      planId: 'spotify-individual',
      categoryId: 'music',
      profileId: personalProfileId,
      status: SubscriptionStatus.promo,
      startDate: DateTime(2026, 8, 1),
      nextBillingDate: DateTime(2026, 10, 1),
      autoRenew: true,
      currency: 'TWD',
      currentPrice: 99,
      billingCycle: 'monthly',
      isDemo: true,
      phases: [
        PricePhasesCompanion.insert(
          id: _uuid.v4(),
          subscriptionId: 'pending',
          type: PricePhaseType.promo.name,
          startDate: DateTime(2026, 8, 1),
          endDate: Value(DateTime(2026, 10, 31)),
          price: 99,
          currency: 'TWD',
          billingCycle: 'monthly',
          regularPrice: const Value(149),
          regularCurrency: const Value('TWD'),
          promotionName: const Value('First 3 months'),
        ),
      ],
    );
    await subs.addPriceHistory(
      subscriptionId: id,
      oldPrice: 99,
      newPrice: 149,
      currency: 'TWD',
      effectiveDate: DateTime(2026, 11, 1),
      reason: 'Promo end',
    );
  }

  Future<void> _discord(DateTime now) async {
    await subs.create(
      serviceId: 'discord',
      planId: 'discord-nitro',
      categoryId: 'gaming',
      profileId: personalProfileId,
      status: SubscriptionStatus.active,
      startDate: DateTime(2026, 2, 14),
      nextBillingDate: DateTime(2026, 10, 14),
      autoRenew: true,
      currency: 'USD',
      currentPrice: 9.99,
      billingCycle: 'monthly',
      isDemo: true,
      phases: [
        PricePhasesCompanion.insert(
          id: _uuid.v4(),
          subscriptionId: 'pending',
          type: PricePhaseType.regular.name,
          startDate: DateTime(2026, 2, 14),
          price: 9.99,
          currency: 'USD',
          billingCycle: 'monthly',
        ),
      ],
    );
  }

  Future<void> _googleOne(DateTime now) async {
    await subs.create(
      serviceId: 'googleone',
      planId: 'googleone-100-gb',
      categoryId: 'cloud',
      profileId: personalProfileId,
      status: SubscriptionStatus.active,
      startDate: DateTime(2024, 5, 1),
      nextBillingDate: DateTime(2026, 11, 1),
      autoRenew: true,
      currency: 'TWD',
      currentPrice: 70,
      billingCycle: 'monthly',
      isDemo: true,
      phases: [
        PricePhasesCompanion.insert(
          id: _uuid.v4(),
          subscriptionId: 'pending',
          type: PricePhaseType.regular.name,
          startDate: DateTime(2024, 5, 1),
          price: 70,
          currency: 'TWD',
          billingCycle: 'monthly',
        ),
      ],
    );
  }

  Future<void> _adobe(DateTime now) async {
    final id = await subs.create(
      serviceId: 'adobe',
      planId: 'adobe-creative-cloud-all-apps',
      categoryId: 'software',
      profileId: personalProfileId,
      status: SubscriptionStatus.active,
      startDate: DateTime(2023, 6, 1),
      nextBillingDate: DateTime(2026, 11, 1),
      autoRenew: true,
      currency: 'USD',
      currentPrice: 59.99,
      billingCycle: 'monthly',
      usageFrequency: UsageFrequency.rarely,
      isDemo: true,
      phases: [
        PricePhasesCompanion.insert(
          id: _uuid.v4(),
          subscriptionId: 'pending',
          type: PricePhaseType.regular.name,
          startDate: DateTime(2025, 6, 1),
          price: 59.99,
          currency: 'USD',
          billingCycle: 'monthly',
        ),
      ],
    );
    await subs.addPriceHistory(
      subscriptionId: id,
      oldPrice: 54.99,
      newPrice: 59.99,
      currency: 'USD',
      effectiveDate: DateTime(2025, 6, 1),
      reason: 'Regular price increase',
    );
  }

  Future<void> _youtube(DateTime now) async {
    await subs.create(
      serviceId: 'youtube',
      planId: 'youtube-individual',
      categoryId: 'video',
      profileId: personalProfileId,
      status: SubscriptionStatus.cancelled,
      startDate: DateTime(2025, 1, 18),
      nextBillingDate: DateTime(2026, 10, 18),
      accessEndDate: DateTime(2026, 10, 18),
      autoRenew: false,
      currency: 'TWD',
      currentPrice: 179,
      billingCycle: 'monthly',
      isDemo: true,
      phases: [
        PricePhasesCompanion.insert(
          id: _uuid.v4(),
          subscriptionId: 'pending',
          type: PricePhaseType.regular.name,
          startDate: DateTime(2025, 1, 18),
          endDate: Value(DateTime(2026, 10, 18)),
          price: 179,
          currency: 'TWD',
          billingCycle: 'monthly',
          autoRenew: const Value(false),
        ),
      ],
    );
  }

  Future<void> _pay(String subId, DateTime date, double amount, String currency, double fx) async {
    final converted = amount * (currency == 'TWD' ? 1 : fx);
    await db.into(db.paymentRecords).insert(
          PaymentRecordsCompanion.insert(
            id: _uuid.v4(),
            subscriptionId: subId,
            date: date,
            originalAmount: amount,
            originalCurrency: currency,
            exchangeRate: currency == 'TWD' ? 1 : fx,
            convertedAmount: converted,
            baseCurrency: 'TWD',
            foreignFee: currency == 'TWD' ? 0 : converted * 0.015,
            actualChargedAmount: currency == 'TWD' ? converted : converted * 1.015,
          ),
        );
    await subs.addEvent(subId, SubscriptionEventType.payment, 'PAYMENT',
        detail: '$amount $currency');
  }
}
