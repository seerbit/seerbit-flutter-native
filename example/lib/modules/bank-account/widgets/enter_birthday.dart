import 'package:example/models/models.dart';
import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/bank-account/controllers/bank_account_notifier.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
import 'package:example/modules/view-notifiers/view_state.dart';
import 'package:example/modules/widgets/amount_to_pay.dart';
import 'package:flutter/material.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:provider/provider.dart';

class EnterBirthday extends StatelessWidget {
  const EnterBirthday({
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
          const YSpace(34),
          CustomTextField(
            label: "Enter your birthday",
            hint: "MM/DD/YYYY",
            formatter: [
              DateInputFormatter(),
            ],
            onChanged: (_) {
              vn.setPaymentPayload(ppm.copyWith(dateOfBirth: _));
            },
          ),
          const YSpace(12),
          CustomFlatButton(
              label: "Continue to Payment",
              onTap: () async {
                MerchantBank mb = vn.banksModel!.data.merchantBanks.firstWhere(
                    (element) => element.bankName == ppm.channelType);
                if (mb.requiredFields.bvn == "YES") {
                  bn.changeView(CurrentCardView.bvn);
                }
                // bn.changeView(CurrentCardView.progress);
                // await vn.initiatePayment();
                // if (vn.errorMessage == null) {
                //   bn.changeView(CurrentCardView.info);
                // } else {
                //   bn.changeView(CurrentCardView.initializeError);
                // }

                // CustomOverlays()
                //     .showPopup(const PaymentSuccess(), popPrevious: true);
              },
              expand: true,
              color: Colors.white54,
              bgColor: Colors.grey),
        ],
      );
    });
  }
}
