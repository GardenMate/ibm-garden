import 'package:build_my_garden/sizes_helpers.dart';
import 'package:build_my_garden/widgets/app_large_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyGardenPage extends StatefulWidget {
  const MyGardenPage({Key? key}) : super(key: key);

  @override
  State<MyGardenPage> createState() => _MyGardenPageState();
}

class _MyGardenPageState extends State<MyGardenPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: displayHeight(context),
      width: displayWidth(context),
      child: Container(
        padding: EdgeInsets.zero,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: AppLargeText(text: "Search Bar"),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: AppLargeText(
                  text: "My Garden Status",
                  size: 18,
                  ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(4),
              child: Column(
                children: <Widget>[
                  Image.asset("assets/images/potatoes.png")
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
