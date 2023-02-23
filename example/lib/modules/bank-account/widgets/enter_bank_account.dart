import 'dart:math' as math;

import 'package:example/models/merchant_model.dart';
import 'package:example/models/payment_payload_model.dart';
import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/bank-account/controllers/bank_account_notifier.dart';
import 'package:example/modules/payment_success.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
import 'package:example/modules/view-notifiers/view_state.dart';
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
          const CustomTextField(
            label: "label",
            hint: "10 Digits Bank Account Number",
          ),
          CustomDropDown(
              label: "label",
              hint: "Select Bank",
              value: null,
              items: [
                ...vn.banksModel!.data.merchantBanks
                    .map((e) => e.bankName!)
                    .toList()
              ],
              onChanged: (_) async {
                vn.setPaymentPayload(ppm.copyWith(
                    channelType: _,
                    paymentType: "ACCOUNT",
                    accountName: "${ppm.firstName} ${ppm.lastName}",
                    paymentReference:
                        "ST-1232231${math.Random().nextInt(200000000)}",
                    bankCode: vn.banksModel?.data.merchantBanks
                        .firstWhere((e) => e.bankName != _)
                        .bankCode));
                bn.changeView(CurrentCardView.progress);

                await vn.initiatePayment();
                if (vn.errorMessage == null) {
                  bn.changeView(CurrentCardView.info);
                } else {
                  bn.changeView(CurrentCardView.initializeError);
                }
              }),
          const YSpace(12),
          CustomFlatButton(
              label: "Continue to Payment",
              onTap: () {
                CustomOverlays()
                    .showPopup(const PaymentSuccess(), popPrevious: true);
              },
              expand: true,
              color: Colors.white54,
              bgColor: Colors.grey),
        ],
      );
    });
  }
}
