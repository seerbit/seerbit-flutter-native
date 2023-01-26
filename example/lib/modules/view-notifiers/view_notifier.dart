import 'package:flutter/material.dart';

class ViewsNotifier extends ChangeNotifier {
  PaymentChannel _paymentChannel = PaymentChannel.debitCard;

  get paymentChannel => _paymentChannel;

  ///Select the payment channel to be used
  ///on the checkout view
  changePaymentChannel(PaymentChannel pc) {
    _paymentChannel = pc;
    notifyListeners();
  }

  getMerchantDetails(){}
}

enum PaymentChannel { debitCard, bankAccount, ussd, transfer }
