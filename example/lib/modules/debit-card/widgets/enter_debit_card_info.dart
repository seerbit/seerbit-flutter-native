import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/debit-card/controllers/debit_card_notifier.dart';
import 'package:example/modules/view-notifiers/view_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnterDebitCardInfo extends StatelessWidget {
  const EnterDebitCardInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DebitCardNotifier dcn = Provider.of<DebitCardNotifier>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const YSpace(12),
        const CustomText("NGN 100.00", weight: FontWeight.bold, size: 24),
        const YSpace(8),
        const CustomText("Fee: NGN1.50", size: 14),
        const YSpace(32),
        const CustomTextField(
            label: "Debit/credit card details", hint: "Card number"),
        Row(
          children: const [
            Expanded(
              child: CustomTextField(
                label: "",
                hint: "MM/YY",
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
              ),
            ),
            Expanded(
                child: CustomTextField(
              label: "",
              hint: "CVV",
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10)),
            )),
          ],
        ),
        const YSpace(20),
        CustomFlatButton(
            label: "Continue to Payment",
            onTap: () => dcn.changeView(CurrentCardView.pin),
            expand: true,
            color: Colors.white54,
            bgColor: Colors.grey),
      ],
    );
  }
}
