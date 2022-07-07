// Import for a secured storage of the key
// Docs: https://pub.dev/packages/flutter_secure_storage - may need further config
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Storage for encrypted values
class SecureStorage {
  static final _storage = FlutterSecureStorage();

  static Future setToken(String token) async =>
      await _storage.write(key: 'token', value: token);

  static Future<String?> getToken() async => await _storage.read(key: 'token');
}
