import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/models/models.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/bank-transfer/controllers/bank_transfer_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';
import 'package:seerbit_flutter_native/src/modules/widgets/amount_to_pay.dart';

class BankTransferConfirmation extends StatelessWidget {
  const BankTransferConfirmation({super.key});

  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    BankTransferNotifier bn = Provider.of<BankTransferNotifier>(context);
    return StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 5), (_) {
          vn.confirmTransaction(context,
              onError: () => bn.changeView(CurrentCardView.error));
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
