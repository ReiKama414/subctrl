import 'package:subctrl/core/constants/enums.dart';

class PhaseView {
  const PhaseView({
    required this.id,
    required this.subscriptionId,
    required this.type,
    required this.startDate,
    this.endDate,
    required this.price,
    required this.currency,
    required this.billingCycle,
    this.regularPrice,
    this.regularCurrency,
    this.promotionName,
    this.cancelDeadline,
    this.firstChargeDate,
    this.trialEndDate,
    this.reminderDate,
    this.autoRenew = true,
  });

  final String id;
  final String subscriptionId;
  final PricePhaseType type;
  final DateTime startDate;
  final DateTime? endDate;
  final double price;
  final String currency;
  final String billingCycle;
  final double? regularPrice;
  final String? regularCurrency;
  final String? promotionName;
  final DateTime? cancelDeadline;
  final DateTime? firstChargeDate;
  final DateTime? trialEndDate;
  final DateTime? reminderDate;
  final bool autoRenew;
}

class SubscriptionView {
  const SubscriptionView({
    required this.id,
    required this.serviceId,
    required this.serviceName,
    this.planId,
    this.planName,
    required this.categoryId,
    required this.categorySlug,
    required this.profileId,
    required this.status,
    required this.startDate,
    this.nextBillingDate,
    this.accessEndDate,
    required this.autoRenew,
    required this.currency,
    required this.currentPrice,
    required this.billingCycle,
    this.customCycleDays,
    this.paymentMethodId,
    required this.renewalIntent,
    required this.usageFrequency,
    this.usageCountPerMonth,
    this.officialWebsiteUrl,
    this.manageSubscriptionUrl,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.phases = const [],
    this.logoKey,
  });

  final String id;
  final String serviceId;
  final String serviceName;
  final String? planId;
  final String? planName;
  final String categoryId;
  final String categorySlug;
  final String profileId;
  final SubscriptionStatus status;
  final DateTime startDate;
  final DateTime? nextBillingDate;
  final DateTime? accessEndDate;
  final bool autoRenew;
  final String currency;
  final double currentPrice;
  final String billingCycle;
  final int? customCycleDays;
  final String? paymentMethodId;
  final RenewalIntent renewalIntent;
  final UsageFrequency usageFrequency;
  final int? usageCountPerMonth;
  final String? officialWebsiteUrl;
  final String? manageSubscriptionUrl;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<PhaseView> phases;
  final String? logoKey;

  bool get isBillable =>
      status == SubscriptionStatus.active ||
      status == SubscriptionStatus.trial ||
      status == SubscriptionStatus.promo ||
      (status == SubscriptionStatus.cancelled &&
          accessEndDate != null &&
          accessEndDate!.isAfter(DateTime.now()));

  /// Price in effect today (0 during a free year, promo price during a discount).
  double get displayedPrice => currentPhase?.price ?? currentPrice;

  /// Free / promo phase whose end is today or already past.
  PhaseView? endedOfferPhase({DateTime? now}) {
    final n = now ?? DateTime.now();
    final today = DateTime(n.year, n.month, n.day);
    PhaseView? found;
    for (final p in phases) {
      if (p.type != PricePhaseType.free && p.type != PricePhaseType.promo) continue;
      final end = p.trialEndDate ?? p.endDate;
      if (end == null) continue;
      final day = DateTime(end.year, end.month, end.day);
      if (!day.isAfter(today)) found = p;
    }
    return found;
  }

  /// True until the user confirms the resume price after a free / promo period.
  bool needsPriceReview({DateTime? now}) {
    if (status != SubscriptionStatus.trial && status != SubscriptionStatus.promo) {
      return false;
    }
    return endedOfferPhase(now: now) != null;
  }

  /// Regular price to resume at, falling back to the stored list price.
  double proposedResumePrice({DateTime? now}) {
    final offer = endedOfferPhase(now: now);
    final listed = offer?.regularPrice ?? currentPrice;
    return listed > 0 ? listed : currentPrice;
  }

  PhaseView? phaseOn(DateTime date) {
    final day = DateTime(date.year, date.month, date.day);
    final matches = phases.where((p) {
      final start = DateTime(p.startDate.year, p.startDate.month, p.startDate.day);
      final end = p.endDate == null
          ? null
          : DateTime(p.endDate!.year, p.endDate!.month, p.endDate!.day);
      return !day.isBefore(start) && (end == null || !day.isAfter(end));
    }).toList();
    if (matches.isEmpty) return null;
    matches.sort((a, b) => a.startDate.compareTo(b.startDate));
    return matches.last;
  }

