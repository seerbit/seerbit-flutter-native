import 'package:example/models/bank_models.dart';
import 'package:example/models/payment_payload_model.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
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

  chooseRequirementView(PaymentPayloadModel ppm, ViewsNotifier vn) {
    MerchantBank mb = vn.banksModel!.data.merchantBanks
        .firstWhere((element) => element.bankName == ppm.channelType);

    if (mb.requiredFields.dateOfBirth == "Yes" && ppm.dateOfBirth == null) {
      changeView(CurrentCardView.birthday);
    } else if (mb.requiredFields.bvn == "Yes" && ppm.bvn == null) {
      changeView(CurrentCardView.bvn);
    } else {
      changeView(CurrentCardView.progress);
      vn.initiatePayment();
      if (vn.errorMessage == null) {
        changeView(CurrentCardView.info);
      } else {
        changeView(CurrentCardView.paymentError);
      }
    }
  }
}
