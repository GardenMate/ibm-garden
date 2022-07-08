// Import for a secured storage of the key
// Docs: https://pub.dev/packages/flutter_secure_storage - may need further config
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Storage for encrypted values
class SecureStorage {
  static final _storage = FlutterSecureStorage();

  static Future setToken(String token) async =>
      await _storage.write(key: 'token', value: token);

  static Future<String?> getToken() async => await _storage.read(key: 'token');

  static Future setIsSignedIn(bool isSignedIn) async =>
      await _storage.write(key: 'isSignedIn', value: isSignedIn.toString());

  static Future<bool?> getIsSignedIn() async {
    String? isSignedIn = await _storage.read(key: 'isSignedIn');
    if (isSignedIn == "true") {
      return true;
    } else {
      return false;
    }
  }
}
