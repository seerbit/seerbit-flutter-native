import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/models/models.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/bank-account/controllers/bank_account_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/widgets/amount_to_pay.dart';

class EnterBankAccount extends StatefulWidget {
  const EnterBankAccount({
    Key? key,
  }) : super(key: key);

  @override
  State<EnterBankAccount> createState() => _EnterBankAccountState();
}

class _EnterBankAccountState extends State<EnterBankAccount> {
  bool hasSelectedBank = false;
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
              size: 12, weight: FontWeight.w500),
          const YSpace(12),
          CustomTextField(
            label: "",
            hint: "10 Digits Bank Account Number",
            formatter: [LengthLimitingTextInputFormatter(10)],
            inputType: TextInputType.number,
            onChanged: (_) {
              vn.setPaymentPayload(ppm.copyWith(accountNumber: _));
              if (_.length == 10) {
                setState(() => hasSelectedBank = true);
              } else {
                setState(() => hasSelectedBank = false);
              }
            },
          ),
          const YSpace(12),
          CustomFlatButton(
              label: "Continue to Payment",
              onTap: hasSelectedBank
                  ? () async {
                      bn.chooseRequirementView(ppm, vn);
                    }
                  : () {},
              expand: true,
              color: hasSelectedBank ? Colors.white : Colors.white54,
              bgColor: hasSelectedBank ? Colors.black : Colors.grey),
        ],
      );
    });
  }
}

// 1429428273