import 'package:seerbit_flutter_native/src/models/models.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/bank-account/controllers/bank_account_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';
import 'package:seerbit_flutter_native/src/modules/widgets/amount_to_pay.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class BankAccountPIN extends StatelessWidget {
  const BankAccountPIN({super.key});

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
          const YSpace(30),
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
            onCompleted: (_) => bn.changeView(CurrentCardView.otp),
          )
        ],
      );
    });
  }
}
