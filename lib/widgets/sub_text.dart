import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class RegularText extends StatelessWidget {
  String text;
  double fontSize;
  Color color;
  FontWeight fontWeight;
  TextDecoration line;
  TextOverflow overflow;
  RegularText(
      {super.key,
      required this.text,
      this.fontSize = 16,
      this.color = const Color(0xff000000),
      this.fontWeight = FontWeight.w400,
      this.overflow = TextOverflow.clip,
      this.line = TextDecoration.none});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          decoration: line,
          color: color,
          fontFamily: 'Lato',
          fontSize: fontSize,
          overflow: overflow,
          fontWeight: fontWeight),
    );
  }
}
