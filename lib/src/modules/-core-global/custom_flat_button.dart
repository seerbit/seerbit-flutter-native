import 'package:flutter/material.dart';

import 'global_components.dart';

class CustomFlatButton extends StatelessWidget {
  const CustomFlatButton({
    Key? key,
    this.label = '',
    required this.onTap,
    this.hasBorder = false,
    this.icon,
    this.expand = false,
    this.alignment,
    this.color,
    this.bgColor,
    this.suffix,
    this.prefix,
    this.elevation = 0,
    this.size,
    this.fsize,
    this.spacetop,
  }) : super(key: key);
  final String label;
  final String? icon;
  final MainAxisAlignment? alignment;
  final bool hasBorder, expand;
  final int elevation;
  final Color? color, bgColor;
  final Function() onTap;
  final Widget? suffix, prefix;
  final Size? size;
  final num? fsize;
  final double? spacetop;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(elevation.toDouble()),
          minimumSize: MaterialStateProperty.all(
              size ?? const Size(double.infinity, 46)),
          maximumSize: MaterialStateProperty.all(
              size ?? const Size(double.infinity, 46)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))),
          side: hasBorder
              ? MaterialStateProperty.all(
                  BorderSide(color: Colors.grey.shade300, width: 1))
              : null,
          splashFactory: NoSplash.splashFactory,
          backgroundColor: MaterialStateProperty.all(bgColor ?? Colors.white)),
      child: Row(
        mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: alignment ??
            (expand ? MainAxisAlignment.center : MainAxisAlignment.start),
        children: [
          Padding(
            padding: EdgeInsets.only(top: spacetop ?? 0),
            child: prefix ??
                CustomText(
                  label,
                  size: fsize ?? 12,
                  color: color ?? Colors.black,
                ),
          ),
          if (suffix != null) suffix!,
        ],
      ),
    );
  }
}
