import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seerbit_flutter_native/src/core/navigator.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';

class CustomOverlays {
  showPopup(child,
      {BuildContext? context,
      bool popPrevious = false,
      Function()? whenComplete}) {
    if (popPrevious) Navigate(context!).pop();
    showDialog(
        context: context!,
        builder: (context) {
          return Dialog(
            child: child,
            insetPadding: EdgeInsets.zero,
          );
        }).whenComplete(() => whenComplete?.call());
  }

  showSheet(
      {required child,
      BuildContext? context,
      Function()? onClose,
      bool popPrevious = false}) {
    if (popPrevious) Navigate(context!).pop();
    showModalBottomSheet(
      isScrollControlled: true,
      context: context!,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: SlideInUp(
                child: SizedBox(
                  // height: height.h,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 18.w),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                                onPressed: () => Navigate(context).pop(),
                                icon: const Icon(Icons.close)),
                          ),
                        ),
                        const YSpace(25),
                        child,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ).then((value) => onClose?.call());
  }
}
