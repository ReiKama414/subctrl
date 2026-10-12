import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/data/models/views.dart';

SubscriptionView sampleSub({
  String id = 's1',
  String name = 'ChatGPT',
  SubscriptionStatus status = SubscriptionStatus.active,
  double price = 20,
  String currency = 'USD',
  String cycle = 'monthly',
  DateTime? next,
  DateTime? start,
  List<PhaseView> phases = const [],
  bool autoRenew = true,
  DateTime? accessEnd,
}) {
  final s = start ?? DateTime(2026, 1, 1);
  return SubscriptionView(
    id: id,
    serviceId: 'chatgpt',
    serviceName: name,
    categoryId: 'ai',
    categorySlug: 'ai',
    profileId: 'profile-personal',
    status: status,
    startDate: s,
    nextBillingDate: next ?? DateTime(2026, 11, 1),
    accessEndDate: accessEnd,
    autoRenew: autoRenew,
    currency: currency,
    currentPrice: price,
    billingCycle: cycle,
    renewalIntent: RenewalIntent.undecided,
    usageFrequency: UsageFrequency.monthly,
    createdAt: s,
    updatedAt: s,
    phases: phases,
  );
}
