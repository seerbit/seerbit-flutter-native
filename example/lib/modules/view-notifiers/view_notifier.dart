import 'dart:developer';

import 'package:example/core/network/request_handler.dart';
import 'package:example/models/models.dart';
import 'package:example/modules/bank-transfer/controllers/bank_transfer_response_model.dart';
import 'package:example/modules/ussd/controllers/ussd_response_model.dart';
import 'package:example/services/channel_service.dart';
import 'package:example/services/channel_service_impl.dart';
import 'package:flutter/material.dart';

import 'helpers.dart';

class ViewsNotifier extends ChangeNotifier {
  ViewsNotifier({this.paymentService = const PaymentServiceImpl()});

  final PaymentService paymentService;

  PaymentChannel _paymentChannel = PaymentChannel.debitCard;
  PaymentChannel get paymentChannel => _paymentChannel;

  PaymentResponseModel? _paymentResponse;
  PaymentResponseModel? get paymentResponse => _paymentResponse;

  MerchantDetailModel? _merchantDetailModel;
  MerchantDetailModel? get merchantDetailModel => _merchantDetailModel;

  BanksModel? _banksModel;
  BanksModel? get banksModel => _banksModel;

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
    notifyListeners();
  }

  ///Set the fetched Available Banks to the viewnotifier
  setBanks(BanksModel bm) {
    _banksModel = bm;
    notifyListeners();
  }

  ///Check if a channel is active from the config
  ///and also confirm it is not currently selected

  isChannelActive(PaymentChannel channel) {
    return merchantDetailModel!.payload.channelOptionStatus.any((element) =>
        Helper().mapChannel(element.name!) == channel &&
        element.allowOption &&
        paymentChannel != channel);
  }

  ///Map the payment response
  PaymentResponseModel mapPaymentResponse(Map data) {
    switch (_paymentChannel) {
      case PaymentChannel.transfer:
        return TransferResponseModel.fromJson(data as Map<String, dynamic>);

      default:
        return UssdResponseModel.fromJson(data as Map<String, dynamic>);
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
        "paymentType":
            Helper().reverseMapChannel(_paymentChannel).toUpperCase(),
        "channelType":
            Helper().reverseMapChannel(_paymentChannel).toLowerCase(),
        "deviceType": "Desktop",
        "sourceIP": "102.88.63.64",
        "source": "",
        "fee": "1.50",
        "retry": true,
        "amountControl": "FIXEDAMOUNT",
        "walletDaysActive": "1",
        "bankCode": "044"
      })),
      onSuccess: (_) => {
        setPaymentResponse(mapPaymentResponse(_.data)),
        log("message $_"),
      },
      onError: (_) => log("message $_."),
      onNetworkError: (_) => log("message $_"),
    ).sendRequest();
  }

  ///check the status of a transaction
  Future queryTransaction() async {
    RequestHandler(
        request: () =>
            paymentService.queryTransaction(payRef: "SBT-T54367073117"),
        onSuccess: (_) => log("message $_."),
        onError: (_) => log("message $_."),
        onNetworkError: (_) => log("message $_.")).sendRequest();
  }

  ///Get the list of banks available for checkout
  Future getBanks() async {
    RequestHandler(
      request: () => paymentService.getBanks(),
      onSuccess: (_) =>
          setBanks(BanksModel.fromJson(_.data as Map<String, dynamic>)),
      onError: (_) => log("message $_."),
      onNetworkError: (_) => log("message $_."),
    ).sendRequest();
  }
}

enum PaymentChannel { debitCard, bankAccount, ussd, transfer }
