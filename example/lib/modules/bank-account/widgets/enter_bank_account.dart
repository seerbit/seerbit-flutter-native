import 'package:example/models/models.dart';
import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/bank-account/controllers/bank_account_notifier.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
import 'package:example/modules/widgets/amount_to_pay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnterBankAccount extends StatelessWidget {
  const EnterBankAccount({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    BankAccountNotifier bn = Provider.of<BankAccountNotifier>(context);
    return Builder(builder: (context) {
      PaymentPayloadModel ppm = vn.paymentPayload!;
      MerchantDetailModel mdm = vn.merchantDetailModel!;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AmountToPay(fee: mdm.payload.cardFee.mc!),
          const YSpace(24),
          CustomText("Enter your  ${ppm.channelType}  Account Number",
              size: 12, weight: FontWeight.bold),
          const YSpace(12),
          CustomTextField(
            label: "",
            hint: "10 Digits Bank Account Number",
            onChanged: (_) {
              vn.setPaymentPayload(ppm.copyWith(accountNumber: _));
            },
          ),
          const YSpace(12),
          CustomFlatButton(
              label: "Continue to Payment",
              onTap: () async {
                bn.chooseRequirementView(ppm, vn);
              },
              expand: true,
              color: Colors.white54,
              bgColor: Colors.grey),
        ],
      );
    });
  }
}
