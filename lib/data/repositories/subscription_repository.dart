import 'package:drift/drift.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/utils/billing_math.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:subctrl/data/models/views.dart';
import 'package:uuid/uuid.dart';

class SubscriptionRepository {
  SubscriptionRepository(this.db);
  final AppDatabase db;
  final _uuid = const Uuid();

  Stream<List<SubscriptionView>> watchAll() {
    return db.select(db.subscriptions).watch().asyncMap((_) => listAll());
  }

  Future<List<SubscriptionView>> listAll() async {
    final rows = await db.select(db.subscriptions).get();
    final now = DateTime.now();
    final out = <SubscriptionView>[];
    for (final row in rows) {
      var view = await hydrate(row);
      if (await expireIfNeeded(view, now)) {
        view = await getById(view.id) ?? view;
      }
      out.add(view);
    }
    return out;
  }

  Future<SubscriptionView> hydrate(Subscription row) async {
    final service = await (db.select(db.services)..where((t) => t.id.equals(row.serviceId))).getSingle();
    final category = await (db.select(db.categories)..where((t) => t.id.equals(row.categoryId))).getSingle();
    Plan? plan;
    if (row.planId != null) {
      plan = await (db.select(db.plans)..where((t) => t.id.equals(row.planId!))).getSingleOrNull();
    }
    final phases = await (db.select(db.pricePhases)
          ..where((t) => t.subscriptionId.equals(row.id))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
    return SubscriptionView(
      id: row.id,
      serviceId: row.serviceId,
      serviceName: service.name,
      planId: row.planId,
      planName: plan?.name,
      categoryId: row.categoryId,
      categorySlug: category.slug,
      profileId: row.profileId,
      status: SubscriptionStatus.values.byName(row.status),
      startDate: row.startDate,
      nextBillingDate: row.nextBillingDate,
      accessEndDate: row.accessEndDate,
      autoRenew: row.autoRenew,
      currency: row.currency,
      currentPrice: row.currentPrice,
      billingCycle: row.billingCycle,
      customCycleDays: row.customCycleDays,
      paymentMethodId: row.paymentMethodId,
      renewalIntent: RenewalIntent.values.byName(row.renewalIntent),
      usageFrequency: UsageFrequency.values.byName(row.usageFrequency),
      usageCountPerMonth: row.usageCountPerMonth,
      officialWebsiteUrl: row.officialWebsiteUrl,
      manageSubscriptionUrl: row.manageSubscriptionUrl,
      notes: row.notes,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      logoKey: service.logoKey,
      phases: phases
          .map(
            (p) => PhaseView(
              id: p.id,
              subscriptionId: p.subscriptionId,
              type: PricePhaseType.values.byName(p.type),
              startDate: p.startDate,
              endDate: p.endDate,
              price: p.price,
              currency: p.currency,
              billingCycle: p.billingCycle,
              regularPrice: p.regularPrice,
              regularCurrency: p.regularCurrency,
              promotionName: p.promotionName,
              cancelDeadline: p.cancelDeadline,
              firstChargeDate: p.firstChargeDate,
              trialEndDate: p.trialEndDate,
              reminderDate: p.reminderDate,
              autoRenew: p.autoRenew,
            ),
          )
          .toList(),
    );
  }

  Future<SubscriptionView?> getById(String id) async {
    final row = await (db.select(db.subscriptions)..where((t) => t.id.equals(id))).getSingleOrNull();
    if (row == null) return null;
    return hydrate(row);
  }

  Future<String> create({
    required String serviceId,
    String? planId,
    required String categoryId,
    required String profileId,
    required SubscriptionStatus status,
    required DateTime startDate,
    DateTime? nextBillingDate,
    DateTime? accessEndDate,
    required bool autoRenew,
    required String currency,
    required double currentPrice,
    required String billingCycle,
    int? customCycleDays,
    String? paymentMethodId,
    RenewalIntent renewalIntent = RenewalIntent.undecided,
    UsageFrequency usageFrequency = UsageFrequency.monthly,
    int? usageCountPerMonth,
    String? officialWebsiteUrl,
    String? manageSubscriptionUrl,
    String? notes,
    List<PricePhasesCompanion> phases = const [],
    List<RemindersCompanion> reminders = const [],
    bool isDemo = false,
  }) async {
    final id = _uuid.v4();
    final now = DateTime.now();
    await db.into(db.subscriptions).insert(
          SubscriptionsCompanion.insert(
            id: id,
            serviceId: serviceId,
            planId: Value(planId),
            categoryId: categoryId,
            profileId: profileId,
            status: status.name,
            active: Value(status != SubscriptionStatus.expired && status != SubscriptionStatus.cancelled),
            startDate: startDate,
            nextBillingDate: Value(nextBillingDate),
            accessEndDate: Value(accessEndDate),
            autoRenew: Value(autoRenew),
            currency: currency,
            currentPrice: currentPrice,
            billingCycle: billingCycle,
            customCycleDays: Value(customCycleDays),
            paymentMethodId: Value(paymentMethodId),
            renewalIntent: renewalIntent.name,
            usageFrequency: usageFrequency.name,
            usageCountPerMonth: Value(usageCountPerMonth),
            officialWebsiteUrl: Value(officialWebsiteUrl),
            manageSubscriptionUrl: Value(manageSubscriptionUrl),
            notes: Value(notes),
            createdAt: now,
            updatedAt: now,
            isDemo: Value(isDemo),
          ),
        );
    for (var i = 0; i < phases.length; i++) {
      final phase = phases[i].copyWith(
        id: phases[i].id.present ? phases[i].id : Value(_uuid.v4()),
        subscriptionId: Value(id),
        sortOrder: Value(i),
      );
      await db.into(db.pricePhases).insert(phase);
    }
    for (final reminder in reminders) {
      await db.into(db.reminders).insert(
            reminder.copyWith(
              id: reminder.id.present ? reminder.id : Value(_uuid.v4()),
              subscriptionId: Value(id),
            ),
          );
    }
    await addEvent(id, SubscriptionEventType.created, 'CREATED', detail: status.label);
    if (status == SubscriptionStatus.trial) {
      await addEvent(id, SubscriptionEventType.trialStarted, 'TRIAL START');
    }
    if (status == SubscriptionStatus.promo) {
      await addEvent(id, SubscriptionEventType.promoStarted, 'PROMOTION START');
    }
    return id;
  }

  Future<void> update(SubscriptionsCompanion companion) {
    return (db.update(db.subscriptions)..where((t) => t.id.equals(companion.id.value))).write(
      companion.copyWith(updatedAt: Value(DateTime.now())),
    );
  }

  Future<void> cancel(String id, DateTime accessUntil) async {
    await (db.update(db.subscriptions)..where((t) => t.id.equals(id))).write(
      SubscriptionsCompanion(
        status: Value(SubscriptionStatus.cancelled.name),
        active: const Value(false),
        autoRenew: const Value(false),
        accessEndDate: Value(accessUntil),
        updatedAt: Value(DateTime.now()),
      ),
    );
    await addEvent(id, SubscriptionEventType.cancelRequested, 'CANCEL REQUESTED');
    await addEvent(id, SubscriptionEventType.cancelled, 'CANCELLED', detail: 'Access until ${accessUntil.toIso8601String()}');
  }

  /// Returns true when status was advanced to expired.
  Future<bool> expireIfNeeded(SubscriptionView sub, DateTime now) async {
    if (sub.status == SubscriptionStatus.cancelled &&
        sub.accessEndDate != null &&
        !BillingMath.dateOnly(now).isBefore(BillingMath.dateOnly(sub.accessEndDate!))) {
      await (db.update(db.subscriptions)..where((t) => t.id.equals(sub.id))).write(
        SubscriptionsCompanion(
          status: Value(SubscriptionStatus.expired.name),
          updatedAt: Value(now),
        ),
      );
      await addEvent(sub.id, SubscriptionEventType.expired, 'EXPIRED');
      return true;
    }
    return false;
  }

  Future<void> setRenewalIntent(String id, RenewalIntent intent) {
    return (db.update(db.subscriptions)..where((t) => t.id.equals(id))).write(
      SubscriptionsCompanion(
        renewalIntent: Value(intent.name),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> setUsage({
    required String id,
    required UsageFrequency frequency,
    int? usageCountPerMonth,
  }) {
    return (db.update(db.subscriptions)..where((t) => t.id.equals(id))).write(
      SubscriptionsCompanion(
        usageFrequency: Value(frequency.name),
        usageCountPerMonth: Value(usageCountPerMonth),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> setProfile(String id, String profileId) {
    return (db.update(db.subscriptions)..where((t) => t.id.equals(id))).write(
      SubscriptionsCompanion(
        profileId: Value(profileId),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> addEvent(String subscriptionId, SubscriptionEventType type, String title, {String? detail}) {
    return db.into(db.subscriptionEvents).insert(
          SubscriptionEventsCompanion.insert(
            id: _uuid.v4(),
            subscriptionId: subscriptionId,
            type: type.name,
            at: DateTime.now(),
            title: title,
            detail: Value(detail),
          ),
        );
  }

  Future<List<EventView>> events(String subscriptionId) async {
    final rows = await (db.select(db.subscriptionEvents)
          ..where((t) => t.subscriptionId.equals(subscriptionId))
          ..orderBy([(t) => OrderingTerm.desc(t.at)]))
        .get();
    return rows
        .map(
          (e) => EventView(
            id: e.id,
            subscriptionId: e.subscriptionId,
            type: SubscriptionEventType.values.byName(e.type),
            at: e.at,
            title: e.title,
            detail: e.detail,
          ),
        )
        .toList();
  }

  Future<List<PriceHistoryView>> priceHistory(String subscriptionId) async {
    final rows = await (db.select(db.priceHistory)
          ..where((t) => t.subscriptionId.equals(subscriptionId))
          ..orderBy([(t) => OrderingTerm.asc(t.effectiveDate)]))
        .get();
    return rows
        .map(
          (e) => PriceHistoryView(
            id: e.id,
            subscriptionId: e.subscriptionId,
            oldPrice: e.oldPrice,
            newPrice: e.newPrice,
            currency: e.currency,
            effectiveDate: e.effectiveDate,
            reason: e.reason,
          ),
        )
        .toList();
  }

  Future<void> addPriceHistory({
    required String subscriptionId,
    required double oldPrice,
    required double newPrice,
    required String currency,
    required DateTime effectiveDate,
    required String reason,
  }) async {
    await db.into(db.priceHistory).insert(
          PriceHistoryCompanion.insert(
            id: _uuid.v4(),
            subscriptionId: subscriptionId,
            oldPrice: oldPrice,
            newPrice: newPrice,
            currency: currency,
            effectiveDate: effectiveDate,
            reason: reason,
          ),
        );
    await addEvent(subscriptionId, SubscriptionEventType.priceChanged, 'PRICE CHANGE',
        detail: '$oldPrice → $newPrice $currency');
  }

  Future<List<ReminderView>> remindersFor(String subscriptionId) async {
    final rows = await (db.select(db.reminders)..where((t) => t.subscriptionId.equals(subscriptionId))).get();
    return rows
        .map(
          (r) => ReminderView(
            id: r.id,
            subscriptionId: r.subscriptionId,
            kind: ReminderKind.values.byName(r.kind),
            offset: ReminderOffset.values.byName(r.offsetKind),
            customDays: r.customDays,
            fireAt: r.fireAt,
            enabled: r.enabled,
            notificationId: r.notificationId,
          ),
        )
        .toList();
  }

  Future<List<ReminderView>> allReminders() async {
    final rows = await db.select(db.reminders).get();
    return rows
        .map(
          (r) => ReminderView(
            id: r.id,
            subscriptionId: r.subscriptionId,
            kind: ReminderKind.values.byName(r.kind),
            offset: ReminderOffset.values.byName(r.offsetKind),
            customDays: r.customDays,
            fireAt: r.fireAt,
            enabled: r.enabled,
            notificationId: r.notificationId,
          ),
        )
        .toList();
  }

  Future<void> replaceReminders(String subscriptionId, List<RemindersCompanion> items) async {
    await (db.delete(db.reminders)..where((t) => t.subscriptionId.equals(subscriptionId))).go();
    for (final item in items) {
      await db.into(db.reminders).insert(item.copyWith(subscriptionId: Value(subscriptionId)));
    }
  }

  Future<void> deleteDemo() async {
    final demos = await (db.select(db.subscriptions)..where((t) => t.isDemo.equals(true))).get();
    for (final d in demos) {
      await (db.delete(db.reminders)..where((t) => t.subscriptionId.equals(d.id))).go();
      await (db.delete(db.pricePhases)..where((t) => t.subscriptionId.equals(d.id))).go();
      await (db.delete(db.paymentRecords)..where((t) => t.subscriptionId.equals(d.id))).go();
      await (db.delete(db.priceHistory)..where((t) => t.subscriptionId.equals(d.id))).go();
      await (db.delete(db.subscriptionEvents)..where((t) => t.subscriptionId.equals(d.id))).go();
      await (db.delete(db.subscriptions)..where((t) => t.id.equals(d.id))).go();
    }
  }
}
