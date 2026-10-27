// Client config only. Populate via `--dart-define` / `dart_defines.json` or local
// `google-services.json` (Android, gitignored). Do not commit service-account keys.

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:subctrl/core/config/app_env.dart';

class DefaultFirebaseOptions {
  static bool get hasWebConfig => AppEnv.hasWebFirebase;

  static bool get hasAndroidConfig => AppEnv.hasAndroidFirebase;

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      if (!hasWebConfig) {
        throw UnsupportedError(
          'Web Firebase is not configured. Pass FIREBASE_WEB_APP_ID and FIREBASE_WEB_API_KEY.',
        );
      }
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        if (!hasAndroidConfig) {
          throw UnsupportedError(
            'Android Firebase is not configured. Use dart_defines.json or google-services.json.',
          );
        }
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

  static FirebaseOptions get android => FirebaseOptions(
        apiKey: AppEnv.firebaseAndroidApiKey,
        appId: AppEnv.firebaseAndroidAppId,
        messagingSenderId: AppEnv.firebaseMessagingSenderId,
        projectId: AppEnv.firebaseProjectId,
        storageBucket: AppEnv.firebaseStorageBucket,
      );

  static FirebaseOptions get web => FirebaseOptions(
        apiKey: AppEnv.firebaseWebApiKey,
        appId: AppEnv.firebaseWebAppId,
        messagingSenderId: AppEnv.firebaseMessagingSenderId.isNotEmpty
            ? AppEnv.firebaseMessagingSenderId
            : '0',
        projectId: AppEnv.firebaseProjectId,
        authDomain: AppEnv.firebaseProjectId.isNotEmpty
            ? '${AppEnv.firebaseProjectId}.firebaseapp.com'
            : null,
        storageBucket: AppEnv.firebaseStorageBucket,
      );
}
