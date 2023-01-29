import 'package:example/models/models.dart';
import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/ussd/controllers/ussd_notifier.dart';
import 'package:example/modules/ussd/controllers/ussd_response_model.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
import 'package:example/modules/view-notifiers/view_state.dart';
import 'package:example/modules/widgets/amount_to_pay.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

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
          const YSpace(8),
          Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              alignment: Alignment.center,
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey.shade300,
              ),
              child: CustomText(
                  (vn.paymentResponse as UssdResponseModel)
                      .data
                      .payments
                      .ussdDailCode,
                  size: 35,
                  weight: FontWeight.w900)),
          TextButton(
            child: const CustomText("Click to copy code", size: 14),
            onPressed: () =>
                Clipboard.setData(const ClipboardData(text: "email")).then((_) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("USSD copied")));
            }),
          ),
          const YSpace(8),
          CustomFlatButton(
            onTap: () async {
              vn.queryTransaction();

              un.changeView(CurrentCardView.confirmPayment);
              await Future.delayed(const Duration(seconds: 5));
              un.changeView(CurrentCardView.error);
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
