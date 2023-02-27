import 'package:animate_do/animate_do.dart';
import 'package:seerbit_flutter_native/src/modules/debit-card/widgets/generic_error.dart';
import 'package:seerbit_flutter_native/src/modules/ussd/controllers/ussd_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/ussd/widgets/ussd_confirm_payment.dart';
import 'package:seerbit_flutter_native/src/modules/ussd/widgets/ussd_info.dart';
import 'package:seerbit_flutter_native/src/modules/ussd/widgets/ussd_progress.dart';
import 'package:seerbit_flutter_native/src/modules/ussd/widgets/ussd_select_bank.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';
import 'package:seerbit_flutter_native/src/modules/widgets/error_card.dart';
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
          case CurrentCardView.error:
            return const ErrorCard();
          case CurrentCardView.initializeError:
            return const GenericError();
          default:
            return Container();
        }
      }),
    );
  }
}
