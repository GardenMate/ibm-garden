import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  final double size;
  final String text;
  final Color color;
  final double letterSpacing;
  final FontWeight fontWeight;

  const AppText(
      {Key? key,
      this.size = 16,
      this.letterSpacing = 0,
      this.fontWeight = FontWeight.w600,
      required this.text,
      this.color = const Color.fromARGB(255, 67, 61, 61)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        fontFamily: 'Inter',
        letterSpacing: letterSpacing,
      ),
    );
  }
}
