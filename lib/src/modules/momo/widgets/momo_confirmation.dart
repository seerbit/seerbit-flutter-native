import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/models/models.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/momo/controllers/momo_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/momo/controllers/momo_response_model.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';
import 'package:seerbit_flutter_native/src/modules/widgets/amount_to_pay.dart';

class MomoAuthorize extends StatelessWidget {
  MomoAuthorize({super.key});
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // BankAccountNotifier bn = Provider.of<BankAccountNotifier>(context);

    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    MomoNotifier mn = Provider.of<MomoNotifier>(context);
    return Builder(builder: (context) {
      PaymentPayloadModel ppm = vn.paymentPayload!;
      MerchantDetailModel mdm = vn.merchantDetailModel!;
      MomoResponseModel mrm = vn.paymentResponse as MomoResponseModel;
      return Column(
        children: [
          AmountToPay(fee: mdm.payload.cardFee.mc!),
          const YSpace(30),
          const CustomText(
              'Kindly enter the OTP sent to your mobile number or email',
              align: TextAlign.center,
              height: 1.5,
              size: 14),
          const YSpace(30),
          CustomTextField(
            controller: controller,
            label: "",
            hint: "Enter OTP",
          ),
          const YSpace(24),
          CustomFlatButton(
            onTap: () {
              mn.changeView(CurrentCardView.progress);
              vn
                  .otpMomoAuthorize(
                      linkingRef: mrm.data!.payments!.linkingReference!,
                      otp: controller.text)
                  .then((value) => {
                        if (vn.errorMessage == null)
                          {
                            vn.confirmTransaction(context, onError: () {
                              mn.changeView(CurrentCardView.paymentError);
                            }),
                          }
                        else
                          {mn.changeView(CurrentCardView.paymentError)}
                      });
            },
            color: Colors.white,
            bgColor: Colors.black,
            label: "Authorize Payment",
          )
        ],
      );
    });
  }
}
