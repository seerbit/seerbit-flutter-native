import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/core/navigator.dart';
import 'package:seerbit_flutter_native/src/models/models.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/ussd/controllers/ussd_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';
import 'package:seerbit_flutter_native/src/modules/widgets/amount_to_pay.dart';

class UssdConfirmPayment extends StatelessWidget {
  const UssdConfirmPayment({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    UssdNotifier un = Provider.of<UssdNotifier>(context);

    return StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 5), (_) {
          vn.queryTransaction();
          if (vn.paymentStatus != null) {
            String code = vn.paymentStatus!.data.code!;
            vn.setErrorMessage(vn.paymentStatus!.data.message);
            switch (code) {
              case "S20":
                break;
              case "00":
                Navigate(context).pop();
                break;
              default:
                un.changeView(CurrentCardView.error);
            }
          }
        }),
        builder: (context, snapshot) {
          MerchantDetailModel mdm = vn.merchantDetailModel!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const YSpace(25),
              AmountToPay(fee: mdm.payload.cardFee.mc!),
              const YSpace(32),
              const CustomText("Hold on tight while we confirm this payment",
                  size: 15),
              const YSpace(25),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  color: Colors.grey,
                  backgroundColor: Colors.grey.shade300,
                  minHeight: 10,
                ),
              )
            ],
          );
        });
  }
}
