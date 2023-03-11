import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/models/models.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/bank-account/controllers/bank_account_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/widgets/amount_to_pay.dart';

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
              'Kindly enter the OTP sent to your mobile number or email',
              align: TextAlign.center,
              height: 1.5,
              size: 14),
          const YSpace(30),
          const CustomTextField(
            label: "",
            hint: "Enter OTP",
          ),
          const YSpace(24),
          CustomFlatButton(
            onTap: () {},
            color: Colors.white,
            bgColor: Colors.black,
            label: "Authorize Payment",
          )
        ],
      );
    });
  }
}
