import 'dart:developer';

import 'package:example/core/network/request_handler.dart';
import 'package:example/models/merchant_model.dart';
import 'package:example/services/channel_service.dart';
import 'package:example/services/channel_service_impl.dart';
import 'package:flutter/material.dart';

class ViewsNotifier extends ChangeNotifier {
  ViewsNotifier({this.paymentService = const PaymentServiceImpl()});

  final PaymentService paymentService;

  PaymentChannel _paymentChannel = PaymentChannel.debitCard;
  PaymentChannel get paymentChannel => _paymentChannel;

  MerchantDetailModel? _merchantDetailModel;
  MerchantDetailModel? get merchantDetailModel => _merchantDetailModel;

  ///sets the fetched [MerchantDetailModel] to the viewnotifier
  setMerchantDetail(MerchantDetailModel mdm) {
    _merchantDetailModel = mdm;
    notifyListeners();
  }

  ///Select the payment channel to be used
  ///on the checkout view
  changePaymentChannel(PaymentChannel pc) {
    _paymentChannel = pc;
    notifyListeners();
  }

  ///Check if a channel is active from the config
  ///and also confirm it is not currently selected

  isChannelActive(PaymentChannel channel) {
    return merchantDetailModel!.payload.channelOptionStatus.any((element) =>
        mapChannel(element.name!) == channel &&
        element.allowOption &&
        paymentChannel != channel);
  }

  ///Map the Payment channels to the String
  PaymentChannel mapChannel(String channel) {
    switch (channel) {
      case "Card":
        return PaymentChannel.debitCard;
      case "ACCOUNT":
        return PaymentChannel.bankAccount;
      case "TRANSFER":
        return PaymentChannel.transfer;
      case "USSD":
        return PaymentChannel.ussd;
      default:
        return PaymentChannel.debitCard;
    }
  }

  ///fetch the data for
  ///the merchant processing payments
  Future getMerchantDetails() async {
    await RequestHandler(
        request: () => paymentService.getMerchantInformation(),
        onSuccess: (_) => setMerchantDetail(
            MerchantDetailModel.fromJson(_.data as Map<String, dynamic>)),
        onError: (_) => log("message $_"),
        onNetworkError: (_) => log("message")).sendRequest();
  }
}

enum PaymentChannel { debitCard, bankAccount, ussd, transfer }
