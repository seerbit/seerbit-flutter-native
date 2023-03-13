import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:seerbit_flutter_native/src/models/bank_models.dart';
import 'package:seerbit_flutter_native/src/models/payment_payload_model.dart';
import 'package:seerbit_flutter_native/src/modules/bank-account/controllers/bank_account_response_model.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';

class BankAccountNotifier extends ChangeNotifier {
  BankAccountNotifier();

  CurrentCardView _currentCardView = CurrentCardView.select;
  CurrentCardView get currentCardView => _currentCardView;
  bool _loading = false;
  bool get loading => _loading;

  changeView(CurrentCardView ccv) {
    _currentCardView = ccv;
    log(ccv.toString());

    notifyListeners();
  }

  setLoading(bool value) {
    _loading = value;
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
        BankAccountResponseModel barm =
            vn.paymentResponse as BankAccountResponseModel;

        if (barm.data!.code == "S20") {
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
      } else {
        changeView(CurrentCardView.paymentError);
      }
    }
  }
}
