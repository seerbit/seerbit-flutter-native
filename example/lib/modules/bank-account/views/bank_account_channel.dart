import 'package:animate_do/animate_do.dart';
import 'package:example/modules/bank-account/controllers/bank_account_notifier.dart';
import 'package:example/modules/bank-account/widgets/bank_account_redirect.dart';
import 'package:example/modules/bank-account/widgets/bank_account_select.dart';
import 'package:example/modules/bank-account/widgets/enter_bank_account.dart';
import 'package:example/modules/bank-account/widgets/enter_birthday.dart';
import 'package:example/modules/bank-account/widgets/enter_bvn.dart';
import 'package:example/modules/debit-card/widgets/display_test_cards.dart';
import 'package:example/modules/debit-card/widgets/widgets.dart';
import 'package:example/modules/view-notifiers/view_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BankAccountChannel extends StatelessWidget {
  const BankAccountChannel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BankAccountNotifier bn = Provider.of<BankAccountNotifier>(context);
    return FadeInUp(
      key: Key(bn.currentCardView.toString()),
      child: Builder(builder: (context) {
        switch (bn.currentCardView) {
          case CurrentCardView.select:
            return const SelectBankAccount();
          case CurrentCardView.info:
            return const EnterBankAccount();
          case CurrentCardView.otp:
            return const AuthorizeOTP();
          case CurrentCardView.bvn:
            return const EnterBVN();
          case CurrentCardView.birthday:
            return const EnterBirthday();
          case CurrentCardView.redirect:
            return const BankAccounRedirect();
          case CurrentCardView.testCards:
            return const DisplayTestCards();
          default:
            return Container();
        }
      }),
    );
  }
}
