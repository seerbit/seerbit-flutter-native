import 'package:example/views/widgets/debit_card/enter_debit_card_info.dart';
import 'package:flutter/material.dart';

class DebitCardNotifier extends ChangeNotifier {
  Widget _viewToShow = const EnterDebitCardInfo();
  get viewToShow => _viewToShow;

  changeView(Widget vts) {
    _viewToShow = vts;
  }
}
