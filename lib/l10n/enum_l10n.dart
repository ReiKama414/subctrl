import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/l10n/app_localizations.dart';

extension EnumL10n on AppLocalizations {
  String subscriptionStatus(SubscriptionStatus s) => switch (s) {
        SubscriptionStatus.active => t('statusActive'),
        SubscriptionStatus.trial => t('statusTrial'),
        SubscriptionStatus.promo => t('statusPromo'),
        SubscriptionStatus.cancelled => t('statusCancelled'),
        SubscriptionStatus.expired => t('statusExpired'),
        SubscriptionStatus.paused => t('statusPaused'),
      };

  String renewalIntentLabel(RenewalIntent v) => switch (v) {
        RenewalIntent.keep => t('intentKeep'),
        RenewalIntent.review => t('intentReview'),
        RenewalIntent.cancel => t('intentCancel'),
        RenewalIntent.undecided => t('intentUndecided'),
      };

  String usageFrequencyLabel(UsageFrequency v) => switch (v) {
        UsageFrequency.daily => t('usageDaily'),
        UsageFrequency.weekly => t('usageWeekly'),
        UsageFrequency.monthly => t('usageMonthly'),
        UsageFrequency.rarely => t('usageRarely'),
        UsageFrequency.notUsing => t('usageNotUsing'),
      };

  String billingCycleLabel(BillingCycle v) => switch (v) {
        BillingCycle.daily => t('cycleDaily'),
        BillingCycle.weekly => t('cycleWeekly'),
        BillingCycle.monthly => t('cycleMonthly'),
        BillingCycle.quarterly => t('cycleQuarterly'),
        BillingCycle.semiannual => t('cycleSemiannual'),
        BillingCycle.yearly => t('cycleYearly'),
        BillingCycle.custom => t('cycleCustom'),
      };

  String pricePhaseLabel(PricePhaseType v) => switch (v) {
        PricePhaseType.free => t('phaseFree'),
        PricePhaseType.promo => t('phasePromo'),
        PricePhaseType.regular => t('phaseRegular'),
        PricePhaseType.custom => t('phaseCustom'),
      };

  String subFilterLabel(SubFilter v) => switch (v) {
        SubFilter.all => t('filterAll'),
        SubFilter.active => t('filterActive'),
        SubFilter.trial => t('filterTrial'),
        SubFilter.promo => t('filterPromo'),
        SubFilter.cancelled => t('filterCancelled'),
        SubFilter.expired => t('filterExpired'),
      };

  String subscriptionSortLabel(SubscriptionSort v) => switch (v) {
        SubscriptionSort.nextBilling => t('sortNextBilling'),
        SubscriptionSort.statusActiveFirst => t('sortStatusActiveFirst'),
        SubscriptionSort.price => t('sortPrice'),
        SubscriptionSort.category => t('sortCategory'),
        SubscriptionSort.name => t('sortName'),
        SubscriptionSort.recentlyAdded => t('sortRecentlyAdded'),
        SubscriptionSort.renewalUrgency => t('sortRenewalUrgency'),
      };

  String categoryLabel(CategorySlug v) => switch (v) {
        CategorySlug.ai => t('catAi'),
        CategorySlug.video => t('catVideo'),
        CategorySlug.music => t('catMusic'),
        CategorySlug.gaming => t('catGaming'),
        CategorySlug.delivery => t('catDelivery'),
        CategorySlug.software => t('catSoftware'),
        CategorySlug.cloud => t('catCloud'),
        CategorySlug.social => t('catSocial'),
        CategorySlug.dating => t('catDating'),
        CategorySlug.shopping => t('catShopping'),
        CategorySlug.education => t('catEducation'),
        CategorySlug.fitness => t('catFitness'),
        CategorySlug.vpn => t('catVpn'),
        CategorySlug.news => t('catNews'),
        CategorySlug.developer => t('catDeveloper'),
        CategorySlug.other => t('catOther'),
      };

  String categorySlugLabel(String slug) {
    for (final c in CategorySlug.values) {
      if (c.name == slug) return categoryLabel(c);
    }
    return slug;
  }

