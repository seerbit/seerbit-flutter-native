import 'dart:developer';

import 'package:example/core/network/request_handler.dart';
import 'package:example/models/merchant_model.dart';
import 'package:example/models/payment_payload_model.dart';
import 'package:example/models/payment_response_model.dart';
import 'package:example/modules/ussd/controllers/ussd_response_model.dart';
import 'package:example/services/channel_service.dart';
import 'package:example/services/channel_service_impl.dart';
import 'package:flutter/material.dart';

class ViewsNotifier extends ChangeNotifier {
  ViewsNotifier({this.paymentService = const PaymentServiceImpl()});

  final PaymentService paymentService;

  PaymentChannel _paymentChannel = PaymentChannel.debitCard;
  PaymentChannel get paymentChannel => _paymentChannel;

  PaymentResponseModel? _paymentResponse;
  PaymentResponseModel? get paymentResponse => _paymentResponse;

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

  ///Set the fetched [PaymentResponseModel] to the the viewnotifier
  setPaymentResponse(PaymentResponseModel prm) {
    _paymentResponse = prm;
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

  ///Initiate a payment
  Future initiatePayment() async {
    await RequestHandler(
      request: () => paymentService.initiatePayment(
          payloadModel: PaymentPayloadModel.fromJson({
        "fullName": "Amos Oruaroghene",
        "mobileNumber": "404",
        "email": "inspiron.amos@gmail.com",
        "publicKey": "SBTESTPUBK_t4G16GCA1O51AV0Va3PPretaisXubSw1",
        "amount": "101.50",
        "currency": "NGN",
        "country": "NG",
        "paymentReference": "SBT-T54367073117",
        "productId": "",
        "productDescription": "",
        "redirectUrl": "http://localhost:3002/#/",
        "paymentType": "USSD",
        "channelType": "ussd",
        "ddeviceType": "Desktop",
        "sourceIP": "102.88.63.64",
        "source": "",
        "fee": "1.50",
        "retry": true,
        "bankCode": "044"
      })),
      onSuccess: (_) => {
        setPaymentResponse(
            UssdResponseModel.fromJson(_.data as Map<String, dynamic>)),
        log("message")
      },
      onError: (_) => log("message $_"),
      onNetworkError: (_) => log("message $_"),
    ).sendRequest();
  }
}

enum PaymentChannel { debitCard, bankAccount, ussd, transfer }
