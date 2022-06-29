import 'package:build_my_garden/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';

class ResponsiveButton extends StatelessWidget {
  bool? isResponsive;
  double? width;
  String text;
  ResponsiveButton(
      {Key? key, this.text = "", this.width, this.isResponsive = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 181, 255, 180),
      ),
      child: Container(
        margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
        child: AppText(
          text: text,
          color: Color.fromARGB(255, 59, 87, 48),
        ),
      ),
    );
  }
}