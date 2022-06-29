import 'package:build_my_garden/widgets/app_large_text.dart';
import 'package:flutter/material.dart';

import '../sizes_helpers.dart';
import '../widgets/app_text.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List list_of_text = [
    "Identify you soil type to see what is best for your garden... ",
    "Keep status of your garden... ",
    "Sell it to a marketplace... ",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
      children: [
        Container(
          // set height to 35% of the display
          height: displayHeight(context) * 0.35,
          // Load the top image
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/front_page.png"),
                fit: BoxFit.cover),
          ),
        ),
        Container(
            // set the bottom half as 65% of display
            height: displayHeight(context) * 0.65,
            width: displayWidth(context),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  // set border radius
                  topRight: Radius.circular(20.0),
                  topLeft: Radius.circular(20.0)),
            ),
            child: Column(
              children: [
                Container(
                    // Margin for the text inside the white box
                    margin: const EdgeInsets.only(top: 40),
                    height: 106,
                    child: Column(
                      children: const [
                        // Load the widget AppLargeText
                        AppLargeText(
                            text: "BUILD YOUR OWN",
                            size: 16,
                            color: Color.fromARGB(255, 59, 87, 48)),
                        AppLargeText(
                            text: "GARDEN",
                            size: 46,
                            color: Color.fromARGB(255, 59, 87, 48)),
                      ],
                    )),
                Container(
                    // A container that is scrollable with information
                    width: displayWidth(context) * 0.85,
                    height: 298,
                    child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 3,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 228, 182),
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(40.0),
                                  topLeft: Radius.circular(40.0)),
                            ),
                            height: displayHeight(context) * 0.65,
                            // The button and text are in a column inside the pageview
                            child: Column(children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 50, left: 50, right: 50),
                                // Load the widget AppText for texts
                                child: AppText(text: list_of_text[index]),
                              ),
                              Container()
                            ]),
                          );
                        }))
              ],
            )),
      ],
    )));
  }
}
