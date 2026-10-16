import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/features/add_subscription/add_subscription_screen.dart';
import 'package:subctrl/features/analytics/data_screen.dart';
import 'package:subctrl/features/analytics/simulator_screen.dart';
import 'package:subctrl/features/analytics/year_review_screen.dart';
import 'package:subctrl/features/auth/boot_screen.dart';
import 'package:subctrl/features/auth/login_screen.dart';
import 'package:subctrl/features/calendar/calendar_screen.dart';
import 'package:subctrl/features/home/home_screen.dart';
import 'package:subctrl/features/onboarding/onboarding_screen.dart';
import 'package:subctrl/features/orders/add_order_screen.dart';
import 'package:subctrl/features/orders/order_detail_screen.dart';
import 'package:subctrl/features/orders/orders_screen.dart';
import 'package:subctrl/features/settings/budget_screen.dart';
import 'package:subctrl/features/settings/payment_methods_screen.dart';
import 'package:subctrl/features/settings/settings_screen.dart';
import 'package:subctrl/features/subscriptions/detail_screen.dart';
import 'package:subctrl/features/subscriptions/subscriptions_screen.dart';
import 'package:subctrl/shared/widgets/shell.dart';

/// Notifies [GoRouter] when auth / onboarding prefs change.
class _RouterRefresh extends ChangeNotifier {
  void bump() => notifyListeners();
}

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = _RouterRefresh();
  ref.listen(preferencesProvider, (_, _) => refresh.bump());
  ref.listen(identitiesProvider, (_, _) {
    final ids = ref.read(identitiesProvider).valueOrNull;
    if (ids != null && ids.isNotEmpty) {
      ref.read(sessionProvider.notifier).setProviders(
            ids.map((e) => e.provider).toSet(),
            name: ids.first.displayName,
            email: ids.first.email,
          );
    }
    refresh.bump();
  });
  ref.onDispose(refresh.dispose);

  return GoRouter(
    // Never open /login until we know session state — avoids tofu login flash.
    initialLocation: '/boot',
    refreshListenable: refresh,
    redirect: (context, state) {
      final prefs = ref.read(preferencesProvider).valueOrNull;
      final ids = ref.read(identitiesProvider).valueOrNull;
      final loc = state.matchedLocation;
      final atBoot = loc == '/boot';

      if (prefs == null || ids == null) {
        return atBoot ? null : '/boot';
      }

      final signedIn = ids.isNotEmpty;
      final onboarded = prefs.onboardingComplete;
      final dest = !signedIn
          ? '/login'
          : !onboarded
              ? '/onboarding'
              : '/home';

      if (atBoot) return dest;

      final atLogin = loc == '/login';
      final atOnboarding = loc == '/onboarding';

      if (!signedIn) return atLogin ? null : '/login';
      if (!onboarded) return atOnboarding ? null : '/onboarding';
      if (atLogin || atOnboarding) return '/home';
      return null;
    },
    routes: [
      GoRoute(path: '/boot', builder: (c, s) => const BootScreen()),
      GoRoute(path: '/login', builder: (c, s) => const LoginScreen()),
      GoRoute(path: '/onboarding', builder: (c, s) => const OnboardingScreen()),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(routes: [GoRoute(path: '/home', builder: (c, s) => const HomeScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: '/subs', builder: (c, s) => const SubscriptionsScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: '/data', builder: (c, s) => const DataScreen())]),
          StatefulShellBranch(routes: [GoRoute(path: '/cal', builder: (c, s) => const CalendarScreen())]),
        ],
      ),
      GoRoute(path: '/add', builder: (c, s) => const AddSubscriptionScreen()),
      GoRoute(path: '/orders', builder: (c, s) => const OrdersScreen()),
      GoRoute(path: '/orders/add', builder: (c, s) => const AddOrderScreen()),
      GoRoute(
        path: '/orders/:id',
        builder: (c, s) => OrderDetailScreen(id: s.pathParameters['id']!),
      ),
      GoRoute(
        path: '/subs/:id',
        builder: (c, s) => DetailScreen(id: s.pathParameters['id']!),
      ),
      GoRoute(path: '/settings', builder: (c, s) => const SettingsScreen()),
      GoRoute(path: '/simulator', builder: (c, s) => const SimulatorScreen()),
      GoRoute(path: '/budget', builder: (c, s) => const BudgetScreen()),
      GoRoute(path: '/methods', builder: (c, s) => const PaymentMethodsScreen()),
      GoRoute(path: '/year', builder: (c, s) => const YearReviewScreen()),
    ],
  );
});
