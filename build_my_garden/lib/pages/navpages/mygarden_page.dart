import 'package:build_my_garden/sizes_helpers.dart';
import 'package:build_my_garden/widgets/app_large_text.dart';
import 'package:build_my_garden/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyGardenPage extends StatefulWidget {
  const MyGardenPage({Key? key}) : super(key: key);

  @override
  State<MyGardenPage> createState() => _MyGardenPageState();
}

class _MyGardenPageState extends State<MyGardenPage> {
  List images_list = [
    'potatoes.png',
    'tomatoes.png',
    'potatoes.png',
    'Brocooli.png',
    'onion.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      height: displayHeight(context),
      width: displayWidth(context),
      child: Container(
        padding: EdgeInsets.zero,
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(bottom: 18),
              child: AppLargeText(text: "Search Bar"),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: AppLargeText(
                  text: "My Garden Status",
                  size: 18,
                ),
              ),
            ),
            Expanded(
                child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: images_list.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    width: displayWidth(context),
                    child: Stack(children: [
                      Container(
                        height: 140,
                        width: displayWidth(context),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/" + images_list[index]))),
                        ),
                      ),
                      Positioned(
                          child: Container(
                        padding: const EdgeInsets.only(top: 1, bottom: 0),
                        height: 135,
                        width: displayWidth(context),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(63, 184, 188, 115),
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                      )),
                      const Positioned(
                        top: 85,
                        bottom: 0,
                        right: 10,
                        child: AppText(
                          text: "Planted: Jan 23\nWater Need: Daily",
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                      const Positioned(
                        top: 20,
                        left: 35,
                        child: AppText(
                          text: "Status",
                          size: 12,
                          color: Color.fromARGB(250, 255, 255, 255),
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      //Create a new positioned widget to display the learn more text widget on top right of the image
                      Positioned(
                        top: 10,
                        right: 20,
                        child: ElevatedButton(
                            child: AppText(
                              text: "Learn More",
                              size: 12,
                              color: Color.fromARGB(250, 255, 255, 255),
                              letterSpacing: 1.0,
                              fontWeight: FontWeight.bold,
                            ),
                            onPressed: () {}),
                      ),
                      //Create a new positioned widget to display circle shape to the upper left of the image
                      Positioned(
                        top: 35,
                        left: 15,
                        child: Container(
                          height: 90,
                          width: 90,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(217, 255, 255, 255),
                            borderRadius:
                                BorderRadius.all(Radius.circular(100)),
                          ),
                        ),
                      ),
                      //Create a new positioned widget to display text in the center of the circle shape
                      Positioned(
                          top: 50,
                          left: 35,
                          child: Column(
                            children: [
                              AppText(
                                text: "25",
                                size: 20,
                                color: Color.fromARGB(249, 0, 0, 0),
                                letterSpacing: 0,
                                fontWeight: FontWeight.bold,
                              ),
                              //Create a text widget that is centered and under the previous text widget
                              AppText(
                                text: "Until",
                                size: 12,
                                color: Color.fromARGB(249, 0, 0, 0),
                                letterSpacing: 0,
                                fontWeight: FontWeight.normal,
                              ),
                              //Create a text widget that is centered and under the previous text widget
                              AppText(
                                text: "Harvest",
                                size: 12,
                                color: Color.fromARGB(249, 0, 0, 0),
                                letterSpacing: 0,
                                fontWeight: FontWeight.normal,
                              ),
                            ],
                          )),
                    ]),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
