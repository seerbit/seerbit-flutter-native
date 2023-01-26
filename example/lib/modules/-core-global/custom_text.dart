import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  const CustomText(this.text,
      {Key? key,
      required this.size,
      this.weight = FontWeight.normal,
      this.height = 1,
      this.color = Colors.black,
      this.align = TextAlign.left,
      this.isMoney = false,
      this.overflow,
      this.fontStyle,
      this.animate = false,
      this.decoration})
      : super(key: key);
  final String text;
  final num size;
  final double height;
  final FontWeight weight;
  final Color color;
  final TextAlign align;
  final TextOverflow? overflow;
  final FontStyle? fontStyle;
  final bool isMoney;
  final bool animate;
  final TextDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: align,
        style: TextStyle(
            fontSize: size.sp,
            fontWeight: weight,
            decoration: decoration,
            color: color,
            height: height));
  }
}
