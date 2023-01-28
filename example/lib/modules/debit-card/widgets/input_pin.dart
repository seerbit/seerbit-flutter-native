import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/debit-card/controllers/debit_card_notifier.dart';
import 'package:example/modules/view-notifiers/view_state.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class InputPIN extends StatelessWidget {
  const InputPIN({super.key});

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
            'Enter your 4-digit card pin to authorize\nthis payment',
            align: TextAlign.center,
            height: 1.5,
            size: 14),
        const YSpace(16),
        Pinput(
          length: 4,
          obscuringWidget: Container(
            height: 10,
            width: 10,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(1000)),
          ),
          obscureText: true,
          showCursor: true,
          defaultPinTheme: PinTheme(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onCompleted: (_) => dcn.changeView(CurrentCardView.otp),
        )
      ],
    );
  }
}
