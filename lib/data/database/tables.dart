import 'package:drift/drift.dart';

class UserAccounts extends Table {
  TextColumn get id => text()();
  TextColumn get displayName => text().withDefault(const Constant('Local'))();
  DateTimeColumn get createdAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

class LinkedIdentities extends Table {
  TextColumn get id => text()();
  TextColumn get accountId => text()();
  TextColumn get provider => text()();
  TextColumn get providerUserId => text().nullable()();
  TextColumn get email => text().nullable()();
  TextColumn get displayName => text().nullable()();
  DateTimeColumn get linkedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}

class UserProfiles extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get type => text()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
  @override
  Set<Column> get primaryKey => {id};
}

class Categories extends Table {
  TextColumn get id => text()();
  TextColumn get slug => text()();
  TextColumn get name => text()();
  IntColumn get sortOrder => integer()();
  @override
  Set<Column> get primaryKey => {id};
}

class Services extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get categoryId => text()();
  TextColumn get logoKey => text().nullable()();
  TextColumn get officialWebsiteUrl => text().nullable()();
  TextColumn get manageSubscriptionUrl => text().nullable()();
  BoolColumn get isCustom => boolean().withDefault(const Constant(false))();
  BoolColumn get isBuiltin => boolean().withDefault(const Constant(true))();
  @override
  Set<Column> get primaryKey => {id};
}

