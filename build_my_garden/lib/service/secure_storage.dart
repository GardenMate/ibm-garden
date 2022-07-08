// Import for a secured storage of the key
// Docs: https://pub.dev/packages/flutter_secure_storage - may need further config
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Storage for encrypted values
class SecureStorage {
  /// The following class stores any vital values in an locally encrpted
  /// Tokens will be stored here

  static final _storage = FlutterSecureStorage();

  // To store access token
  static Future setToken(String token) async =>
      await _storage.write(key: 'token', value: token);

  // To access stored token
  static Future<String?> getToken() async => await _storage.read(key: 'token');

  // Set the status of isSignedIn
  static Future setIsSignedIn(bool isSignedIn) async =>
      await _storage.write(key: 'isSignedIn', value: isSignedIn.toString());

  // Stores the status of whether signed in or not
  static Future<bool?> getIsSignedIn() async {
    String? isSignedIn = await _storage.read(key: 'isSignedIn');
    if (isSignedIn == "true") {
      return true;
    } else {
      return false;
    }
  }
}
