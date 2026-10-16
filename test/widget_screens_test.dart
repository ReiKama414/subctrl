import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:subctrl/app/theme/app_theme.dart';
import 'package:subctrl/app/theme/presets.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:subctrl/data/seed/bootstrap.dart';
import 'package:subctrl/features/add_subscription/add_subscription_screen.dart';
import 'package:subctrl/features/analytics/data_screen.dart';
import 'package:subctrl/features/calendar/calendar_screen.dart';
import 'package:subctrl/features/home/home_screen.dart';
import 'package:subctrl/features/orders/orders_screen.dart';
import 'package:subctrl/features/subscriptions/detail_screen.dart';
import 'package:subctrl/features/subscriptions/subscriptions_screen.dart';
import 'package:subctrl/l10n/app_localizations.dart';
import 'package:subctrl/shared/widgets/ui.dart';

Future<ProviderContainer> boot() async {
  final db = AppDatabase.memory();
  await BootstrapService(db).ensureInitialized();
  return ProviderContainer(overrides: [databaseProvider.overrideWithValue(db)]);
}

Widget wrap(ProviderContainer c, Widget child) {
  return UncontrolledProviderScope(
    container: c,
    child: MaterialApp(
      theme: AppTheme.fromTokens(ThemePresets.voidTheme),
      locale: const Locale('en'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  testWidgets('Home shows control center', (tester) async {
    final c = await boot();
    addTearDown(c.dispose);
    await tester.pumpWidget(wrap(c, const HomeScreen()));
    await tester.pumpAndSettle();
    expect(find.text('MONTHLY LOAD'), findsOneWidget);
    expect(find.text('ACTION REQUIRED'), findsOneWidget);
    expect(find.text('PENDING ORDERS'), findsOneWidget);
  });

  testWidgets('Orders empty state', (tester) async {
    final c = await boot();
    addTearDown(c.dispose);
    await tester.pumpWidget(wrap(c, const OrdersScreen()));
    await tester.pumpAndSettle();
    expect(find.text('ORDERS'), findsOneWidget);
    expect(find.text('NO ORDERS'), findsOneWidget);
  });

  testWidgets('Subscriptions empty state', (tester) async {
    final c = await boot();
    addTearDown(c.dispose);
    await tester.pumpWidget(wrap(c, const SubscriptionsScreen()));
    await tester.pumpAndSettle();
    expect(find.text('SUBSCRIPTIONS'), findsOneWidget);
    expect(find.text('NO SUBSCRIPTIONS'), findsOneWidget);
  });

  testWidgets('Add subscription steps', (tester) async {
    final c = await boot();
    addTearDown(c.dispose);
    await tester.pumpWidget(wrap(c, const AddSubscriptionScreen()));
    await tester.pumpAndSettle();
    expect(find.text('SELECT SERVICE'), findsOneWidget);
    expect(find.text('+ CUSTOM SUBSCRIPTION'), findsOneWidget);
  });

  testWidgets('Calendar screen', (tester) async {
    final c = await boot();
    addTearDown(c.dispose);
    await tester.pumpWidget(wrap(c, const CalendarScreen()));
    await tester.pumpAndSettle();
    expect(find.text('CALENDAR'), findsOneWidget);
  });

  testWidgets('Data screen', (tester) async {
    final c = await boot();
    addTearDown(c.dispose);
    await tester.pumpWidget(wrap(c, const DataScreen()));
    await tester.pumpAndSettle();
    expect(find.text('DATA'), findsOneWidget);
  });

  testWidgets('Detail missing id', (tester) async {
    final c = await boot();
    addTearDown(c.dispose);
    await tester.pumpWidget(wrap(c, const DetailScreen(id: 'missing')));
    await tester.pumpAndSettle();
    expect(find.textContaining('not found'), findsOneWidget);
  });

  testWidgets('Subscription card surface', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.fromTokens(ThemePresets.voidTheme),
        home: const SurfaceCard(child: Text('ChatGPT')),
      ),
    );
    expect(find.text('ChatGPT'), findsOneWidget);
  });
}
