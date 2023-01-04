import 'dart:convert';
import 'package:build_my_garden/service/base_url_service.dart';
import 'package:build_my_garden/service/secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  /// AuthService handles all authentications, currently supports login and signup
  final registrationUrl = Uri.parse("$baseUrl/auth/registration/");
  final loginUrl = Uri.parse("$baseUrl/accounts/login/");

  Future<RegistrationResponse?> registration(
      String username, String email, String password1, String password2) async {
    var response = await http.post(registrationUrl, body: {
      "username": username,
      "password1": password1,
      "password2": password2,
      "email": email,
    });
    return RegistrationResponse.fromJson(jsonDecode(response.body));
  }

  Future<LoginResponse?> login(String usernameOrEmail, String password) async {
    var response = await http.post(loginUrl, body: {
      "username": usernameOrEmail,
      "password": password,
    });
    return LoginResponse.fromJson(jsonDecode(response.body));
  }

  // Authentication the user
  Future<bool> authenticateUser(String token) async {
    var response = await http.post(Uri.parse("$baseUrl/accounts/login/"),
        headers: {"Authorization": "Token $token"});
    return response.statusCode == 200;
  }
}

// All response
// Registration response {"key":"18e20c2d54123e039bdbd86e5831e0fb7b30295f"}
// If registered already {"username":["A user with that username already exists."],"email":["A user is already registered with this e-mail address."]}
// Password short {"password1":["This password is too short. It must contain at least 8 characters."]}
// Password common {"password1":["This password is too common.","This password is entirely numeric."]}
// Password is similar to username {"non_field_errors":["The password is too similar to the username."]}
// Password doesn't match {"non_field_errors":["The two password fields didn't match."]}
// Email nothing {"email":["Enter a valid email address."]}

class RegistrationResponse {
  /// RegistrationResponse handles any error messages and confirmations messages
  List<dynamic>? non_field_errors;
  List<dynamic>? password1;
  List<dynamic>? username;
  List<dynamic>? email;
  dynamic key;

  RegistrationResponse({
    this.email,
    this.key,
    this.non_field_errors,
    this.password1,
    this.username,
  });

  factory RegistrationResponse.fromJson(mapOfBody) {
    return RegistrationResponse(
      email: mapOfBody["email"],
      key: mapOfBody["key"],
      non_field_errors: mapOfBody["non_field_errors"],
      password1: mapOfBody["password1"],
      username: mapOfBody["username"],
    );
  }
}

class LoginResponse {
  /// LoginResponse handles any error messages and confirmations messages
  dynamic? key;
  List<dynamic>? non_field_errors;
  LoginResponse({this.key, this.non_field_errors});

  factory LoginResponse.fromJson(mapOfBody) {
    return LoginResponse(
      key: mapOfBody['key'],
      // Added username to LoginResponse
      non_field_errors: mapOfBody['non_field_errors'],
    );
  }
}
