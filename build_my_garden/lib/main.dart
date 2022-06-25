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
        Uri.parse('http://localhost:8000/app/IBMWelcomeGarden'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset-UTF-8'
        });
    print(returnedResult.body);
    return returnedResult;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'IBM Garden', //The title of the Flutter App
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ), //ThemeData
        home: Scaffold(
            appBar: AppBar(
                centerTitle: true, title: const Text('IBM Garden')), //AppBar
            body: Center(
                child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Text("Welcome to IBM Garden"),
                ), //Padding

                Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: ElevatedButton(
                        onPressed: buttonPressed,
                        child: Text('Click')) // ElevatedButton
                    ) //Padding
              ],
            )))); //Column //Center //Scaffold //MaterialApp
  }
}
