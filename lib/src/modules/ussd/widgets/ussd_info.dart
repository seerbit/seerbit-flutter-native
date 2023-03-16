import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/models/models.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/ussd/controllers/ussd_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/ussd/controllers/ussd_response_model.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';
import 'package:seerbit_flutter_native/src/modules/widgets/amount_to_pay.dart';

class UssdInfo extends StatelessWidget {
  const UssdInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    UssdNotifier un = Provider.of<UssdNotifier>(context);
    return Builder(builder: (context) {
      PaymentPayloadModel ppm = vn.paymentPayload!;
      MerchantDetailModel mdm = vn.merchantDetailModel!;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AmountToPay(
            fee: mdm.payload.cardFee.mc!,
          ),
          const YSpace(34),
          const CustomText("Dial the code below to complete this payment",
              size: 13),
          const YSpace(18),
          Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(0),
            child: Padding(
              padding: EdgeInsets.only(top: 5.h, bottom: 0.h) +
                  EdgeInsets.symmetric(horizontal: 20.w),
              child: Center(
                child: CustomText(
                    (vn.paymentResponse as UssdResponseModel)
                        .data
                        .payments
                        .ussdDailCode,
                    size: 28,
                    weight: FontWeight.w900),
              ),
            ),
          ),
          TextButton(
            child: const CustomText("Click to copy code", size: 14),
            onPressed: () => Clipboard.setData(ClipboardData(
                    text: (vn.paymentResponse as UssdResponseModel)
                        .data
                        .payments
                        .ussdDailCode))
                .then((_) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("USSD copied")));
            }),
          ),
          const YSpace(8),
          CustomFlatButton(
            onTap: () async {
              un.changeView(CurrentCardView.confirmPayment);
            },
            bgColor: Colors.black,
            color: Colors.white,
            expand: true,
            label: "I have made this payment",
          )
        ],
      );
    });
  }
}
