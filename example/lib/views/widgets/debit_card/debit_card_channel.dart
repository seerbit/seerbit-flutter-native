import 'package:animate_do/animate_do.dart';
import 'package:example/views/view-notifiers/debit_card_notifier.dart';
import 'package:example/views/widgets/debit_card/authorize_otp.dart';
import 'package:example/views/widgets/debit_card/enter_debit_card_info.dart';
import 'package:example/views/widgets/debit_card/input_pin.dart';
import 'package:example/views/widgets/debit_card/redirect_to_bank.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DebitCardChannel extends StatelessWidget {
  const DebitCardChannel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DebitCardNotifier dcn = Provider.of<DebitCardNotifier>(context);
    return FadeInUp(
      key: Key(dcn.currentCardView.toString()),
      child: Builder(builder: (context) {
        switch (dcn.currentCardView) {
          case CurrentCardView.info:
            return const EnterDebitCardInfo();
          case CurrentCardView.pin:
            return const InputPIN();
          case CurrentCardView.otp:
            return const AuthorizeOTP();
          case CurrentCardView.redirect:
            return const RedirectToBank();
          default:
            return Container();
        }
      }),
    );
  }
}
