import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({
    Key? key,
    this.amount,
  }) : super(key: key);
  final String? amount;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const YSpace(34),
          LottieBuilder.network(
              "https://assets8.lottiefiles.com/packages/lf20_vhhoyvvc.json"),
          const YSpace(24),
          CustomText(
            "NGN $amount",
            size: 24,
            isMoney: true,
          ),
          const YSpace(25),
          const CustomText("Your transaction was successful", size: 20)
        ],
      ),
    );
  }
}
