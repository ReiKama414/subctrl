import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:subctrl/features/add_subscription/add_subscription_screen.dart';
import 'package:subctrl/features/analytics/data_screen.dart';
import 'package:subctrl/features/analytics/simulator_screen.dart';
import 'package:subctrl/features/analytics/year_review_screen.dart';
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

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
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
