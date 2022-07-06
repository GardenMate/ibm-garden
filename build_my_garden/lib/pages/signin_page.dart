// Create the connection between the front and backend using API
// For signing up and logining in
import 'dart:convert';
import 'dart:ffi';

import 'package:build_my_garden/sizes_helpers.dart';
import 'package:build_my_garden/widgets/app_text.dart';
import 'package:build_my_garden/widgets/responsive_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../main.dart';

// Import for a secured storage of the key
// Docs: https://pub.dev/packages/flutter_secure_storage - may need further config
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Storage for encrypted values
final storage = new FlutterSecureStorage();

// The sign in page for the app
class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // _securetext switches between show password and not
  // _usernameController & _passwordController stores username and text
  bool _secureText = true;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          margin:
              const EdgeInsets.only(top: 90, bottom: 90, left: 30, right: 30),
          width: displayWidth(context),
          height: displayHeight(context),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(text: "LOGIN"),
                const SizedBox(height: 20),
                AppText(text: "Username", size: 18),
                const SizedBox(height: 5),
                TextField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide:
                            BorderSide(width: 0, style: BorderStyle.none)),
                    fillColor: Color.fromARGB(20, 64, 42, 42),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 15),
                AppText(text: "Password", size: 18),
                const SizedBox(height: 5),
                TextField(
                  controller: _passwordController,
                  obscureText: _secureText,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(_secureText
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye),
                      onPressed: () {
                        setState(() {
                          _secureText = !_secureText;
                        });
                      },
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                            width: 0, style: BorderStyle.none)),
                    fillColor: const Color.fromARGB(20, 64, 42, 42),
                    filled: true,
                  ),
                ),
                const SizedBox(height: 10),
                AppText(text: "Remeber me?"),
                const SizedBox(height: 10),
                ResponsiveButton(
                  onPress: () async {
                    AuthService authService = AuthService();
                    LoginResponse? loginResponse = await authService.login(
                        _usernameController.text, _passwordController.text);
                    if (loginResponse != null) {
                      if (loginResponse.key != null) {
                        // print(loginResponse.key); Later store the key value
                        await storage.write(
                            key: 'token', value: loginResponse.key);
                        // Fix added if we need to remove the ignore
                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainApp()));
                      }
                      loginResponse.non_field_errors
                          ?.forEach((element) => print(element));
                    }
                  },
                  text: "LOGIN",
                  textColor: Colors.white,
                  buttonColor: Color.fromARGB(255, 156, 222, 155),
                  width: 300,
                ),
                const SizedBox(height: 10),
                AppText(text: "Forgot Password?"),
                const SizedBox(height: 10),
                AppText(text: "OR", size: 18),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.facebook),
                    Icon(Icons.facebook),
                    Icon(Icons.facebook),
                  ],
                ),
                const SizedBox(height: 10),
                AppText(text: "New account? SIGN UP"),
              ],
            ),
          ),
        ));
  }
}

main() async {
  AuthService authService = AuthService();
  // RegistrationResponse? registrationResponse = await authService.registration(
  //     "abemelech", "sa;dslfkjwe", "sa;dslfkjwe", "abemelech.mesfin.gmail.com");
  // if (registrationResponse != null) {
  //   registrationResponse.email?.forEach((e) => print(e));
  //   registrationResponse.username?.forEach((e) => print(e));
  //   registrationResponse.non_field_errors?.forEach((e) => print(e));
  //   registrationResponse.password1?.forEach((e) => print(e));
  //   if (registrationResponse != null) print(registrationResponse.key);
  // }

  // Check if the login endpoint works
  LoginResponse? loginResponse =
      await authService.login("abemelech", "sa;dslfkjwe");
  if (loginResponse != null) {
    if (loginResponse.key != null) print(loginResponse.key);
    loginResponse.non_field_errors?.forEach((element) => print(element));
  }

  // Get User data
  // var response = await http
  //     .get(Uri.parse("http://10.0.2.2:8000/accounts/user/"), headers: {
  //   "Authorization": "Token e513b66ec1dc07ba3078aff736992115f81e706c"
  // });
  // print(response.body);
}

class AuthService {
  /// AuthService handles all authentications, currently supports login and signup
  final registrationUrl = Uri.parse("http://10.0.2.2:8000/auth/registration/");
  final loginUrl = Uri.parse("http://10.0.2.2:8000/accounts/login/");

  Future<RegistrationResponse?> registration(
      String username, String password1, String password2, String email) async {
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
      non_field_errors: mapOfBody['non_field_errors'],
    );
  }
}
