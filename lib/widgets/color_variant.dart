import 'package:flutter/material.dart';
import 'package:multi_ecommerce/constant/color_constraint.dart';

class CircularColorVariant extends StatelessWidget {
  Color? clr;
  Color? bgClr;
  CircularColorVariant(
      {super.key,
      this.clr = const Color(0xff000000),
      this.bgClr = const Color(0xffffffff)});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(color: bgClr, shape: BoxShape.circle),
      child: Center(
        child: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(color: clr, shape: BoxShape.circle),
        ),
      ),
    );
  }
}
