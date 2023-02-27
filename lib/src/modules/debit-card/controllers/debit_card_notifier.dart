import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';
import 'package:flutter/material.dart';

class DebitCardNotifier extends ChangeNotifier {
  DebitCardNotifier();

  CurrentCardView _currentCardView = CurrentCardView.info;
  CurrentCardView get currentCardView => _currentCardView;

  bool _loading = false;
  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  changeView(CurrentCardView ccv) {
    _currentCardView = ccv;
    notifyListeners();
  }
}
