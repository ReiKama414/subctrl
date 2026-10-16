import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';

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
      return await _auth.canCheckBiometrics || await _auth.isDeviceSupported();
    } catch (_) {
      return false;
    }
  }

  Future<bool> unlock() async {
    if (kIsWeb) return true;
    try {
      return await _auth.authenticate(
        localizedReason: 'Unlock SUB//CTRL',
        options: const AuthenticationOptions(biometricOnly: false, stickyAuth: true),
      );
    } catch (_) {
      return false;
    }
  }
}
