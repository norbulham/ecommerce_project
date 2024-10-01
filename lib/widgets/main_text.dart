import 'dart:ui';

import 'package:flutter/material.dart';

class SemiBoldText extends StatelessWidget {
  String text;
  double fontSize;
  Color color;
  FontWeight fontWeight;
  SemiBoldText({
    super.key,
    required this.text,
    this.fontSize = 18,
    this.color = const Color(0xff000000),
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontFamily: 'Lato',
          fontSize: fontSize,
          fontWeight: fontWeight),
    );
  }
}
