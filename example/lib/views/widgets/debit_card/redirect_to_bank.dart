import 'package:example/global_components/global_components.dart';
import 'package:flutter/material.dart';

class RedirectToBank extends StatelessWidget {
  const RedirectToBank({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              YSpace(12),
              CustomText("NGN 100.00", weight: FontWeight.bold, size: 24),
              YSpace(8),
              CustomText("Fee: NGN1.50", size: 14),
              YSpace(32),
            ],
          ),
        ),
        const CustomText(
            'Please click the button below to authenticate\nwith your bank ',
            align: TextAlign.center,
            height: 1.5,
            size: 12),
        const YSpace(12),
        CustomFlatButton(
            onTap: () {},
            expand: true,
            elevation: 5,
            label: "Authorize Payment",
            bgColor: Colors.black,
            color: Colors.white)
      ],
    );
  }
}
