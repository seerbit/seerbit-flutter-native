import 'package:example/modules/view-notifiers/view_state.dart';
import 'package:flutter/material.dart';

class BankAccountNotifier extends ChangeNotifier {
  BankAccountNotifier();

  CurrentCardView _currentCardView = CurrentCardView.select;
  CurrentCardView get currentCardView => _currentCardView;

  changeView(CurrentCardView ccv) {
    _currentCardView = ccv;
    notifyListeners();
  }
}
