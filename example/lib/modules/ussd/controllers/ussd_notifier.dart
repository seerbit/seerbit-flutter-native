import 'package:flutter/material.dart';

class UssdNotifier extends ChangeNotifier {
  UssdNotifier();

  CurrentCardView _currentCardView = CurrentCardView.select;
  CurrentCardView get currentCardView => _currentCardView;

  changeView(CurrentCardView ccv) {
    _currentCardView = ccv;
    notifyListeners();
  }
}

enum CurrentCardView { select, showUssd, progress }
