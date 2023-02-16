import 'dart:math' as math;

import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/bank-transfer/controllers/bank_transfer_notifier.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
import 'package:example/modules/view-notifiers/view_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BankTransferLoading extends StatefulWidget {
  const BankTransferLoading({
    Key? key,
  }) : super(key: key);

  @override
  State<BankTransferLoading> createState() => _BankTransferLoadingState();
}

class _BankTransferLoadingState extends State<BankTransferLoading> {
  late Future myFuture;
  @override
  void initState() {
    myFuture = Future(() {
      ViewsNotifier vn = Provider.of<ViewsNotifier>(context, listen: false);
      BankTransferNotifier bn =
          Provider.of<BankTransferNotifier>(context, listen: false);

      vn.setPaymentPayload(vn.paymentPayload!.copyWith(
          paymentType: "TRANSFER",
          channelType: 'Transfer',
          paymentReference: "ST-12311231${math.Random().nextInt(29091020)}"));

      vn.initiatePayment().then((value) {
        if (vn.errorMessage == null) {
          bn.changeView(CurrentCardView.info);
        } else {
          bn.changeView(CurrentCardView.error);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: myFuture,
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
