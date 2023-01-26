import 'package:flutter/material.dart';

class DebitCardNotifier extends ChangeNotifier {
  CurrentCardView _currentCardView = CurrentCardView.info;
  CurrentCardView get currentCardView => _currentCardView;

  changeView(CurrentCardView ccv) {
    _currentCardView = ccv;
    notifyListeners();
  }
}

enum CurrentCardView { info, pin, loading, otp, redirect }
