// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
    return MaterialApp(
        title: 'Build Your Garden', //The title of the Flutter App
        theme: ThemeData(
          primarySwatch: Colors.green,
        ), //ThemeData
        home: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: const Text('Build Your Garden')), //AppBar
          body: Center(
              child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(0.0),
                child: Text("Welcome to Build Your Garden"),
              ), //Padding

              Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: ElevatedButton(
                      onPressed: buttonPressed,
                      child: Text('Click')) // ElevatedButton
                  ) //Padding
            ],
          )),
          bottomNavigationBar: BottomNav(),
        )); //Column //Center //Scaffold //MaterialApp
  }
}

class BottomNav extends StatefulWidget {
  const BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;
  final screens = [
    Center(child: Text('Learn', style: TextStyle(fontSize: 60))),
    Center(child: Text('Your Plants', style: TextStyle(fontSize: 60))),
    Center(child: Text('Marketplace', style: TextStyle(fontSize: 60))),
    Center(child: Text('Account', style: TextStyle(fontSize: 60))),
  ];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 91, 178, 94),
        selectedItemColor: Colors.white,
        unselectedItemColor: Color.fromARGB(255, 212, 225, 209),
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
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