class Plans extends Table {
  TextColumn get id => text()();
  TextColumn get serviceId => text()();
  TextColumn get name => text()();
  TextColumn get billingCycle => text()();
  RealColumn get suggestedPrice => real().nullable()();
  TextColumn get suggestedCurrency => text().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

class PaymentMethods extends Table {
  TextColumn get id => text()();
  TextColumn get label => text()();
  TextColumn get type => text()();
  TextColumn get brand => text()();
  TextColumn get last4 => text().nullable()();
  DateTimeColumn get expiry => dateTime().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

class Subscriptions extends Table {
  TextColumn get id => text()();
  TextColumn get serviceId => text()();
  TextColumn get planId => text().nullable()();
  TextColumn get categoryId => text()();
  TextColumn get profileId => text()();
  TextColumn get status => text()();
  BoolColumn get active => boolean().withDefault(const Constant(true))();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get nextBillingDate => dateTime().nullable()();
  DateTimeColumn get accessEndDate => dateTime().nullable()();
  BoolColumn get autoRenew => boolean().withDefault(const Constant(true))();
  TextColumn get currency => text()();
  RealColumn get currentPrice => real()();
  TextColumn get billingCycle => text()();
  IntColumn get customCycleDays => integer().nullable()();
  TextColumn get paymentMethodId => text().nullable()();
  TextColumn get renewalIntent => text()();
  TextColumn get usageFrequency => text()();
  IntColumn get usageCountPerMonth => integer().nullable()();
  TextColumn get officialWebsiteUrl => text().nullable()();
  TextColumn get manageSubscriptionUrl => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isDemo => boolean().withDefault(const Constant(false))();
  @override
  Set<Column> get primaryKey => {id};
}

class PricePhases extends Table {
  TextColumn get id => text()();
  TextColumn get subscriptionId => text()();
  TextColumn get type => text()();
  DateTimeColumn get startDate => dateTime()();
  DateTimeColumn get endDate => dateTime().nullable()();
  RealColumn get price => real()();
  TextColumn get currency => text()();
  TextColumn get billingCycle => text()();
  RealColumn get regularPrice => real().nullable()();
  TextColumn get regularCurrency => text().nullable()();
  TextColumn get promotionName => text().nullable()();
  DateTimeColumn get cancelDeadline => dateTime().nullable()();
  DateTimeColumn get firstChargeDate => dateTime().nullable()();
  DateTimeColumn get trialEndDate => dateTime().nullable()();
  DateTimeColumn get reminderDate => dateTime().nullable()();
  BoolColumn get autoRenew => boolean().withDefault(const Constant(true))();
  IntColumn get sortOrder => integer().withDefault(const Constant(0))();
  @override
  Set<Column> get primaryKey => {id};
}

class PaymentRecords extends Table {
  TextColumn get id => text()();
  TextColumn get subscriptionId => text()();
  DateTimeColumn get date => dateTime()();
  RealColumn get originalAmount => real()();
  TextColumn get originalCurrency => text()();
  RealColumn get exchangeRate => real()();
  RealColumn get convertedAmount => real()();
  TextColumn get baseCurrency => text()();
  RealColumn get foreignFee => real()();
  RealColumn get actualChargedAmount => real()();
  TextColumn get paymentMethodId => text().nullable()();
  TextColumn get note => text().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

class PriceHistory extends Table {
  TextColumn get id => text()();
  TextColumn get subscriptionId => text()();
  RealColumn get oldPrice => real()();
  RealColumn get newPrice => real()();
  TextColumn get currency => text()();
  DateTimeColumn get effectiveDate => dateTime()();
  TextColumn get reason => text()();
  @override
  Set<Column> get primaryKey => {id};
}

class SubscriptionEvents extends Table {
  TextColumn get id => text()();
  TextColumn get subscriptionId => text()();
  TextColumn get type => text()();
  DateTimeColumn get at => dateTime()();
  TextColumn get title => text()();
  TextColumn get detail => text().nullable()();
  @override
  Set<Column> get primaryKey => {id};
}

class Reminders extends Table {
  TextColumn get id => text()();
  TextColumn get subscriptionId => text()();
  TextColumn get kind => text()();
  TextColumn get offsetKind => text()();
  IntColumn get customDays => integer().nullable()();
  DateTimeColumn get fireAt => dateTime()();
  BoolColumn get enabled => boolean().withDefault(const Constant(true))();
  IntColumn get notificationId => integer()();
  @override
  Set<Column> get primaryKey => {id};
}

class CurrencyRates extends Table {
  TextColumn get code => text()();
  RealColumn get unitsPerUsd => real()();
  DateTimeColumn get updatedAt => dateTime()();
  BoolColumn get isManual => boolean().withDefault(const Constant(false))();
  @override
  Set<Column> get primaryKey => {code};
}

class Budgets extends Table {
  TextColumn get id => text()();
  TextColumn get scope => text()();
  TextColumn get categoryId => text().nullable()();
  TextColumn get profileId => text().nullable()();
  RealColumn get monthlyAmount => real()();
  TextColumn get currency => text()();
  @override
  Set<Column> get primaryKey => {id};
}

class UserPreferences extends Table {
  TextColumn get id => text()();
  TextColumn get baseCurrency => text()();
  RealColumn get foreignFeePercent => real()();
  TextColumn get themePreset => text()();
  TextColumn get customThemeJson => text().nullable()();
  BoolColumn get reduceMotion => boolean().withDefault(const Constant(false))();
  BoolColumn get biometricLock => boolean().withDefault(const Constant(false))();
  BoolColumn get hideAmounts => boolean().withDefault(const Constant(false))();
  IntColumn get cancelSafetyBufferDays => integer().withDefault(const Constant(2))();
  BoolColumn get onboardingComplete => boolean().withDefault(const Constant(false))();
  BoolColumn get demoSeedEnabled => boolean().withDefault(const Constant(false))();
  TextColumn get activeProfileId => text().nullable()();
  DateTimeColumn get ratesUpdatedAt => dateTime().nullable()();
  TextColumn get lastFxError => text().nullable()();
  /// system | en | zh_TW | ja
  TextColumn get localeCode => text().withDefault(const Constant('system'))();
  @override
  Set<Column> get primaryKey => {id};
}

class AppThemeRows extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get json => text()();
  @override
  Set<Column> get primaryKey => {id};
}

/// Shop / marketplace purchase & preorder tracking (Taobao, PLUSHSHOP, etc.).
class PurchaseOrders extends Table {
  TextColumn get id => text()();
  TextColumn get profileId => text()();
  /// Shop / platform display name (e.g. Taobao, PLUSHSHOP).
  TextColumn get platform => text()();
  TextColumn get title => text()();
  IntColumn get quantity => integer().withDefault(const Constant(1))();
  /// ordered | preorder | awaitingShipment | shipped | delivered | cancelled
  TextColumn get status => text()();
  DateTimeColumn get orderedAt => dateTime()();
  DateTimeColumn get expectedAt => dateTime().nullable()();
  DateTimeColumn get deliveredAt => dateTime().nullable()();
  DateTimeColumn get reminderAt => dateTime().nullable()();
  RealColumn get price => real().nullable()();
  TextColumn get currency => text().nullable()();
  TextColumn get trackingUrl => text().nullable()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  @override
  Set<Column> get primaryKey => {id};
}
