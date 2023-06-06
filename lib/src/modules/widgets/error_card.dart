import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/models/payment_status_model.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';

class ErrorCard extends StatelessWidget {
  const ErrorCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    return Builder(builder: (context) {
      PaymentStatusModel psm = vn.paymentStatus!;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const YSpace(34),
          Image.asset('packages/seerbit_flutter_native/assets/caution.png',
              height: 100.h, width: 100.h),
          const YSpace(12),
          SizedBox(
            width: 250.w,
            child: CustomText(psm.data.message.toString(),
                align: TextAlign.center, height: 1.7, size: 16),
          ),
          const YSpace(8),
        ],
      );
    });
  }
}
