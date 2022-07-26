import 'package:build_my_garden/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            margin: EdgeInsets.only(top: 100),
            child: Center(
              child: AppText(
                text: "You are a :",
                size: 30,
                color: Color.fromARGB(255, 8, 78, 83),
              ),
            ),
          ),
          SizedBox(
            height: 60,
            width: 120,
            child: Container(
              margin: EdgeInsets.only(),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black,
              ),
              child: AppText(text: "Shopper"),
              
            ),
          )
        ],
      ),
    );
  }
}
