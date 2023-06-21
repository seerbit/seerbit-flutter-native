import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/models/merchant_model.dart';
import 'package:seerbit_flutter_native/src/models/payment_payload_model.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';

class AmountToPay extends StatelessWidget {
  const AmountToPay({Key? key, required this.fee}) : super(key: key);
  final String fee;

  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    return Builder(builder: (context) {
      PaymentPayloadModel ppm = vn.paymentPayload!;
      MerchantDetailModel mdm = vn.merchantDetailModel!;

      return Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const YSpace(12),
              CustomText(
                  "${vn.defaultCurrency} ${double.parse(ppm.amount!) + double.parse(vn.calculateFees())}",
                  weight: FontWeight.bold,
                  size: 24),
              const YSpace(8),
              if (vn.isMerchantPayingFees())
                CustomText(
                    "Fee: ${vn.defaultCurrency}${vn.calculateFees().toString()}",
                    size: 14)
              // FutureBuilder(
              //     future: vn.calculateFees(),
              //     builder: (context, snapshot) {
              //       if (!snapshot.hasData) const SizedBox();
              //       return CustomText(
              //           "Fee: NGN${vn.calculateFees().toString()}",
              //           size: 14);
              //     }),
            ],
          ),
        ],
      );
    });
  }
}
