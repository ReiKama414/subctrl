enum SubscriptionStatus {
  active,
  trial,
  promo,
  cancelled,
  expired,
  paused;

  String get label => name.toUpperCase();
}

enum RenewalIntent {
  keep,
  review,
  cancel,
  undecided;

  String get label => switch (this) {
    RenewalIntent.keep => 'KEEP',
    RenewalIntent.review => 'REVIEW',
    RenewalIntent.cancel => 'CANCEL',
    RenewalIntent.undecided => 'UNDECIDED',
  };
}

enum UsageFrequency {
  daily,
  weekly,
  monthly,
  rarely,
  notUsing;

  String get label => switch (this) {
    UsageFrequency.daily => 'DAILY',
    UsageFrequency.weekly => 'WEEKLY',
    UsageFrequency.monthly => 'MONTHLY',
    UsageFrequency.rarely => 'RARELY',
    UsageFrequency.notUsing => 'NOT USING',
  };
}

enum BillingCycle {
  daily,
  weekly,
  monthly,
  quarterly,
  semiannual,
  yearly,
  custom;

  String get label => name.toUpperCase();

  int get monthsEquivalent => switch (this) {
    BillingCycle.daily => 0,
    BillingCycle.weekly => 0,
    BillingCycle.monthly => 1,
    BillingCycle.quarterly => 3,
    BillingCycle.semiannual => 6,
    BillingCycle.yearly => 12,
    BillingCycle.custom => 1,
  };
}

enum PricePhaseType {
  free,
  promo,
  regular,
  custom;

  String get label => name.toUpperCase();
}

enum ReminderKind {
  upcomingRenewal,
  cancelDeadline,
  trialEnd,
  promoEnd,
  firstCharge,
  priceChange,
  annualRenewal,
  paymentMethodExpiry,
  subscriptionExpiry;

  String get label => switch (this) {
    ReminderKind.upcomingRenewal => 'UPCOMING RENEWAL',
    ReminderKind.cancelDeadline => 'CANCEL DEADLINE',
    ReminderKind.trialEnd => 'TRIAL END',
    ReminderKind.promoEnd => 'PROMO END',
    ReminderKind.firstCharge => 'FIRST CHARGE',
    ReminderKind.priceChange => 'PRICE CHANGE',
    ReminderKind.annualRenewal => 'ANNUAL RENEWAL',
    ReminderKind.paymentMethodExpiry => 'PAYMENT METHOD EXPIRY',
    ReminderKind.subscriptionExpiry => 'SUBSCRIPTION EXPIRY',
  };
}

enum ReminderOffset {
  days30,
  days14,
  days7,
  days3,
  days1,
  sameDay,
  custom;

  int? get days => switch (this) {
    ReminderOffset.days30 => 30,
    ReminderOffset.days14 => 14,
    ReminderOffset.days7 => 7,
    ReminderOffset.days3 => 3,
    ReminderOffset.days1 => 1,
    ReminderOffset.sameDay => 0,
    ReminderOffset.custom => null,
  };

  String get label => switch (this) {
    ReminderOffset.days30 => '30 days',
    ReminderOffset.days14 => '14 days',
    ReminderOffset.days7 => '7 days',
    ReminderOffset.days3 => '3 days',
    ReminderOffset.days1 => '1 day',
    ReminderOffset.sameDay => 'same day',
    ReminderOffset.custom => 'custom',
  };
}

enum SubscriptionEventType {
  created,
  planChanged,
  priceChanged,
  promoStarted,
  promoEnded,
  trialStarted,
  trialEnded,
  payment,
  renewed,
  paused,
  resumed,
  cancelRequested,
  cancelled,
  expired,
  reactivated;
}

enum CalendarEventKind {
  payment,
  promoEnd,
  trialEnd,
  cancelDeadline,
  priceChange,
  expiry;
}

enum PaymentMethodType {
  visa,
  mastercard,
  amex,
  apple,
  googlePlay,
  paypal,
  other;

  String get label => switch (this) {
    PaymentMethodType.visa => 'Visa',
    PaymentMethodType.mastercard => 'Mastercard',
    PaymentMethodType.amex => 'Amex',
    PaymentMethodType.apple => 'Apple',
    PaymentMethodType.googlePlay => 'Google Play',
    PaymentMethodType.paypal => 'PayPal',
    PaymentMethodType.other => 'Other',
  };
}

enum ProfileType {
  personal,
  work,
  family,
  custom;
}

enum ThemePreset {
  voidTheme,
  terminal,
  akira,
  ice,
  light,
  custom;

  String get label => switch (this) {
    ThemePreset.voidTheme => 'VOID',
    ThemePreset.terminal => 'TERMINAL',
    ThemePreset.akira => 'AKIRA',
    ThemePreset.ice => 'ICE',
    ThemePreset.light => 'LIGHT',
    ThemePreset.custom => 'CUSTOM',
  };
}

enum AuthProviderId {
  google,
  line,
  guest;
}

enum OfferKind {
  none,
  freePeriod,
  discount,
  multiStage,
  custom;
}

enum CategorySlug {
  ai,
  video,
  music,
  gaming,
  delivery,
  software,
  cloud,
  social,
  dating,
  shopping,
  education,
  fitness,
  vpn,
  news,
  developer,
  other;

  String get label => switch (this) {
    CategorySlug.ai => 'AI',
    CategorySlug.video => 'VIDEO',
    CategorySlug.music => 'MUSIC',
    CategorySlug.gaming => 'GAMING',
    CategorySlug.delivery => 'DELIVERY',
    CategorySlug.software => 'SOFTWARE',
    CategorySlug.cloud => 'CLOUD',
    CategorySlug.social => 'SOCIAL',
    CategorySlug.dating => 'DATING',
    CategorySlug.shopping => 'SHOPPING',
    CategorySlug.education => 'EDUCATION',
    CategorySlug.fitness => 'FITNESS',
    CategorySlug.vpn => 'VPN',
    CategorySlug.news => 'NEWS',
    CategorySlug.developer => 'DEVELOPER',
    CategorySlug.other => 'OTHER',
  };
}

enum ChartRange { months3, months6, year1, all }

/// Purchase / preorder progress for shops & marketplaces.
enum PurchaseStatus {
  ordered,
  preorder,
  awaitingShipment,
  shipped,
  delivered,
  cancelled;

  bool get isPending =>
      this == PurchaseStatus.ordered ||
      this == PurchaseStatus.preorder ||
      this == PurchaseStatus.awaitingShipment ||
      this == PurchaseStatus.shipped;

  bool get isPreorderLike =>
      this == PurchaseStatus.preorder || this == PurchaseStatus.awaitingShipment;
}

/// Suggested shop / platform names (user can still type custom).
const purchasePlatformPresets = [
  'Taobao',
  'PLUSHSHOP',
  'Mercari',
  'Amazon',
  'Shopee',
  'Yahoo Auction',
  'Other',
];

enum SubscriptionSort {
  nextBilling,
  price,
  category,
  name,
  recentlyAdded,
  renewalUrgency,
}
