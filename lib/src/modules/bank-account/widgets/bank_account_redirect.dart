import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/core/navigator.dart';
import 'package:seerbit_flutter_native/src/models/models.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/bank-account/controllers/bank_account_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/bank-account/controllers/bank_account_response_model.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/widgets/amount_to_pay.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../view-notifiers/view_state.dart';

class BankAccounRedirect extends StatefulWidget {
  const BankAccounRedirect({super.key});

  @override
  State<BankAccounRedirect> createState() => _BankAccounRedirectState();
}

class _BankAccounRedirectState extends State<BankAccounRedirect> {
  bool isLoading = true;
  late WebViewController wvc;
  late BankAccountResponseModel brm;
  late ViewsNotifier vn;
  late BankAccountNotifier bn;

  @override
  void initState() {
    super.initState();
    vn = Provider.of<ViewsNotifier>(context, listen: false);
    bn = Provider.of<BankAccountNotifier>(context, listen: false);
    BankAccountResponseModel brm =
        (vn.paymentResponse! as BankAccountResponseModel);
    wvc = WebViewController()
      ..loadRequest(Uri.parse(brm.data!.payments!.redirectUrl!))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
    if (mounted) {
      wvc.setNavigationDelegate(
        NavigationDelegate(
          onProgress: (_) {
            setState(() => isLoading = true);
          },
          onPageStarted: (_) async {
            Future.delayed(const Duration(seconds: 2));
            setState(() => isLoading = false);
          },
          onPageFinished: (_) {
            setState(() => isLoading = false);
          },
          onNavigationRequest: (_) {
            log(_.url);
            if (_.url == "https://seerbitapigateway.com/") {
              Navigate(context).pop();
            }
            if (_.url.contains("callback")) {
              if (_.url.contains("Successful")) {
                vn.confirmTransaction(context, onError: () {});
                Future.delayed(Duration.zero, () => {vn.onSuccess?.call()});
              } else {
                vn.setErrorMessage(_.url
                    .split("&message=")
                    .last
                    .split("=")
                    .first
                    .replaceAll("%20", " ")
                    .replaceAll("&reference", ""));

                // print("${dcn.currentCardView}");
                Navigate(context).pop();
                vn.onFailure?.call();
                print("${vn.errorMessage}");
                bn.changeView(CurrentCardView.paymentError);
                return NavigationDecision.prevent;
              }
            }
            return NavigationDecision.navigate;
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      PaymentPayloadModel ppm = vn.paymentPayload!;
      MerchantDetailModel mdm = vn.merchantDetailModel!;
      return Column(
        children: [
          AmountToPay(fee: mdm.payload.cardFee.mc!),
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
                      height: 812.h,
                      child: Stack(
                        children: [
                          WebViewWidget(
                            controller: wvc,
                          ),
                          // Center(child: Text(isLoading.toString())),
                          Visibility(
                            visible: isLoading,
                            child: const Center(
                                child:
                                    CircularProgressIndicator(strokeWidth: 1)),
                          ),
                        ],
                      ),
                    ),
                    context: context);
                // log("message: ${brm.toJson().toString()}");
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
