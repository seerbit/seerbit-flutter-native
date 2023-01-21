import 'package:example/global_components/global_components.dart';
import 'package:flutter/material.dart';

class DebitCardChannel extends StatelessWidget {
  const DebitCardChannel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const YSpace(12),
        const CustomText("NGN 100.00", weight: FontWeight.bold, size: 24),
        const YSpace(8),
        const CustomText("Fee: NGN1.50", size: 14),
        const YSpace(32),
        const CustomTextField(
          label: "Debit/credit card details",
          hint: "Card number",
        ),
        Row(
          children: const [
            Expanded(child: CustomTextField(label: "", hint: "MM/YY")),
            Expanded(
                child: CustomTextField(
              label: "",
              hint: "CVV",
            )),
          ],
        ),
        const YSpace(20),
        CustomFlatButton(
            label: "Continue to Payment",
            onTap: () {},
            expand: true,
            color: Colors.white54,
            bgColor: Colors.grey),
      ],
    );
  }
}
