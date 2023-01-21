import 'package:example/global_components/global_components.dart';
import 'package:flutter/material.dart';

class BankAccountChannel extends StatelessWidget {
  const BankAccountChannel({
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
        const YSpace(42),
        const CustomText("Choose your bank to start this payment", size: 12),
        const YSpace(12),
        const CustomDropDown(
            label: "label",
            hint: "Select Bank",
            value: null,
            items: ["UBA", "Zenith Bank"]),
        const YSpace(12),
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
