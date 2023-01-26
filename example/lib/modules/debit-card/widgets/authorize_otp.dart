import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/debit-card/controllers/debit_card_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthorizeOTP extends StatelessWidget {
  const AuthorizeOTP({super.key});

  @override
  Widget build(BuildContext context) {
    DebitCardNotifier dcn = Provider.of<DebitCardNotifier>(context);
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
            'Kindly enter the OTP sent to *******9502 and\no***********@gmail.com or enter the OTP genrates\non your hardware token device',
            align: TextAlign.center,
            height: 1.5,
            size: 12),
        const YSpace(16),
        const CustomTextField(label: ""),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
              onPressed: () {},
              child: const CustomText("Resend OTP",
                  size: 14, weight: FontWeight.bold)),
        ),
        const YSpace(16),
        CustomFlatButton(
            onTap: () {
              dcn.changeView(CurrentCardView.redirect);
            },
            expand: true,
            elevation: 5,
            label: "Authorize Payment",
            bgColor: Colors.black,
            color: Colors.white)
      ],
    );
  }
}
