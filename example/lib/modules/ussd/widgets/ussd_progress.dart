import 'package:example/modules/-core-global/-core-global.dart';
import 'package:flutter/material.dart';

class UssdProgress extends StatelessWidget {
  const UssdProgress({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const YSpace(34),
        const CustomText("Please wait", weight: FontWeight.bold, size: 16),
        const YSpace(8),
        LinearProgressIndicator(
          backgroundColor: Colors.grey.shade300,
          valueColor: const AlwaysStoppedAnimation(Colors.black),
        )
      ],
    );
  }
}
