import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/models/models.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/bank-account/controllers/bank_account_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/bank-account/controllers/bank_account_response_model.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';
import 'package:seerbit_flutter_native/src/modules/widgets/amount_to_pay.dart';

class BankAccountOTP extends StatelessWidget {
  BankAccountOTP({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    BankAccountNotifier bn = Provider.of<BankAccountNotifier>(context);
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    return Builder(builder: (context) {
      PaymentPayloadModel ppm = vn.paymentPayload!;
      MerchantDetailModel mdm = vn.merchantDetailModel!;
      BankAccountResponseModel barm =
          vn.paymentResponse as BankAccountResponseModel;
      return Column(
        children: [
          AmountToPay(fee: mdm.payload.cardFee.mc!),
          const YSpace(25),
          CustomText(messageRender(vn.message.toString()),
              align: TextAlign.center, height: 1.5, size: 14),
          const YSpace(16),
          CustomTextField(
            label: "",
            hint: "",
            controller: controller,
            onChanged: (_) {},
          ),
          const YSpace(16),
          CustomFlatButton(
              prefix: bn.loading
                  ? LottieBuilder.asset('assets/loading.json', height: 20)
                  : null,
              onTap: () async {
                bn.changeView(CurrentCardView.progress);
                vn
                    .otpAuthorize(
                        linkingRef: barm.data!.payments!.linkingReference!,
                        otp: controller.text)
                    .then((value) => {
                          vn.confirmTransaction(context, onError: () {
                            bn.changeView(CurrentCardView.paymentError);
                          }),
                        });

                // dcn.changeView(CurrentCardView.redirect);
              },
              expand: true,
              elevation: 5,
              label: "Authorize Payment",
              bgColor: Colors.black,
              color: Colors.white),
        ],
      );
    });
  }
}

messageRender(String message) {
  if (message.toLowerCase().contains("pending")) {
    return "Enter your OTP";
  } else {
    return message;
  }
}
