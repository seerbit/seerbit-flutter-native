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
  }) : super(key: key);
  final String label;
  final String? icon;
  final MainAxisAlignment? alignment;
  final bool hasBorder, expand;
  final int elevation;
  final Color? color, bgColor;
  final Function() onTap;
  final Widget? suffix, prefix;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(elevation.toDouble()),
          minimumSize: MaterialStateProperty.all(const Size(250, 45)),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(7))),
          side: hasBorder
              ? MaterialStateProperty.all(
                  const BorderSide(color: Colors.grey, width: 2))
              : null,
          splashFactory: NoSplash.splashFactory,
          backgroundColor: MaterialStateProperty.all(bgColor ?? Colors.white)),
      child: Row(
        mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: alignment ??
            (expand ? MainAxisAlignment.center : MainAxisAlignment.start),
        children: [
          prefix ??
              CustomText(label,
                  size: 14,
                  color: color ?? Colors.black,
                  weight: FontWeight.bold),
          if (suffix != null) suffix!,
        ],
      ),
    );
  }
}
