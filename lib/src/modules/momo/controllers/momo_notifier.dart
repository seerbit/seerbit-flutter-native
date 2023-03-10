import 'package:flutter/material.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';

class MomoNotifier extends ChangeNotifier {
  MomoNotifier();

  CurrentCardView _currentCardView = CurrentCardView.info;
  CurrentCardView get currentCardView => _currentCardView;

  changeView(CurrentCardView ccv) {
    _currentCardView = ccv;
    notifyListeners();
  }
}
