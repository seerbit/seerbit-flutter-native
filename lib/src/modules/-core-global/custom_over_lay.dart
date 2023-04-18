import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:seerbit_flutter_native/src/core/navigator.dart';

class CustomOverlays {
  showPopup(child,
      {BuildContext? context,
      bool popPrevious = false,
      Function()? whenComplete}) {
    if (popPrevious) Navigate(context!).pop();
    Navigate(context!).to(child);
    // showDialog(
    //     context: context!,
    //     builder: (context) {
    //       return Dialog(
    //         child: child,
    //         insetPadding: EdgeInsets.zero,
    //       );
    //     }).whenComplete(() => whenComplete?.call());
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
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: SlideInUp(
              child: SizedBox(
                // height: height.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                            onPressed: () => Navigate(context).pop(),
                            icon: const Icon(Icons.close)),
                      ),
                    ),
                    // const YSpace(25),
                    child,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ).then((value) => onClose?.call());
  }
}
