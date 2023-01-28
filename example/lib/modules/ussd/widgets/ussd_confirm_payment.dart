import 'package:example/modules/-core-global/-core-global.dart';
import 'package:flutter/material.dart';

class UssdConfirmPayment extends StatelessWidget {
  const UssdConfirmPayment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const YSpace(34),
        const CustomText("Hold on tight while we confirm this payment",
            size: 15),
        const YSpace(8),
        LinearProgressIndicator(
          backgroundColor: Colors.grey.shade300,
          valueColor: const AlwaysStoppedAnimation(Colors.black),
        )
      ],
    );
  }
}
