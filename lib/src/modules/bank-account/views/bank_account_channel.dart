import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/modules/bank-account/controllers/bank_account_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/bank-account/widgets/bank_account_otp.dart';
import 'package:seerbit_flutter_native/src/modules/bank-account/widgets/bank_account_progress.dart';
import 'package:seerbit_flutter_native/src/modules/bank-account/widgets/bank_account_redirect.dart';
import 'package:seerbit_flutter_native/src/modules/bank-account/widgets/bank_account_select.dart';
import 'package:seerbit_flutter_native/src/modules/bank-account/widgets/enter_bank_account.dart';
import 'package:seerbit_flutter_native/src/modules/bank-account/widgets/enter_birthday.dart';
import 'package:seerbit_flutter_native/src/modules/bank-account/widgets/enter_bvn.dart';
import 'package:seerbit_flutter_native/src/modules/debit-card/widgets/generic_error.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';

class BankAccountChannel extends StatelessWidget {
  const BankAccountChannel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BankAccountNotifier bn = Provider.of<BankAccountNotifier>(context);
    return FadeInUp(
      key: Key(bn.currentCardView.toString()),
      duration: const Duration(milliseconds: 280),
      child: Builder(builder: (context) {
        switch (bn.currentCardView) {
          case CurrentCardView.select:
            return const SelectBankAccount();
          case CurrentCardView.info:
            return const EnterBankAccount();
          case CurrentCardView.pin:
            return BankAccountOTP();
          case CurrentCardView.bvn:
            return const EnterBVN();
          case CurrentCardView.birthday:
            return const EnterBirthday();
          case CurrentCardView.redirect:
            return const BankAccounRedirect();
          case CurrentCardView.paymentError:
            return const GenericError();
          case CurrentCardView.progress:
            return const BankAccountProgress();
          default:
            return Container();
        }
      }),
    );
  }
}
