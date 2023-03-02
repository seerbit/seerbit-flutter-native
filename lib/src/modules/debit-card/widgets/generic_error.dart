import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';

class GenericError extends StatelessWidget {
  const GenericError({super.key});

  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    return Visibility(
      visible: vn.errorMessage != null,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: GestureDetector(
          onTap: () => {
            vn.setErrorMessage(null),
            vn.changePaymentChannel(PaymentChannel.changePaymentMethod)
          },
          child: FadeInUp(
            key: Key(vn.errorMessage.toString()),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              // height: 35,
              decoration: BoxDecoration(
                  color: const Color(0xFFFFD6D6),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFFF6262))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText('Transaction Failed',
                          size: 12,
                          color: Color(0xFFCC212D),
                          weight: FontWeight.bold),
                      const YSpace(8),
                      SizedBox(
                        width: 300,
                        child: CustomText(vn.errorMessage.toString(),
                            height: 1.5,
                            size: 12,
                            color: const Color(0xFFCC212D)),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      vn.setErrorMessage(null);
                      vn.changePaymentChannel(
                          PaymentChannel.changePaymentMethod);
                    },
                    child: const Icon(Icons.close, size: 14),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
