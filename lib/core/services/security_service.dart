import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_darwin/local_auth_darwin.dart';

class SecurityService {
  SecurityService()
      : _auth = LocalAuthentication(),
        _secure = const FlutterSecureStorage();

  final LocalAuthentication _auth;
  final FlutterSecureStorage _secure;

  Future<void> writeSession(String json) => _secure.write(key: 'session', value: json);
  Future<String?> readSession() => _secure.read(key: 'session');
  Future<void> clearSession() => _secure.delete(key: 'session');

  Future<bool> canBiometric() async {
    if (kIsWeb) return false;
    try {
      final supported = await _auth.isDeviceSupported();
      final canBio = await _auth.canCheckBiometrics;
      return supported || canBio;
    } catch (_) {
      return false;
    }
  }

  Future<bool> unlock({
    required String reason,
    String cancelButton = 'Cancel',
  }) async {
    if (kIsWeb) return true;
    try {
      final ok = await _auth.authenticate(
        localizedReason: reason,
        authMessages: <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: 'SUB//CTRL',
            biometricHint: '',
            cancelButton: cancelButton,
          ),
          IOSAuthMessages(cancelButton: cancelButton),
        ],
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
          useErrorDialogs: true,
          sensitiveTransaction: false,
        ),
      );
      return ok;
    } catch (e) {
      debugPrint('SecurityService.unlock failed: $e');
      return false;
    }
  }
}
