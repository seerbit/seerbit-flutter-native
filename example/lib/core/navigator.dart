import 'dart:io';

import 'package:example/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navigate {
  Navigate();
  static to(Widget screen) {
    BuildContext context = navigatorKey.currentContext!;
    Navigator.push(
        context,
        Platform.isIOS
            ? CupertinoPageRoute(builder: (context) => screen)
            : MaterialPageRoute(builder: (context) => screen));
  }

  static replace(Widget screen) {
    BuildContext context = navigatorKey.currentContext!;

    Navigator.pushReplacement(
        context,
        Platform.isIOS
            ? CupertinoPageRoute(builder: (context) => screen)
            : MaterialPageRoute(builder: (context) => screen));
  }

  static pop({int number = 1}) {
    BuildContext context = navigatorKey.currentContext!;

    for (var i = 0; i < number; i++) {
      Navigator.pop(context);
    }
  }

  static replaceUntil(Widget screen) {
    BuildContext context = navigatorKey.currentContext!;
    Navigator.pushAndRemoveUntil(
        context,
        Platform.isIOS
            ? CupertinoPageRoute(builder: (context) => screen)
            : MaterialPageRoute(builder: (context) => screen),
        (_) => false);
  }
}
