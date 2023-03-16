import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/modules/bank-transfer/controllers/bank_transfer_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/bank-transfer/widgets/bank_transfer_confirmation.dart';
import 'package:seerbit_flutter_native/src/modules/bank-transfer/widgets/bank_transfer_info.dart';
import 'package:seerbit_flutter_native/src/modules/bank-transfer/widgets/bank_transfer_loading.dart';
import 'package:seerbit_flutter_native/src/modules/debit-card/widgets/generic_error.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';

class BankTransferChannel extends StatelessWidget {
  const BankTransferChannel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // UssdNotifier un = Provider.of<UssdNotifier>(context);
    BankTransferNotifier bn = Provider.of<BankTransferNotifier>(context);
    return FadeInUp(
      key: Key(bn.currentCardView.toString()),
      duration: const Duration(milliseconds: 280),
      child: Builder(builder: (context) {
        switch (bn.currentCardView) {
          case CurrentCardView.loading:
            return const BankTransferLoading();
          case CurrentCardView.info:
            return const BankTransferInfo();
          case CurrentCardView.progress:
            return const BankTransferLoading();
          case CurrentCardView.confirmPayment:
            return const BankTransferConfirmation();
          case CurrentCardView.error:
            return const GenericError();
          default:
            return Container();
        }
      }),
    );
  }
}
