import 'package:example/modules/view-notifiers/view_state.dart';
import 'package:flutter/material.dart';

class DebitCardNotifier extends ChangeNotifier {
  DebitCardNotifier();

  CurrentCardView _currentCardView = CurrentCardView.info;
  CurrentCardView get currentCardView => _currentCardView;

  changeView(CurrentCardView ccv) {
    _currentCardView = ccv;
    notifyListeners();
  }
}
