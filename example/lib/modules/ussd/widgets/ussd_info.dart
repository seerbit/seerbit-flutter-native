import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/ussd/controllers/ussd_response_model.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const YSpace(34),
        const CustomText("Dial the code below to complete this payment",
            size: 13),
        const YSpace(8),
        Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            alignment: Alignment.center,
            height: 50.h,
            color: Colors.grey.shade300,
            child: CustomText(
                (vn.paymentResponse as UssdResponseModel)
                    .data
                    .payments
                    .ussdDailCode,
                size: 25,
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
          onTap: () {},
          bgColor: Colors.black,
          color: Colors.white,
          expand: true,
          label: "I have made this payment",
        )
      ],
    );
  }
}
