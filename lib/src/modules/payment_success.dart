import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';

class PaymentSuccess extends StatelessWidget {
  const PaymentSuccess(
      {Key? key,
      this.amount,
      required this.logo,
      required this.email,
      required this.name,
      required this.onPop,
      required this.currency})
      : super(key: key);
  final String? amount;
  final String? logo;
  final String email;
  final String name, currency;

  final Function onPop;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        width: double.infinity,
        child: Column(
          children: [
            const YSpace(22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                    logo ??
                        "https://res.cloudinary.com/afroify/image/upload/v1685002453/logo_p91yzv.png",
                    height: 50.h,
                    width: 50.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomText(name, size: 12, weight: FontWeight.bold),
                    const YSpace(6),
                    CustomText(email, size: 12)
                  ],
                )
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.network(
                    "https://assets8.lottiefiles.com/packages/lf20_vhhoyvvc.json",
                    height: 100,
                  ),
                  const YSpace(24),
                  CustomText("$currency $amount",
                      size: 24, weight: FontWeight.bold),
                  const YSpace(25),
                  const CustomText("Your transaction was successful", size: 20),
                  const YSpace(25),
                ],
              ),
            ),
            CustomFlatButton(
              onTap: () {
                onPop.call();
                // Navigate(context).pop();
              },
              label: "Proceed",
              bgColor: Colors.black,
              color: Colors.white,
            ),
            const Spacer(),
            const SecuredByMarker(),
            const YSpace(48)
          ],
        ),
      ),
    );
  }
}
