// Create the connection between the front and backend using API
// For signing up and logining in

import 'package:build_my_garden/pages/signin_page.dart';
import 'package:build_my_garden/pages/subpages/about_page.dart';
import 'package:build_my_garden/pages/subpages/about_page.dart';
import 'package:build_my_garden/service/auth_service.dart';
import 'package:build_my_garden/service/mygarden_service.dart';
import 'package:build_my_garden/service/secure_storage.dart';
import 'package:build_my_garden/sizes_helpers.dart';
import 'package:build_my_garden/widgets/app_text.dart';
import 'package:build_my_garden/widgets/responsive_button.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _secureText = true;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin:
              const EdgeInsets.only(top: 90, bottom: 90, left: 30, right: 30),
          width: displayWidth(context),
          height: displayHeight(context),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(text: "SIGN UP"),
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
                const SizedBox(height: 5),
                AppText(text: "Email", size: 18),
                const SizedBox(height: 5),
                TextField(
                  controller: _emailController,
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
                AppText(text: "New Password", size: 18),
                const SizedBox(height: 5),
                TextField(
                  controller: _passwordController,
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
                const SizedBox(height: 15),
                AppText(text: "Confirm Password", size: 18),
                const SizedBox(height: 5),
                TextField(
                  controller: _confirmPasswordController,
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
                const SizedBox(height: 15),
                // Sign up button
                ResponsiveButton(
                  onPress: () async {
                    AuthService authService = AuthService();
                    RegistrationResponse? registrationResponse =
                        await authService.registration(
                            _usernameController.text,
                            _emailController.text,
                            _passwordController.text,
                            _confirmPasswordController.text);
                    if (registrationResponse != null) {
                      if (registrationResponse.key != null) {
                        // Save the token in an encrpted storage and set app state as signedin
                        // set the username in the app state
                        await SecureStorage.setUserName(_usernameController.text);
                        await SecureStorage.setToken(registrationResponse.key);
                        await SecureStorage.setIsSignedIn(true);
                        // [To Do] Fix added if we need to remove the ignore
                        // ignore: use_build_context_synchronously
                        // [To Do] Create a soil page
                        // Creates a dummy soil
                        SoilServices soilServices = SoilServices();
                        await soilServices.postSoil();

                        // ignore: use_build_context_synchronously
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AboutPage()));
                      }
                      registrationResponse.email
                          ?.forEach((element) => print("email: " + element));
                      registrationResponse.username
                          ?.forEach((element) => print("username: " + element));
                      registrationResponse.password1
                          ?.forEach((element) => print("password: " + element));
                      registrationResponse.non_field_errors?.forEach(
                          (element) => print("non_field_error: " + element));
                    }
                  },
                  text: "SIGN UP",
                  textColor: Colors.white,
                  buttonColor: const Color.fromARGB(255, 15, 81, 86),
                  width: 300,
                ),
                const SizedBox(height: 10),
                AppText(text: "SIGN IN USING:"),
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
                    AppText(text: "Already have account? "),
                    GestureDetector(
                      child: AppText(
                        text: "LOGIN",
                        color: Color.fromARGB(255, 105, 154, 104),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInPage()));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
