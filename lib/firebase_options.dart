// Client config only. Do not commit service-account keys.

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  /// Override with `--dart-define=FIREBASE_WEB_APP_ID=...` if needed.
  static const webAppId = String.fromEnvironment(
    'FIREBASE_WEB_APP_ID',
    defaultValue: '1:REDACTED_PROJECT_NUMBER:web:xxxxxxxxxxxxxxxx',
  );

  static const webApiKey = String.fromEnvironment(
    'FIREBASE_WEB_API_KEY',
    defaultValue: 'REDACTED',
  );

  static bool get hasWebConfig => webAppId.isNotEmpty;

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      if (!hasWebConfig) {
        throw UnsupportedError(
          'Web Firebase is not configured. Pass '
          '--dart-define=FIREBASE_WEB_APP_ID=1:…:web:… '
          'or run on Android.',
        );
      }
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for iOS.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macOS.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'REDACTED',
    appId: '1:REDACTED_PROJECT_NUMBER:android:xxxxxxxxxxxxxxxx',
    messagingSenderId: 'REDACTED_PROJECT_NUMBER',
    projectId: 'sub-ctrl',
    storageBucket: 'sub-ctrl.firebasestorage.app',
  );

  static FirebaseOptions get web => FirebaseOptions(
        apiKey: webApiKey,
        appId: webAppId,
        messagingSenderId: android.messagingSenderId,
        projectId: android.projectId,
        authDomain: '${android.projectId}.firebaseapp.com',
        storageBucket: android.storageBucket,
      );
}
