// The welcome app state
import 'package:build_my_garden/pages/welcome_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeApp extends StatefulWidget {
  const WelcomeApp({Key? key}) : super(key: key);

  @override
  State<WelcomeApp> createState() => _WelcomeAppState();
}

class _WelcomeAppState extends State<WelcomeApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Build Your Garden', //The title of the Flutter App
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 255, 228, 182),
          primarySwatch: Colors.green,
        ), //ThemeData
        home: WelcomePage()); //Column //Center //Scaffold //MaterialApp
  }
}
