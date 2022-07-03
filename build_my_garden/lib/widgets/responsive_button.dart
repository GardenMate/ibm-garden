import 'package:build_my_garden/widgets/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResponsiveButton extends StatelessWidget {
  // A reusable button that takes in text,
  // an onPress function and width (optional)
  // to generate a button
  bool? isResponsive;
  double? width;
  String text;
  Color textColor;
  Color buttonColor;
  Function() onPress;
  ResponsiveButton(
      {Key? key,
      this.text = "",
      this.width,
      this.isResponsive = false,
      this.textColor = const Color.fromARGB(255, 59, 87, 48),
      this.buttonColor = const Color.fromARGB(255, 181, 255, 180),
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: buttonColor,
      ),
      child: TextButton(
        onPressed: onPress,
        child: Container(
          margin: const EdgeInsets.only(left: 30, right: 30),
          child: AppText(
            text: text,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
