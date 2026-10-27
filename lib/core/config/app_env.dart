/// Build-time configuration via `--dart-define` / `dart_defines.json` (gitignored).
///
/// **local** (default): GitHub Releases — guest session, no login screen, no cloud, no API keys.
/// **account**: private maintainer APK — Google/LINE login; cloud backup after Google sign-in (Firebase Auth).
class AppEnv {
  /// `local` | `account`
  static const authMode = String.fromEnvironment('APP_AUTH_MODE', defaultValue: 'local');

  static bool get requireAccountLogin => authMode == 'account';
  static bool get isPublicLocalBuild => !requireAccountLogin;

  /// Google / LINE / Firebase — only in maintainer `account` builds.
  static bool get integrationsEnabled => requireAccountLogin;

  /// Cloud UI + sync only ship in the private account APK.
  static bool get cloudInBuild => requireAccountLogin;
  static const googleServerClientId = String.fromEnvironment('GOOGLE_SERVER_CLIENT_ID');
  static const lineChannelId = String.fromEnvironment('LINE_CHANNEL_ID');

  static const firebaseAndroidApiKey = String.fromEnvironment('FIREBASE_ANDROID_API_KEY');
  static const firebaseAndroidAppId = String.fromEnvironment('FIREBASE_ANDROID_APP_ID');
  static const firebaseMessagingSenderId = String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID');
  static const firebaseProjectId = String.fromEnvironment('FIREBASE_PROJECT_ID');
  static const firebaseStorageBucket = String.fromEnvironment('FIREBASE_STORAGE_BUCKET');

  static const firebaseWebAppId = String.fromEnvironment('FIREBASE_WEB_APP_ID');
  static const firebaseWebApiKey = String.fromEnvironment('FIREBASE_WEB_API_KEY');

  static bool get googleConfigured => googleServerClientId.isNotEmpty;
  static bool get lineConfigured => lineChannelId.isNotEmpty;

  static bool get hasAndroidFirebase =>
      firebaseAndroidApiKey.isNotEmpty &&
      firebaseAndroidAppId.isNotEmpty &&
      firebaseProjectId.isNotEmpty;

  static bool get hasWebFirebase => firebaseWebAppId.isNotEmpty && firebaseWebApiKey.isNotEmpty;

  /// True when this build includes cloud and the user has a Firebase session (Google sign-in).
  static bool canUseCloud(String? firebaseUid) {
    if (!cloudInBuild) return false;
    return firebaseUid != null && firebaseUid.isNotEmpty;
  }
}