  PhaseView? get currentPhase => phaseOn(DateTime.now());
}

class PaymentView {
  const PaymentView({
    required this.id,
    required this.subscriptionId,
    required this.date,
    required this.originalAmount,
    required this.originalCurrency,
    required this.exchangeRate,
    required this.convertedAmount,
    required this.baseCurrency,
    required this.foreignFee,
    required this.actualChargedAmount,
    this.paymentMethodId,
    this.note,
  });

  final String id;
  final String subscriptionId;
  final DateTime date;
  final double originalAmount;
  final String originalCurrency;
  final double exchangeRate;
  final double convertedAmount;
  final String baseCurrency;
  final double foreignFee;
  final double actualChargedAmount;
  final String? paymentMethodId;
  final String? note;
}

class PriceHistoryView {
  const PriceHistoryView({
    required this.id,
    required this.subscriptionId,
    required this.oldPrice,
    required this.newPrice,
    required this.currency,
    required this.effectiveDate,
    required this.reason,
  });

  final String id;
  final String subscriptionId;
  final double oldPrice;
  final double newPrice;
  final String currency;
  final DateTime effectiveDate;
  final String reason;
}

class EventView {
  const EventView({
    required this.id,
    required this.subscriptionId,
    required this.type,
    required this.at,
    required this.title,
    this.detail,
  });

  final String id;
  final String subscriptionId;
  final SubscriptionEventType type;
  final DateTime at;
  final String title;
  final String? detail;
}

class ReminderView {
  const ReminderView({
    required this.id,
    required this.subscriptionId,
    required this.kind,
    required this.offset,
    this.customDays,
    required this.fireAt,
    required this.enabled,
    required this.notificationId,
  });

  final String id;
  final String subscriptionId;
  final ReminderKind kind;
  final ReminderOffset offset;
  final int? customDays;
  final DateTime fireAt;
  final bool enabled;
  final int notificationId;
}

class PaymentMethodView {
  const PaymentMethodView({
    required this.id,
    required this.label,
    required this.type,
    required this.brand,
    this.last4,
    this.expiry,
  });

  final String id;
  final String label;
  final PaymentMethodType type;
  final String brand;
  final String? last4;
  final DateTime? expiry;

  String get display {
    if (last4 != null && last4!.isNotEmpty) return '$brand ••$last4';
    return label;
  }
}

class ServiceView {
  const ServiceView({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.categorySlug,
    this.logoKey,
    this.officialWebsiteUrl,
    this.manageSubscriptionUrl,
    this.isCustom = false,
    this.plans = const [],
  });

  final String id;
  final String name;
  final String categoryId;
  final String categorySlug;
  final String? logoKey;
  final String? officialWebsiteUrl;
  final String? manageSubscriptionUrl;
  final bool isCustom;
  final List<PlanView> plans;
}

class PlanView {
  const PlanView({
    required this.id,
    required this.serviceId,
    required this.name,
    required this.billingCycle,
    this.suggestedPrice,
    this.suggestedCurrency,
  });

  final String id;
  final String serviceId;
  final String name;
  final String billingCycle;
  final double? suggestedPrice;
  final String? suggestedCurrency;
}

class PreferenceView {
  const PreferenceView({
    required this.baseCurrency,
    required this.foreignFeePercent,
    required this.themePreset,
    this.customThemeJson,
    required this.reduceMotion,
    required this.biometricLock,
    required this.hideAmounts,
    required this.cancelSafetyBufferDays,
    required this.onboardingComplete,
    required this.demoSeedEnabled,
    this.activeProfileId,
    this.ratesUpdatedAt,
    this.lastFxError,
    this.localeCode = 'system',
    this.notificationsEnabled = true,
    this.cloudAutoDownload = true,
    this.cloudAutoUpload = false,
  });

  final String baseCurrency;
  final double foreignFeePercent;
  final String themePreset;
  final String? customThemeJson;
  final bool reduceMotion;
  final bool biometricLock;
  final bool hideAmounts;
  final int cancelSafetyBufferDays;
  final bool onboardingComplete;
  final bool demoSeedEnabled;
  final String? activeProfileId;
  final DateTime? ratesUpdatedAt;
  final String? lastFxError;
  final String localeCode;
  final bool notificationsEnabled;
  final bool cloudAutoDownload;
  final bool cloudAutoUpload;
}
