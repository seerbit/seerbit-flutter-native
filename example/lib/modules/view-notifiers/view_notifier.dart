import 'dart:developer';

import 'package:example/core/network/request_handler.dart';
import 'package:example/models/models.dart';
import 'package:example/models/payment_status_model.dart';
import 'package:example/modules/bank-account/controllers/bank_account_response_model.dart';
import 'package:example/modules/bank-transfer/controllers/bank_transfer_response_model.dart';
import 'package:example/modules/debit-card/controllers/debit_card_model.dart';
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

  PaymentPayloadModel _paymentPayload = PaymentPayloadModel.empty();
  PaymentPayloadModel? get paymentPayload => _paymentPayload;

  PaymentStatusModel? _paymentStatus;
  PaymentStatusModel? get paymentStatus => _paymentStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  reset() {
    _paymentResponse = null;
    _paymentStatus = null;
    _errorMessage = null;
  }

  ///set the error message
  setErrorMessage(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  ///Update the payment paylod
  setPaymentPayload(PaymentPayloadModel ppm) {
    _paymentPayload = ppm;
    notifyListeners();
  }

  ///Update the payment status
  _setPaymentStatus(PaymentStatusModel psm) {
    _paymentStatus = psm;
    notifyListeners();
  }

  //Add Additional Params to the payload
  PaymentPayloadModel _getUpdatedPayload() {
    // return ;
    return paymentPayload!.copyWith(
      // paymentType: Helper().reverseMapChannel(_paymentChannel).toUpperCase(),
      // channelType: Helper().reverseMapChannel(_paymentChannel).toLowerCase(),
      // ddeviceType: Platform.isAndroid ? "Android" : "iOS",
      // publicKey: "SBTESTPUBK_t4G16GCA1O51AV0Va3PPretaisXubSw1",
      currency: "NGN",
      country: "NG",
    );
  }

  ///sets the fetched [MerchantDetailModel] to the viewnotifier
  setMerchantDetail(MerchantDetailModel mdm) {
    _merchantDetailModel = mdm;
    notifyListeners();
  }

  ///Select the payment channel to be used
  ///on the checkout view
  changePaymentChannel(PaymentChannel pc) {
    reset();
    _paymentChannel = pc;

    notifyListeners();
  }

  ///Set the fetched [PaymentResponseModel] to the the viewnotifier
  _setPaymentResponse(PaymentResponseModel prm) {
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
      case PaymentChannel.debitCard:
        return DebitCardResponseModel.fromJson(data as Map<String, dynamic>);
      case PaymentChannel.bankAccount:
        return BankAccountResponseModel.fromJson(data as Map<String, dynamic>);
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
    setErrorMessage(null);
    await RequestHandler(
      request: () =>
          paymentService.initiatePayment(payloadModel: _getUpdatedPayload()),
      onSuccess: (_) => {
        if (!["S20", "00"].contains(_.data['data']['code']))
          setErrorMessage(_.data['data']['message']),
        _setPaymentResponse(mapPaymentResponse(_.data)),
      },
      onError: (_) => {log("onError $_."), setErrorMessage(_.data['message'])},
      onNetworkError: (_) => log("onNetworkError $_"),
    ).sendRequest();
  }

  ///check the status of a transaction
  Future queryTransaction() async {
    RequestHandler(
        request: () => paymentService.queryTransaction(
            payRef: _paymentPayload.paymentReference!),
        onSuccess: (_) => _setPaymentStatus(
            PaymentStatusModel.fromJson(_.data as Map<String, dynamic>)),
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

enum PaymentChannel {
  debitCard,
  bankAccount,
  ussd,
  transfer,
  changePaymentMethod,
  success
}
