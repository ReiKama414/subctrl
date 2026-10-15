import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthConfig {
  /// Client IDs are public (already in google-services.json / LINE console).
  /// Override with `--dart-define=...` or `dart_defines.json` if needed.
  static const googleServerClientId = String.fromEnvironment(
    'GOOGLE_SERVER_CLIENT_ID',
    defaultValue: 'your-web-client-id.apps.googleusercontent.com',
  );
  static const lineChannelId = String.fromEnvironment(
    'LINE_CHANNEL_ID',
    defaultValue: 'REDACTED_LINE_CHANNEL',
  );

  static bool get googleConfigured => googleServerClientId.isNotEmpty;
  static bool get lineConfigured => lineChannelId.isNotEmpty;
}

class AuthException implements Exception {
  AuthException(this.message);
  final String message;
  @override
  String toString() => message;
}

class AuthSession {
  const AuthSession({
    required this.accountId,
    required this.providers,
    this.displayName,
    this.email,
  });

  final String accountId;
  final Set<String> providers;
  final String? displayName;
  final String? email;

  bool get isGuest => providers.contains('guest') && providers.length == 1;
}

abstract class AuthProvider {
  String get id;
  Future<AuthIdentity> signIn();
}

class AuthIdentity {
  const AuthIdentity({
    required this.provider,
    this.providerUserId,
    this.email,
    this.displayName,
  });

  final String provider;
  final String? providerUserId;
  final String? email;
  final String? displayName;
}

class GuestAuthProvider implements AuthProvider {
  @override
  String get id => 'guest';

  @override
  Future<AuthIdentity> signIn() async => const AuthIdentity(provider: 'guest', displayName: 'Local');
}

class GoogleAuthProvider implements AuthProvider {
  bool _googleSignInReady = false;

  @override
  String get id => 'google';

  Future<void> _ensureGoogleSignIn() async {
    if (_googleSignInReady) return;
    if (!AuthConfig.googleConfigured) {
      throw AuthException(
        '缺少 GOOGLE_SERVER_CLIENT_ID（Google Cloud / Firebase 的 Web client ID）。\n'
        '請用：flutter run --dart-define=GOOGLE_SERVER_CLIENT_ID=你的Web客戶端ID',
      );
    }
    await GoogleSignIn.instance.initialize(
      serverClientId: AuthConfig.googleServerClientId,
    );
    _googleSignInReady = true;
  }

  Future<AuthIdentity> _identityFromFirebaseUser(firebase_auth.User? user) {
    if (user == null) {
      throw AuthException('Firebase Authentication 未回傳使用者。');
    }
    return Future.value(
      AuthIdentity(
        provider: 'google',
        providerUserId: user.uid,
        email: user.email,
        displayName: user.displayName,
      ),
    );
  }

  Future<AuthIdentity> _signInWithGoogleWeb() async {
    if (Firebase.apps.isEmpty) {
      throw AuthException(
        '目前在瀏覽器執行，但尚未設定 Firebase Web。\n'
        '請擇一：\n'
        '1) 改在 Android 模擬器／真機執行（推薦）\n'
        '2) Firebase Console 新增 Web 應用，再用\n'
        '   --dart-define=FIREBASE_WEB_APP_ID=1:…:web:…',
      );
    }
    final provider = firebase_auth.GoogleAuthProvider();
    final userCred = await firebase_auth.FirebaseAuth.instance.signInWithPopup(provider);
    return _identityFromFirebaseUser(userCred.user);
  }

  /// Preferred on Android: Firebase-hosted provider flow (avoids Credential Manager
  /// falsely reporting "canceled" when oauth_client is missing).
  Future<AuthIdentity> _signInWithFirebaseProvider() async {
    final provider = firebase_auth.GoogleAuthProvider();
    provider.addScope('email');
    provider.addScope('profile');
    final userCred = await firebase_auth.FirebaseAuth.instance.signInWithProvider(provider);
    return _identityFromFirebaseUser(userCred.user);
  }

  Future<AuthIdentity> _signInWithGoogleSignInPlugin() async {
    await _ensureGoogleSignIn();
    final googleUser = await GoogleSignIn.instance.authenticate();
    final idToken = googleUser.authentication.idToken;
    if (idToken == null || idToken.isEmpty) {
      throw AuthException(
        'Google 未回傳 ID token。\n'
        '請確認：Firebase 已啟用 Google 登入、已登錄 SHA-1，並重新下載 google-services.json（oauth_client 不應為空）。',
      );
    }
    final credential = firebase_auth.GoogleAuthProvider.credential(idToken: idToken);
    final userCred = await firebase_auth.FirebaseAuth.instance.signInWithCredential(credential);
    return _identityFromFirebaseUser(userCred.user);
  }

