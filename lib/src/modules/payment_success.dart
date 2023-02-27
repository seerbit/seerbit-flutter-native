import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const YSpace(34),
        LottieBuilder.network(
            "https://assets8.lottiefiles.com/packages/lf20_vhhoyvvc.json"),
        const YSpace(24),
        CustomText(
          "NGN ${vn.paymentPayload!.amount}",
          size: 24,
          isMoney: true,
        ),
        const YSpace(25),
        const CustomText("Your transaction was successful", size: 20)
      ],
    );
  }
}
