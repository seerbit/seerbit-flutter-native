import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/core/navigator.dart';
import 'package:seerbit_flutter_native/src/models/models.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/bank-account/controllers/bank_account_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/debit-card/controllers/debit_card_model.dart';
import 'package:seerbit_flutter_native/src/modules/debit-card/controllers/debit_card_notifier.dart';
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
          setState(() => isLoading = false);
        },
        onPageStarted: (_) {
          setState(() => isLoading = true);
        },
        onPageFinished: (_) {
          setState(() => isLoading = false);
        },
        onNavigationRequest: (_) async {
          String url = _.url.toLowerCase();
          if (url.contains("callback") || url.contains("linkingreference")) {
            if (url.contains("successful") ||
                url.contains(vn.paymentPayload!.redirectUrl!)) {
              vn.setSecondaryPaymentSuccess(true);
              vn.onSuccess?.call();
              setState(() => isSuccessful = true);
              Navigate(context).pop();
              vn.showSuccess(context, "00", overlay: true, popCount: 2);

              return NavigationDecision.prevent;
            } else if (_.url.contains("&message")) {
              vn.setErrorMessage(_.url
                  .split("&message=")
                  .last
                  .split("=")
                  .first
                  .replaceAll("%20", " ")
                  .replaceAll("&reference", ""));

              Navigate(context).pop();
              vn.onFailure?.call();

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
          const YSpace(20),
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
                          SizedBox(
                            height: 812.h,
                            child: Stack(
                              children: [
                                StreamBuilder(
                                    stream: Stream.periodic(
                                        const Duration(seconds: 1), (_) {
                                      if (isSuccessful) {
                                        vn.setSecondaryPaymentSuccess(true);
                                      }
                                    }),
                                    builder: (context, snapshot) {
                                      return WebViewWidget(controller: wvc);
                                    }),
                                // Center(child: Text(isLoading.toString())),
                                Visibility(
                                  visible: isLoading,
                                  child: const Center(
                                      child: CupertinoActivityIndicator(
                                          radius: 15)),
                                ),
                              ],
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: TextButton(
                              onPressed: () => Navigate(context).pop(),
                              child: const Text(
                                "Cancel (x)",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          )
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
