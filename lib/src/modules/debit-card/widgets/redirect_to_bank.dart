import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/core/navigator.dart';
import 'package:seerbit_flutter_native/src/models/models.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/bank-account/controllers/bank_account_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/debit-card/controllers/debit_card_model.dart';
import 'package:seerbit_flutter_native/src/modules/debit-card/controllers/debit_card_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/payment_success.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';
import 'package:seerbit_flutter_native/src/modules/widgets/amount_to_pay.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RedirectToBank extends StatefulWidget {
  const RedirectToBank({super.key});
  // final DebitCardChannel dcn;
  @override
  State<RedirectToBank> createState() => _RedirectToBankState();
}

class _RedirectToBankState extends State<RedirectToBank> {
  bool isLoading = true;
  bool isSuccessful = false;
  late WebViewController wvc;
  late DebitCardResponseModel dcm;
  late ViewsNotifier vn;

  @override
  void initState() {
    super.initState();

    vn = Provider.of<ViewsNotifier>(context, listen: false);
    DebitCardNotifier dcn =
        Provider.of<DebitCardNotifier>(context, listen: false);
    DebitCardResponseModel dcm =
        (vn.paymentResponse! as DebitCardResponseModel);
    wvc = WebViewController()
      ..loadRequest(Uri.parse(dcm.data!.payments!.redirectUrl!))
      ..setJavaScriptMode(JavaScriptMode.unrestricted);

    wvc.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (_) {
          setState(() => isLoading = true);
          if (_ > 90) {
            setState(() {
              isLoading = false;
            });
          }
        },
        onPageStarted: (_) {
          setState(() => isLoading = true);
        },
        onPageFinished: (_) {
          setState(() => isLoading = false);
        },
        onNavigationRequest: (_) async {
          log(_.url);
          if (_.url.contains("callback")) {
            if (_.url.contains("Successful")) {
              vn.setSecondaryPaymentSuccess(true);
              await Future.delayed(
                  const Duration(seconds: 3), () => Navigator.pop(context));
              CustomOverlays().showPopup(
                  PaymentSuccess(
                    amount: vn.paymentPayload!.amount!,
                    email: vn.paymentPayload!.email!,
                    name:
                        "${vn.paymentPayload!.firstName} ${vn.paymentPayload!.lastName}",
                    logo: vn.merchantDetailModel!.payload.logo!,
                  ),
                  context: context);
              setState(() => isSuccessful = true);

              vn.onSuccess?.call();

              return NavigationDecision.prevent;
            } else {
              vn.setErrorMessage(_.url
                  .split("&message=")
                  .last
                  .split("=")
                  .first
                  .replaceAll("%20", " ")
                  .replaceAll("&reference", ""));

              print("${dcn.currentCardView}");
              Navigate(context).pop();
              vn.onFailure?.call();
              print("${vn.errorMessage}");
              dcn.changeView(CurrentCardView.paymentError);
              return NavigationDecision.prevent;
            }
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    BankAccountNotifier bn = Provider.of<BankAccountNotifier>(context);
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
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
                          StreamBuilder(
                              stream: Stream.periodic(
                                  const Duration(seconds: 1), (_) {
                                if (isSuccessful) {
                                  print("object");
                                  setState(() {
                                    vn.setSecondaryPaymentSuccess(true);
                                  });
                                }
                              }),
                              builder: (context, snapshot) {
                                return WebViewWidget(controller: wvc);
                              }),
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
                // log("message: ${dcm.toJson().toString()}");
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
