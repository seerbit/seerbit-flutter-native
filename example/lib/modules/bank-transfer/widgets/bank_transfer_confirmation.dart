import 'package:example/core/navigator.dart';
import 'package:example/models/models.dart';
import 'package:example/modules/-core-global/global_components.dart';
import 'package:example/modules/bank-transfer/controllers/bank_transfer_notifier.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
import 'package:example/modules/view-notifiers/view_state.dart';
import 'package:example/modules/widgets/amount_to_pay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BankTransferConfirmation extends StatelessWidget {
  const BankTransferConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    BankTransferNotifier bn = Provider.of<BankTransferNotifier>(context);
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
                Navigate.pop();
                break;
              default:
                bn.changeView(CurrentCardView.error);
            }
          }
        }),
        builder: (context, snapshot) {
          MerchantDetailModel mdm = vn.merchantDetailModel!;
          return Column(
            children: [
              const YSpace(25),
              AmountToPay(fee: mdm.payload.cardFee.mc!),
              const YSpace(32),
              const CustomText("Hold on tight while we confirm this payment",
                  size: 12),
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
