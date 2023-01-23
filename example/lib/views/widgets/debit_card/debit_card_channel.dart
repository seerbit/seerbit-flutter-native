import 'package:example/views/view-notifiers/debit_card_notifier.dart';
import 'package:flutter/material.dart';

class DebitCardChannel extends StatelessWidget {
  const DebitCardChannel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DebitCardNotifier dcn = DebitCardNotifier();
    return dcn.viewToShow;
  }
}
