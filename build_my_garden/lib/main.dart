// ignore_for_file: prefer_const_constructors

import 'package:build_my_garden/pages/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentIndex = 0;
  final screens = [
    CenterWithButton(text: "Learn"),
    CenterWithButton(text: "Your Plants"),
    CenterWithButton(text: "Marketplace"),
    CenterWithButton(text: "Account"),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Build Your Garden', //The title of the Flutter App
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 235, 224, 165),
          primarySwatch: Colors.green,
        ), //ThemeData
        home: WelcomePage()); //Column //Center //Scaffold //MaterialApp
  }
}

// A bottom navigation app
class BottomNav extends StatefulWidget {
  final int currentIndex;
  final Function(int) onPress;

  const BottomNav({Key? key, this.currentIndex = 0, required this.onPress})
      : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 91, 178, 94),
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromARGB(255, 212, 225, 209),
        showUnselectedLabels: false,
        currentIndex: widget.currentIndex,
        onTap: widget.onPress,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Learn',
            backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.energy_savings_leaf),
            label: 'Your Plants',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_rounded),
            label: 'Marketplace',
            backgroundColor: Colors.yellow,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Account',
            backgroundColor: Colors.green,
          ),
        ]); //Column //Center //Scaffold //MaterialApp
  }
}

// A center app
class CenterWithButton extends StatelessWidget {
  final String text;

  const CenterWithButton({Key? key, required this.text}) : super(key: key);

  // Connecting with the backend using http
  Future<http.Response> buttonPressed() async {
    http.Response returnedResult = await http.get(
        Uri.parse('http://10.0.2.2:8000/app/IBMWelcomeGarden'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset-UTF-8'
        });
    print(returnedResult.body);
    return returnedResult;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        Padding(
          padding: EdgeInsets.all(0.0),
          child: Text(("Welcome to $text")),
        ),
        Padding(
            padding: const EdgeInsets.all(0.0),
            child:
                ElevatedButton(onPressed: buttonPressed, child: Text('Click')))
      ],
    ));
  }
}
