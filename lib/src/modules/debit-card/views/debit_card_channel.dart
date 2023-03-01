import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/modules/debit-card/controllers/debit_card_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/debit-card/widgets/debit_card_progress.dart';
import 'package:seerbit_flutter_native/src/modules/debit-card/widgets/display_test_cards.dart';
import 'package:seerbit_flutter_native/src/modules/debit-card/widgets/generic_error.dart';
import 'package:seerbit_flutter_native/src/modules/debit-card/widgets/widgets.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';

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
            return EnterDebitCardInfo();
          case CurrentCardView.pin:
            return const InputPIN();
          case CurrentCardView.otp:
            return  AuthorizeOTP();
          case CurrentCardView.redirect:
            return const RedirectToBank();
          case CurrentCardView.testCards:
            return const DisplayTestCards();
          case CurrentCardView.progress:
            return const DebitCardProgress();
          case CurrentCardView.paymentError:
            return const GenericError();
          default:
            return Container();
        }
      }),
    );
  }
}
