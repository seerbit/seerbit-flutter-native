import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navigate {
  Navigate(this.context);
  final BuildContext context;

  to(Widget screen) {
    Navigator.push(
        context,
        Platform.isIOS
            ? CupertinoPageRoute(builder: (context) => screen)
            : MaterialPageRoute(builder: (context) => screen));
  }

  replace(Widget screen) {
    Navigator.pushReplacement(
        context,
        Platform.isIOS
            ? CupertinoPageRoute(builder: (context) => screen)
            : MaterialPageRoute(builder: (context) => screen));
  }

  pop({int number = 1}) {
    for (var i = 0; i < number; i++) {
      Navigator.pop(context);
    }
  }

  replaceUntil(Widget screen) {
    Navigator.pushAndRemoveUntil(
        context,
        Platform.isIOS
            ? CupertinoPageRoute(builder: (context) => screen)
            : MaterialPageRoute(builder: (context) => screen),
        (_) => false);
  }
}
