import 'package:example/models/models.dart';
import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/bank-account/controllers/bank_account_notifier.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
import 'package:example/modules/widgets/amount_to_pay.dart';
import 'package:flutter/material.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:provider/provider.dart';

class EnterBirthday extends StatefulWidget {
  const EnterBirthday({
    Key? key,
  }) : super(key: key);

  @override
  State<EnterBirthday> createState() => _EnterBirthdayState();
}

class _EnterBirthdayState extends State<EnterBirthday> {
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
          const YSpace(34),
          CustomTextField(
            label: "Enter your birthday",
            hint: "MM/DD/YYYY",
            formatter: [
              DateInputFormatter(),
            ],
            onChanged: (_) {
              vn.setPaymentPayload(ppm.copyWith(dateOfBirth: _));
              if (_.length == 10 && !_.contains("-")) {
                setState(() => hasSelectedBank = true);
              } else {
                setState(() => hasSelectedBank = false);
              }
            },
          ),
          const YSpace(12),
          CustomFlatButton(
              label: "Continue to Payment",
              onTap: !hasSelectedBank
                  ? () {}
                  : () async {
                      bn.chooseRequirementView(ppm, vn);
                    },
              expand: true,
              color: hasSelectedBank ? Colors.white : Colors.white54,
              bgColor: hasSelectedBank ? Colors.black : Colors.grey),
        ],
      );
    });
  }
}
