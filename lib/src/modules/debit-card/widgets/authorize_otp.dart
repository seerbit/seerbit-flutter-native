import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/models/models.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/debit-card/controllers/debit_card_model.dart';
import 'package:seerbit_flutter_native/src/modules/debit-card/controllers/debit_card_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';
import 'package:seerbit_flutter_native/src/modules/widgets/amount_to_pay.dart';

class AuthorizeOTP extends StatelessWidget {
  AuthorizeOTP({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DebitCardNotifier dcn = Provider.of<DebitCardNotifier>(context);
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    return Builder(builder: (context) {
      PaymentPayloadModel ppm = vn.paymentPayload!;
      MerchantDetailModel mdm = vn.merchantDetailModel!;
      DebitCardResponseModel dcrm =
          vn.paymentResponse as DebitCardResponseModel;
      return Column(
        children: [
          const YSpace(12),
          AmountToPay(fee: mdm.payload.cardFee.mc!),
          const YSpace(25),
          CustomText(vn.message.toString(),
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
              prefix: dcn.loading
                  ? LottieBuilder.asset('assets/loading.json', height: 20)
                  : null,
              onTap: () async {
                dcn.changeView(CurrentCardView.progress);
                vn
                    .otpAuthorize(
                        linkingRef: dcrm.data!.payments!.linkingReference!,
                        otp: controller.text)
                    .then((value) =>
                        vn.confirmTransaction(context, onError: () {}));

                // dcn.changeView(CurrentCardView.redirect);
              },
              expand: true,
              elevation: 5,
              label: "Authorize Payment",
              bgColor: Colors.black,
              color: Colors.white),
          const YSpace(200),
        ],
      );
    });
  }
}
