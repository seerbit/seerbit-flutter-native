import 'package:flutter/material.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';


class BankTransferNotifier extends ChangeNotifier {
  BankTransferNotifier();

  CurrentCardView _currentCardView = CurrentCardView.loading;
  CurrentCardView get currentCardView => _currentCardView;

  changeView(CurrentCardView ccv) {
    _currentCardView = ccv;
    notifyListeners();
  }
}
