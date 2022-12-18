// The Signin and Signup app state
import 'package:build_my_garden/pages/signin_page.dart';
import 'package:flutter/material.dart';

class AuthApp extends StatefulWidget {
  const AuthApp({Key? key}) : super(key: key);

  @override
  State<AuthApp> createState() => _AuthAppState();
}

class _AuthAppState extends State<AuthApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Build Your Garden', //The title of the Flutter App
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 255, 228, 182),
          primarySwatch: Colors.green,
        ),
        home: const SignInPage());
  }
}
