// Create the connection between the front and backend using API
// For signing up and logining in
import 'package:build_my_garden/pages/signup_page.dart';
import 'package:build_my_garden/service/auth_service.dart';
import 'package:build_my_garden/service/secure_storage.dart';
import 'package:build_my_garden/sizes_helpers.dart';
import 'package:build_my_garden/widgets/app_text.dart';
import 'package:build_my_garden/widgets/responsive_button.dart';
import 'package:flutter/material.dart';

import '../main.dart';

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
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(

          

          scrollDirection: Axis.vertical,

          child: Container(
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
                          // Save the token in an encrpted storage and set app state as signedin
                          await SecureStorage.setUserName(_usernameController.text);
                          await SecureStorage.setToken(loginResponse.key);
                          await SecureStorage.setIsSignedIn(true);
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

                    

                    buttonColor: const Color.fromARGB(255, 15, 81, 86),

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
                  Row(
                    children: [
                      AppText(text: "New account? "),
                      GestureDetector(
                        child: AppText(
                          text: "SIGN UP",
                          color: Color.fromARGB(255, 105, 154, 104),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage()));
                        },
                      ),
                    ],
                  ),
                ],
              ),
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
}
