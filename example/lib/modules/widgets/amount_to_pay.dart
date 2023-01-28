import 'package:example/models/merchant_model.dart';
import 'package:example/models/payment_payload_model.dart';
import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AmountToPay extends StatelessWidget {
  const AmountToPay({Key? key, required this.fee}) : super(key: key);
  final String fee;

  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    return Builder(builder: (context) {
      PaymentPayloadModel ppm = vn.paymentPayload!;
      
      return Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const YSpace(12),
              CustomText("NGN ${ppm.amount}",
                  weight: FontWeight.bold, size: 24),
              const YSpace(8),
              CustomText("Fee: NGN$fee", size: 14),
            ],
          ),
        ],
      );
    });
  }
}
