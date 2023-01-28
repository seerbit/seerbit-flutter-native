import 'package:animate_do/animate_do.dart';
import 'package:example/modules/ussd/controllers/ussd_notifier.dart';
import 'package:example/modules/ussd/widgets/ussd_confirm_payment.dart';
import 'package:example/modules/ussd/widgets/ussd_info.dart';
import 'package:example/modules/ussd/widgets/ussd_progress.dart';
import 'package:example/modules/ussd/widgets/ussd_select_bank.dart';
import 'package:example/modules/view-notifiers/view_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UssdChannel extends StatelessWidget {
  const UssdChannel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UssdNotifier un = Provider.of<UssdNotifier>(context);
    return FadeIn(
      key: Key(un.currentCardView.toString()),
      child: Builder(builder: (context) {
        switch (un.currentCardView) {
          case CurrentCardView.select:
            return const UssdSelectBank();
          case CurrentCardView.info:
            return const UssdInfo();
          case CurrentCardView.progress:
            return const UssdProgress();
          case CurrentCardView.confirmPayment:
            return const UssdConfirmPayment();
          default:
            return Container();
        }
      }),
    );
  }
}
