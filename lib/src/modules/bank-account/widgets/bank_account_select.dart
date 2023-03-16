import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/models/merchant_model.dart';
import 'package:seerbit_flutter_native/src/models/payment_payload_model.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/bank-account/controllers/bank_account_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';
import 'package:seerbit_flutter_native/src/modules/widgets/amount_to_pay.dart';

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
      // if (vn.banksModel == null) return const SizedBox();
      return FutureBuilder(
          future: vn.getBanks(),
          builder: (context, snapshot) {
            if (vn.banksModel == null) const CircularProgressIndicator();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AmountToPay(fee: mdm.payload.cardFee.mc!),
                const YSpace(24),
                const CustomText("Choose your bank to start this payment",
                    size: 12, weight: FontWeight.w500),
                const YSpace(12),
                CustomDropDown(
                    label: "label",
                    hint: "Select Bank",
                    value: null,
                    items: [
                      ...?vn.banksModel?.data.merchantBanks
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
                              .firstWhere((e) => e.bankName == _)
                              .bankCode));
                      print(vn.paymentPayload!.toJson());
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
    });
  }
}