  Future<AuthIdentity> _signInWithGoogleNative() async {
    try {
      return await _signInWithFirebaseProvider();
    } on firebase_auth.FirebaseAuthException catch (e) {
      debugPrint('Firebase signInWithProvider failed: ${e.code} ${e.message}');
      // Fall back to google_sign_in plugin when provider UI is unavailable.
      if (e.code == 'unknown' ||
          e.code == 'operation-not-allowed' ||
          e.code == 'web-context-cancelled' ||
          e.code == 'canceled' ||
          e.code == 'ERROR_CREDENTIAL_ALREADY_IN_USE') {
        if (e.code == 'operation-not-allowed') {
          throw AuthException(
            'Firebase Console 尚未啟用 Google 登入提供者。\n'
            '請到 Authentication → Sign-in method → Google → 啟用。',
          );
        }
      }
      try {
        return await _signInWithGoogleSignInPlugin();
      } on GoogleSignInException catch (g) {
        throw _mapGoogleSignInException(g, firebaseCode: e.code, firebaseMessage: e.message);
      }
    }
  }

  AuthException _mapGoogleSignInException(
    GoogleSignInException e, {
    String? firebaseCode,
    String? firebaseMessage,
  }) {
    final desc = e.description?.trim();
    final detail = [
      if (desc != null && desc.isNotEmpty) desc,
      'code=${e.code.name}',
      if (firebaseCode != null) 'firebase=$firebaseCode',
      if (firebaseMessage != null) firebaseMessage,
    ].join(' · ');

    if (e.code == GoogleSignInExceptionCode.canceled) {
      return AuthException(
        'Google 登入未完成（常被顯示成「取消」）。\n'
        '請檢查：\n'
        '1) Firebase Authentication 已啟用 Google\n'
        '2) Android 應用已登錄 SHA-1，並重新下載 google-services.json\n'
        '   （目前 oauth_client 為空時幾乎一定失敗）\n'
        '3) 模擬器已登入 Google 帳號，且非飛航模式\n'
        '($detail)',
      );
    }
    return AuthException(detail);
  }

  @override
  Future<AuthIdentity> signIn() async {
    try {
      if (kIsWeb) {
        return await _signInWithGoogleWeb();
      }
      if (defaultTargetPlatform != TargetPlatform.android) {
        throw AuthException(
          'Google 登入目前僅支援 Android（與已設定的 Firebase Web）。\n'
          '請選擇 Android 模擬器／真機，不要選 Chrome / Windows。',
        );
      }
      if (Firebase.apps.isEmpty) {
        throw AuthException('Firebase 尚未初始化，請重新啟動應用程式。');
      }
      return await _signInWithGoogleNative();
    } on AuthException {
      rethrow;
    } on GoogleSignInException catch (e) {
      throw _mapGoogleSignInException(e);
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'operation-not-allowed') {
        throw AuthException(
          'Firebase Console 尚未啟用 Google 登入提供者。\n'
          '請到 Authentication → Sign-in method → Google → 啟用。',
        );
      }
      if (e.code == 'web-context-cancelled' || e.code == 'canceled') {
        throw AuthException('已取消 Google 登入。');
      }
      throw AuthException(e.message ?? e.code);
    } on UnsupportedError catch (e) {
      throw AuthException(e.message ?? e.toString());
    } catch (e) {
      throw AuthException(e.toString());
    }
  }
}

class LineAuthProvider implements AuthProvider {
  bool _ready = false;

  @override
  String get id => 'line';

  Future<void> _ensureSetup() async {
    if (_ready) return;
    await LineSDK.instance.setup(AuthConfig.lineChannelId);
    _ready = true;
  }

  @override
  Future<AuthIdentity> signIn() async {
    if (!AuthConfig.lineConfigured) {
      throw AuthException(
        '需要 LINE Login 設定（LINE_CHANNEL_ID）。\n'
        '請用：flutter run --dart-define=LINE_CHANNEL_ID=YOUR_CHANNEL_ID',
      );
    }
    if (kIsWeb) {
      throw AuthException('LINE Login 目前不支援瀏覽器，請用 Android／iOS。');
    }
    try {
      await _ensureSetup();
      final result = await LineSDK.instance.login(
        scopes: ['profile', 'openid'],
      );
      final profile = result.userProfile;
      if (profile == null || profile.userId.isEmpty) {
        throw AuthException('LINE 未回傳使用者資料。');
      }
      return AuthIdentity(
        provider: 'line',
        providerUserId: profile.userId,
        displayName: profile.displayName,
      );
    } on AuthException {
      rethrow;
    } on PlatformException catch (e) {
      if (e.code == 'CANCEL' || e.code == '3003') {
        throw AuthException('已取消 LINE 登入。');
      }
      throw AuthException(e.message ?? e.code);
    } catch (e) {
      throw AuthException(e.toString());
    }
  }
}

class AuthService {
  AuthService({
    GuestAuthProvider? guest,
    GoogleAuthProvider? google,
    LineAuthProvider? line,
  })  : guest = guest ?? GuestAuthProvider(),
        google = google ?? GoogleAuthProvider(),
        line = line ?? LineAuthProvider();

  final GuestAuthProvider guest;
  final GoogleAuthProvider google;
  final LineAuthProvider line;

  AuthProvider byId(String id) => switch (id) {
        'google' => google,
        'line' => line,
        _ => guest,
      };
}
