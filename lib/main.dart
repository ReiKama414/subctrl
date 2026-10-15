import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:subctrl/app/app.dart';
import 'package:subctrl/core/providers.dart';
import 'package:subctrl/core/services/notification_service.dart';
import 'package:subctrl/data/database/app_database.dart';
import 'package:subctrl/data/repositories/catalog_repository.dart';
import 'package:subctrl/data/seed/bootstrap.dart';
import 'package:subctrl/firebase_options.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Show splash first, and yield so the first frame can paint before heavy init.
  runApp(const _BootSplash());
  await Future<void>.delayed(Duration.zero);
  await WidgetsBinding.instance.endOfFrame;
  debugPrint('SUB//CTRL boot: first frame painted');

  try {
    await _initFirebase();
    debugPrint('SUB//CTRL boot: firebase ready');
    final db = AppDatabase();
    final bootstrap = BootstrapService(db);
    await bootstrap.ensureInitialized().timeout(const Duration(seconds: 20));
    debugPrint('SUB//CTRL boot: db ready');
    await bootstrap.ensureCatalogFresh().timeout(const Duration(seconds: 20));
    debugPrint('SUB//CTRL boot: catalog ready');
    await _initTime();
    final notifications = NotificationService();
    await notifications.initialize().timeout(const Duration(seconds: 8));
    final prefs = await SettingsRepository(db).get().timeout(const Duration(seconds: 8));
    debugPrint('SUB//CTRL boot: launching app');

    runApp(
      ProviderScope(
        overrides: [
          databaseProvider.overrideWithValue(db),
          notificationServiceProvider.overrideWithValue(notifications),
          unlockedProvider.overrideWith((ref) => !prefs.biometricLock),
        ],
        child: const SubCtrlApp(),
      ),
    );
  } catch (e, st) {
    debugPrint('Boot failed: $e\n$st');
    runApp(_BootError(message: e.toString()));
  }
}

Future<void> _initFirebase() async {
  if (Firebase.apps.isNotEmpty) return;
  try {
    if (kIsWeb) {
      if (!DefaultFirebaseOptions.hasWebConfig) {
        debugPrint(
          'SUB//CTRL: Web Firebase skipped — pass '
          '--dart-define=FIREBASE_WEB_APP_ID=1:…:web:… '
          'or Google sign-in on Chrome will fail.',
        );
        return;
      }
      await Firebase.initializeApp(options: DefaultFirebaseOptions.web)
          .timeout(const Duration(seconds: 10));
      return;
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      await Firebase.initializeApp(options: DefaultFirebaseOptions.android)
          .timeout(const Duration(seconds: 10));
    }
  } catch (e, st) {
    debugPrint('Firebase init skipped/failed: $e\n$st');
  }
}

Future<void> _initTime() async {
  tzdata.initializeTimeZones();
  if (kIsWeb) return;
  try {
    final name = await FlutterTimezone.getLocalTimezone()
        .timeout(const Duration(seconds: 3));
    tz.setLocalLocation(tz.getLocation(name));
  } catch (_) {
    tz.setLocalLocation(tz.UTC);
  }
}

class _BootSplash extends StatelessWidget {
  const _BootSplash();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFF0B0C0E),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'S//C',
                style: TextStyle(
                  color: Color(0xFF5EEAD4),
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Color(0xFF5EEAD4),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BootError extends StatelessWidget {
  const _BootError({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF0B0C0E),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SUB//CTRL 啟動失敗',
                  style: TextStyle(color: Color(0xFFE11D2A), fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(message, style: const TextStyle(color: Color(0xFFE8EAED), fontSize: 13)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
