import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/ussd/controllers/ussd_notifier.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UssdSelectBank extends StatelessWidget {
  const UssdSelectBank({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UssdNotifier un = Provider.of<UssdNotifier>(context);
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
            onChanged: (_) async {
              un.changeView(CurrentCardView.progress);
              await vn.initiatePayment();
              un.changeView(CurrentCardView.showUssd);
            },
            items: const ["UBA", "Zenith Bank"]),
      ],
    );
  }
}
