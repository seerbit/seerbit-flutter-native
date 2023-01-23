import 'package:example/global_components/global_components.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class InputPIN extends StatelessWidget {
  const InputPIN({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        CustomText('Enter your 4-digit card pin to authorize this payment',
            size: 12),
        YSpace(10),
        Pinput(length: 4)
      ],
    );
  }
}
