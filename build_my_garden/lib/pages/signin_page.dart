// Create the connection between the front and backend using API
// For signing up and logining in
import 'dart:convert';

import 'package:http/http.dart' as http;

main() async {
  AuthService authService = AuthService();
  RegistrationResponse? registrationResponse = await authService.registration(
      "abemelech", "alskd1235", "alskd1235[", "abemelech.mesfin.gmail.com");
  if (registrationResponse != null) {
    registrationResponse.email?.forEach((e) => print(e));
    registrationResponse.username?.forEach((e) => print(e));
    registrationResponse.non_field_errors?.forEach((e) => print(e));
    registrationResponse.password1?.forEach((e) => print(e));
  }
}

class AuthService {
  final registrationUrl = Uri.parse("http://10.0.2.2:8000/auth/registration/");
  final loginUrl = Uri.parse("http://10.0.2.2:8000/accounts/login/");

  Future<RegistrationResponse> registration(
      String username, String password1, String password2, String email) async {
    var response = await http.post(registrationUrl, body: {
      "username": username,
      "password1": password1,
      "password2": password2,
      "email": email,
    });
    print(response.body);
    return RegistrationResponse.fromJson(jsonDecode(response.body));
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
