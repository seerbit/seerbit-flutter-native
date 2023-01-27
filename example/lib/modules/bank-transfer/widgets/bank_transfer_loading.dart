import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/bank-transfer/controllers/bank_transfer_notifier.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BankTransferLoading extends StatelessWidget {
  const BankTransferLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    BankTransferNotifier bn = Provider.of<BankTransferNotifier>(context);
    return FutureBuilder(
        future: Future(() => vn
            .initiatePayment()
            .then((value) => bn.changeView(CurrentCardView.info))),
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const YSpace(34),
              const YSpace(8),
              CircularProgressIndicator(
                backgroundColor: Colors.grey.shade300,
                valueColor: const AlwaysStoppedAnimation(Colors.black),
              )
            ],
          );
        });
  }
}
