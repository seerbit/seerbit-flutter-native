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

enum CurrentCardView { select, info, progress, loading }