  String chartRangeLabel(ChartRange v) => switch (v) {
        ChartRange.months3 => t('chart3m'),
        ChartRange.months6 => t('chart6m'),
        ChartRange.year1 => t('chart1y'),
        ChartRange.all => t('chartAll'),
      };

  String calendarEventKindLabel(String kind) => switch (kind) {
        'payment' => t('eventPayment'),
        'promoEnd' => t('eventPromoEnd'),
        'trialEnd' => t('eventTrialEnd'),
        'cancelDeadline' => t('eventCancelDeadline'),
        'priceChange' => t('eventPriceChange'),
        'expiry' => t('eventExpiry'),
        'orderExpected' => t('eventOrderExpected'),
        'orderReminder' => t('eventOrderReminder'),
        'orderDelivered' => t('eventOrderDelivered'),
        _ => kind,
      };

  String paymentMethodTypeLabel(PaymentMethodType v) => switch (v) {
        PaymentMethodType.visa => t('payVisa'),
        PaymentMethodType.mastercard => t('payMastercard'),
        PaymentMethodType.amex => t('payAmex'),
        PaymentMethodType.apple => t('payApple'),
        PaymentMethodType.googlePlay => t('payGooglePlay'),
        PaymentMethodType.paypal => t('payPaypal'),
        PaymentMethodType.other => t('payOther'),
      };

  String daysRemaining(int n) => t('daysRemaining').replaceAll('{0}', '$n');

  String offerKindLabel(OfferKind v) => switch (v) {
        OfferKind.none => offerNone,
        OfferKind.freePeriod => offerFreePeriod,
        OfferKind.discount => offerDiscount,
        OfferKind.multiStage => offerMultiStage,
        OfferKind.custom => offerCustom,
      };

  String reminderOffsetLabel(ReminderOffset v) => switch (v) {
        ReminderOffset.days30 => t('reminderDays30'),
        ReminderOffset.days14 => t('reminderDays14'),
        ReminderOffset.days7 => t('reminderDays7'),
        ReminderOffset.days3 => t('reminderDays3'),
        ReminderOffset.days1 => t('reminderDays1'),
        ReminderOffset.sameDay => t('reminderSameDay'),
        ReminderOffset.custom => t('reminderCustom'),
      };

  String subscriptionEventTitle(SubscriptionEventType v) => switch (v) {
        SubscriptionEventType.created => t('eventCreated'),
        SubscriptionEventType.planChanged => t('eventPlanChanged'),
        SubscriptionEventType.priceChanged => t('eventPriceChanged'),
        SubscriptionEventType.priceReviewed => t('eventPriceReviewed'),
        SubscriptionEventType.promoStarted => t('eventPromoStarted'),
        SubscriptionEventType.promoEnded => t('eventPromoEnded'),
        SubscriptionEventType.trialStarted => t('eventTrialStarted'),
        SubscriptionEventType.trialEnded => t('eventTrialEnded'),
        SubscriptionEventType.payment => t('eventPayment'),
        SubscriptionEventType.renewed => t('eventRenewed'),
        SubscriptionEventType.paused => t('eventPaused'),
        SubscriptionEventType.resumed => t('eventResumed'),
        SubscriptionEventType.cancelRequested => t('eventCancelRequested'),
        SubscriptionEventType.cancelled => t('eventCancelled'),
        SubscriptionEventType.expired => t('eventExpired'),
        SubscriptionEventType.reactivated => t('eventReactivated'),
      };

  String get actionFreePeriod => t('actionFreePeriod');
  String get actionPriceReview => t('actionPriceReview');
  String get actionPromoEnds => t('actionPromoEnds');
  String get actionCancelDeadline => t('actionCancelDeadline');
  String get actionFirstCharge => t('actionFirstCharge');
  String get actionCardExpiry => t('actionCardExpiry');

  String purchaseStatusLabel(PurchaseStatus v) => switch (v) {
        PurchaseStatus.ordered => t('purchaseOrdered'),
        PurchaseStatus.preorder => t('purchasePreorder'),
        PurchaseStatus.awaitingShipment => t('purchaseAwaitingShipment'),
        PurchaseStatus.shipped => t('purchaseShipped'),
        PurchaseStatus.delivered => t('purchaseDelivered'),
        PurchaseStatus.cancelled => t('purchaseCancelled'),
      };
}
