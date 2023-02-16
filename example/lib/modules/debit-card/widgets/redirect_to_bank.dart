import 'dart:developer';

import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/debit-card/controllers/debit_card_model.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RedirectToBank extends StatefulWidget {
  const RedirectToBank({super.key});

  @override
  State<RedirectToBank> createState() => _RedirectToBankState();
}

class _RedirectToBankState extends State<RedirectToBank> {
  bool isLoading = true;
  late WebViewController wvc;
  late DebitCardResponseModel dcm;
  late ViewsNotifier vn;

  @override
  void initState() {
    super.initState();
    vn = Provider.of<ViewsNotifier>(context, listen: false);
    DebitCardResponseModel dcm =
        (vn.paymentResponse! as DebitCardResponseModel);
    wvc = WebViewController()
      ..loadRequest(Uri.parse(dcm.data!.payments!.redirectUrl!));
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                YSpace(12),
                CustomText("NGN 100.00", weight: FontWeight.bold, size: 24),
                YSpace(8),
                CustomText("Fee: NGN1.50", size: 14),
                YSpace(32),
              ],
            ),
          ),
          const CustomText(
              'Please click the button below to authenticate\nwith your bank ',
              align: TextAlign.center,
              height: 1.5,
              size: 12),
          const YSpace(12),
          CustomFlatButton(
              onTap: () {
                CustomOverlays().showPopup(
                  SizedBox(
                    height: 500.h,
                    child: Stack(
                      children: [
                        const Center(
                            child: CircularProgressIndicator(strokeWidth: 1)),
                        WebViewWidget(
                          controller: wvc,
                        ),
                      ],
                    ),
                  ),
                );
                log("message: ${dcm.toJson().toString()}");
              },
              expand: true,
              elevation: 5,
              label: "Authorize Payment",
              bgColor: Colors.black,
              color: Colors.white)
        ],
      );
    });
  }
}
