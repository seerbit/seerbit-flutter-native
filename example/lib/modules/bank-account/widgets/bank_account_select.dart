import 'dart:math' as math;

import 'package:example/models/merchant_model.dart';
import 'package:example/models/payment_payload_model.dart';
import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/bank-account/controllers/bank_account_notifier.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
import 'package:example/modules/view-notifiers/view_state.dart';
import 'package:example/modules/widgets/amount_to_pay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectBankAccount extends StatefulWidget {
  const SelectBankAccount({
    Key? key,
  }) : super(key: key);

  @override
  State<SelectBankAccount> createState() => _SelectBankAccountState();
}

class _SelectBankAccountState extends State<SelectBankAccount> {
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
          const CustomText("Choose your bank to start this payment",
              size: 12, weight: FontWeight.bold),
          const YSpace(12),
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
                    dateOfBirth: null,
                    bvn: null,
                    paymentReference:
                        "ST-1232231${math.Random().nextInt(200000000)}",
                    bankCode: vn.banksModel?.data.merchantBanks
                        .firstWhere((e) => e.bankName != _)
                        .bankCode));
                setState(() => hasSelectedBank = true);
              }),
          const YSpace(12),
          CustomFlatButton(
              label: "Continue to Payment",
              onTap: hasSelectedBank
                  ? () {
                      bn.changeView(CurrentCardView.info);
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
