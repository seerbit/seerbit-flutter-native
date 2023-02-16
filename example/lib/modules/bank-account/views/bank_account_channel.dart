import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/payment_success.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BankAccountChannel extends StatelessWidget {
  const BankAccountChannel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const YSpace(12),
        const CustomText("NGN 100.00", weight: FontWeight.bold, size: 24),
        const YSpace(8),
        const CustomText("Fee: NGN1.50", size: 14),
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
            ]),
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
  }
}
