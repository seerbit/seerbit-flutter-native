import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/models/models.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/bank-account/controllers/bank_account_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/widgets/amount_to_pay.dart';

class EnterBVN extends StatefulWidget {
  const EnterBVN({
    Key? key,
  }) : super(key: key);

  @override
  State<EnterBVN> createState() => _EnterBVNState();
}

class _EnterBVNState extends State<EnterBVN> {
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
            label: "Enter your BVN",
            hint: "11 digit Bank Verification Number",
            inputType: TextInputType.number,
            formatter: [
              LengthLimitingTextInputFormatter(11),
              FilteringTextInputFormatter.digitsOnly
            ],
            onChanged: (_) {
              vn.setPaymentPayload(ppm.copyWith(bvn: _));
              if (_.length == 11) {
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
