import 'package:flutter/material.dart';

import '../sizes_helpers.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
      children: [
        Container(
          height: displayHeight(context) * 0.35,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("img/front_page.png"), fit: BoxFit.cover),
          ),
        ),
        Container(
            height: displayHeight(context) * 0.65,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0)),
            ),
            child: Column(
              children: [
                Container(
                  height: 146,
                  child: Center(child: Text("Build Your Own Garden")),
                ),
                Container(
                    width: displayWidth(context) * 0.85,
                    height: 298,
                    child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 235, 224, 165),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40.0),
                                  topLeft: Radius.circular(40.0)),
                            ),
                            height: displayHeight(context) * 0.65,
                            child: const Center(
                              child: Text(
                                  "Identify you soil type to see what is best for your garden... "),
                            ),
                          );
                        }))
              ],
            )),
      ],
    )));
  }
}
