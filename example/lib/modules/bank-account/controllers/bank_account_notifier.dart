import 'package:example/models/bank_models.dart';
import 'package:example/models/payment_payload_model.dart';
import 'package:example/modules/bank-account/controllers/bank_account_response_model.dart';
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

  chooseRequirementView(PaymentPayloadModel ppm, ViewsNotifier vn) async {
    MerchantBank mb = vn.banksModel!.data.merchantBanks
        .firstWhere((element) => element.bankName == ppm.channelType);

    if (mb.requiredFields.dateOfBirth == "YES" && ppm.dateOfBirth == null) {
      changeView(CurrentCardView.birthday);
    } else if (mb.requiredFields.bvn == "YES" && ppm.bvn == null) {
      changeView(CurrentCardView.bvn);
    } else {
      changeView(CurrentCardView.progress);
      await vn.initiatePayment();
      if (vn.errorMessage == null) {
        if ((vn.paymentResponse as BankAccountResponseModel)
                .data
                ?.payments
                ?.redirectUrl !=
            null) {
          changeView(CurrentCardView.redirect);
        } else {
          changeView(CurrentCardView.pin);
        }
      } else {
        changeView(CurrentCardView.paymentError);
      }
    }
  }
}
