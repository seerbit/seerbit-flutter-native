import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/models/models.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/debit-card/controllers/debit_card_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';
import 'package:seerbit_flutter_native/src/modules/widgets/amount_to_pay.dart';

class InputPIN extends StatelessWidget {
  const InputPIN({super.key});

  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    DebitCardNotifier dcn = Provider.of<DebitCardNotifier>(context);
    return Builder(builder: (context) {
      PaymentPayloadModel ppm = vn.paymentPayload!;
      MerchantDetailModel mdm = vn.merchantDetailModel!;
      return Column(
        children: [
          AmountToPay(fee: mdm.payload.cardFee.mc!),
          
          const CustomText(
              'Enter your 4-digit card pin to authorize\nthis payment',
              align: TextAlign.center,
              height: 1.5,
              size: 14),
          const YSpace(16),
          Pinput(
            length: 4,
            obscuringWidget: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(1000)),
            ),
            obscureText: true,
            showCursor: true,
            defaultPinTheme: PinTheme(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onCompleted: (_) async {
              dcn.changeView(CurrentCardView.progress);
              vn.setPaymentPayload(ppm.copyWith(
                  pin: _,
                  paymentReference:
                      'SBT-T54267${Random().nextInt(29091020)}101122472'));
              await vn.initiatePayment();
              if (vn.errorMessage == null) {
                dcn.changeView(CurrentCardView.otp);
              } else {
                dcn.changeView(CurrentCardView.paymentError);
              }
            },
          ),
          const YSpace(250)
        ],
      );
    });
  }
}
