import 'package:example/modules/view-notifiers/view_state.dart';
import 'package:flutter/material.dart';

class BankTransferNotifier extends ChangeNotifier {
  BankTransferNotifier();

  CurrentCardView _currentCardView = CurrentCardView.loading;
  CurrentCardView get currentCardView => _currentCardView;

  changeView(CurrentCardView ccv) {
    _currentCardView = ccv;
    notifyListeners();
  }
}
