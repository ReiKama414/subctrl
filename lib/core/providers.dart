import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:subctrl/core/constants/enums.dart';
import 'package:subctrl/core/services/auth_service.dart';
import 'package:subctrl/core/services/export_service.dart';
import 'package:subctrl/core/services/fx_service.dart';
import 'package:subctrl/core/services/notification_service.dart';
import 'package:subctrl/core/services/security_service.dart';
import 'package:subctrl/core/services/service_logo.dart';
import 'package:subctrl/core/utils/forecast_engine.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:subctrl/data/models/views.dart';
import 'package:subctrl/data/repositories/catalog_repository.dart';
import 'package:subctrl/data/repositories/purchase_repository.dart';
import 'package:subctrl/data/repositories/subscription_repository.dart';
import 'package:subctrl/data/seed/bootstrap.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  throw StateError('databaseProvider must be overridden in main()');
});

final bootstrapProvider = Provider((ref) => BootstrapService(ref.watch(databaseProvider)));
final subscriptionRepoProvider = Provider((ref) => SubscriptionRepository(ref.watch(databaseProvider)));
final purchaseRepoProvider = Provider((ref) => PurchaseRepository(ref.watch(databaseProvider)));
final catalogRepoProvider = Provider((ref) => CatalogRepository(ref.watch(databaseProvider)));
final financeRepoProvider = Provider((ref) => FinanceRepository(ref.watch(databaseProvider)));
final settingsRepoProvider = Provider((ref) => SettingsRepository(ref.watch(databaseProvider)));
final authServiceProvider = Provider((ref) => AuthService());
final notificationServiceProvider = Provider((ref) => NotificationService());
final securityServiceProvider = Provider((ref) => SecurityService());
final fxServiceProvider = Provider((ref) => FxService(ref.watch(financeRepoProvider), ref.watch(settingsRepoProvider)));
final exportServiceProvider = Provider(
  (ref) => ExportService(ref.watch(databaseProvider), ref.watch(subscriptionRepoProvider), ref.watch(financeRepoProvider)),
);
final syncServiceProvider = Provider((ref) => SyncService(ref.watch(exportServiceProvider)));
final logoResolverProvider = Provider((ref) => const ServiceLogoResolver());

final preferencesProvider = StreamProvider<PreferenceView>((ref) {
  return ref.watch(settingsRepoProvider).watch();
});

final subscriptionsProvider = StreamProvider<List<SubscriptionView>>((ref) {
  return ref.watch(subscriptionRepoProvider).watchAll();
});

final profilesProvider = FutureProvider((ref) {
  ref.watch(preferencesProvider);
  return ref.watch(settingsRepoProvider).profiles();
});

final budgetsProvider = FutureProvider((ref) {
  ref.watch(preferencesProvider);
  ref.watch(subscriptionsProvider);
  return ref.watch(financeRepoProvider).budgets();
});

/// null = all profiles
final activeProfileIdProvider = Provider<String?>((ref) {
  return ref.watch(preferencesProvider).valueOrNull?.activeProfileId;
});

final scopedSubscriptionsProvider = Provider<List<SubscriptionView>>((ref) {
  final all = ref.watch(subscriptionsProvider).valueOrNull ?? [];
  final profileId = ref.watch(activeProfileIdProvider);
  if (profileId == null || profileId.isEmpty) return all;
  return all.where((s) => s.profileId == profileId).toList();
});

final purchaseOrdersProvider = StreamProvider<List<PurchaseOrderView>>((ref) {
  return ref.watch(purchaseRepoProvider).watchAll();
});

final scopedPurchaseOrdersProvider = Provider<List<PurchaseOrderView>>((ref) {
  final all = ref.watch(purchaseOrdersProvider).valueOrNull ?? [];
  final profileId = ref.watch(activeProfileIdProvider);
  if (profileId == null || profileId.isEmpty) return all;
  return all.where((o) => o.profileId == profileId).toList();
});

final pendingPurchaseOrdersProvider = Provider<List<PurchaseOrderView>>((ref) {
  return ref.watch(scopedPurchaseOrdersProvider).where((o) => o.isPending).toList();
});

final servicesProvider = FutureProvider<List<ServiceView>>((ref) {
  ref.watch(subscriptionsProvider);
  return ref.watch(catalogRepoProvider).services();
});

final paymentMethodsProvider = FutureProvider((ref) {
  ref.watch(subscriptionsProvider);
  return ref.watch(financeRepoProvider).methods();
});

final ratesProvider = FutureProvider<Map<String, double>>((ref) {
  ref.watch(preferencesProvider);
  return ref.watch(financeRepoProvider).rates();
});

final currencyEngineProvider = Provider<CurrencyEngine>((ref) {
  final prefs = ref.watch(preferencesProvider).valueOrNull;
  final rates = ref.watch(ratesProvider).valueOrNull ?? {};
  return CurrencyEngine(
    ratesVsUsd: rates.isEmpty ? {'USD': 1, 'TWD': 32.6} : rates,
    baseCurrency: prefs?.baseCurrency ?? 'TWD',
    feePercent: prefs?.foreignFeePercent ?? 0,
    updatedAt: prefs?.ratesUpdatedAt,
    lastError: prefs?.lastFxError,
  );
});

final identitiesProvider = FutureProvider((ref) {
  ref.watch(preferencesProvider);
  return ref.watch(settingsRepoProvider).identities();
});

final unlockedProvider = StateProvider<bool>((ref) => true);

/// null = follow device locale
final appLocaleProvider = Provider<Locale?>((ref) {
  final code = ref.watch(preferencesProvider).valueOrNull?.localeCode ?? 'system';
  return switch (code) {
    'en' => const Locale('en'),
    'zh_TW' || 'zh' => const Locale('zh', 'TW'),
    'ja' => const Locale('ja'),
    _ => null,
  };
});

class SessionController extends StateNotifier<AuthSession> {
  SessionController() : super(const AuthSession(accountId: accountId, providers: {'guest'}));

  void setProviders(Set<String> providers, {String? name, String? email}) {
    state = AuthSession(accountId: accountId, providers: providers, displayName: name, email: email);
  }
}

final sessionProvider = StateNotifierProvider<SessionController, AuthSession>((ref) => SessionController());

enum SubFilter { all, active, trial, promo, cancelled, expired }

class SubListQuery {
  const SubListQuery({
    this.filter = SubFilter.all,
    this.category,
    this.search = '',
    this.sort = SubscriptionSort.nextBilling,
    this.profileId,
  });

  final SubFilter filter;
  final String? category;
  final String search;
  final SubscriptionSort sort;
  final String? profileId;

  SubListQuery copyWith({
    SubFilter? filter,
    String? category,
    String? search,
    SubscriptionSort? sort,
    String? profileId,
    bool clearCategory = false,
    bool clearProfile = false,
  }) {
    return SubListQuery(
      filter: filter ?? this.filter,
      category: clearCategory ? null : (category ?? this.category),
      search: search ?? this.search,
      sort: sort ?? this.sort,
      profileId: clearProfile ? null : (profileId ?? this.profileId),
    );
  }
}

final subListQueryProvider = StateProvider<SubListQuery>((ref) => const SubListQuery());
