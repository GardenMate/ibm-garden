import 'package:build_my_garden/main.dart';
import 'package:build_my_garden/pages/navpages/marketplace_listing.dart';
import 'package:build_my_garden/pages/subpages/create_new_seller.dart';
import 'package:build_my_garden/widgets/app_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';



class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/img6.gif"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            // Stack(children: <Widget>[
            //   Positioned.fill(
            //     child: Image(
            //       image: AssetImage('assets/images/img6.gif'),
            //       fit: BoxFit.fill,
            //     ),
            //   ),
            // ]),

            // DecoratedBox(
            //   decoration: BoxDecoration(
            //     image: DecorationImage(4
            //         image: AssetImage("assets/images/img6.gif"),
            //         fit: BoxFit.cover),
            //   ),
            // ),
            // Container(
            //   decoration: BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage("assets/images/img6.gif"),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
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
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                  width: 150,
                  child: InkWell(
                    highlightColor: Colors.white.withOpacity(0.5),
                    splashColor: Colors.white.withOpacity(0.5),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainApp()));
                    },
                    child: Ink(
                      // margin: EdgeInsets.only(left: 40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 8, 78, 83),
                      ),
                      child: Center(
                        child: AppText(
                          text: "Shopper",
                          color: Color.fromARGB(255, 255, 255, 255),
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15),
                SizedBox(
                  height: 60,
                  width: 150,
                  child: InkWell(
                    highlightColor: Colors.white.withOpacity(0.5),
                    splashColor: Colors.white.withOpacity(0.5),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const addSellerPage()));
                    },
                    child: Ink(
                      // margin: EdgeInsets.only(left: 40),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 8, 78, 83),
                      ),
                      child: Center(
                        child: AppText(
                          text: "Gardener",
                          color: Color.fromARGB(255, 255, 255, 255),
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
