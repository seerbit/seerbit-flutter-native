import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:seerbit_flutter_native/src/core/navigator.dart';
import 'package:seerbit_flutter_native/src/core/network/request_handler.dart';
import 'package:seerbit_flutter_native/src/models/models.dart';
import 'package:seerbit_flutter_native/src/models/momo_network_model.dart';
import 'package:seerbit_flutter_native/src/models/payment_status_model.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/custom_over_lay.dart';
import 'package:seerbit_flutter_native/src/modules/bank-account/controllers/bank_account_response_model.dart';
import 'package:seerbit_flutter_native/src/modules/bank-transfer/controllers/bank_transfer_response_model.dart';
import 'package:seerbit_flutter_native/src/modules/debit-card/controllers/debit_card_model.dart';
import 'package:seerbit_flutter_native/src/modules/momo/controllers/momo_response_model.dart';
import 'package:seerbit_flutter_native/src/modules/payment_success.dart';
import 'package:seerbit_flutter_native/src/modules/ussd/controllers/ussd_response_model.dart';
import 'package:seerbit_flutter_native/src/services/channel_service.dart';
import 'package:seerbit_flutter_native/src/services/channel_service_impl.dart';

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

  List<MomoNetworkModel>? _momoNetworks;
  List<MomoNetworkModel>? get momoNetworks => _momoNetworks;

  PaymentPayloadModel _paymentPayload = PaymentPayloadModel.empty();
  PaymentPayloadModel? get paymentPayload => _paymentPayload;

  PaymentStatusModel? _paymentStatus;
  PaymentStatusModel? get paymentStatus => _paymentStatus;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _message;
  String? get message => _message;

  double? _fees;
  double? get fees => _fees;

  String? _publicKey;
  String? get publicKey => _publicKey;

  Function? onClose;
  Function? onFailure;
  Function? onSuccess;

  bool get paymentSuccess =>
      (_paymentStatus?.data.code == "00") || secondaryPaymentSuccess;
  bool _secondaryPaymentSuccess = false;
  bool get secondaryPaymentSuccess => _secondaryPaymentSuccess;

  bool get isReleaseMode => _isReleaseMode;
  bool _isReleaseMode = false;

  String _isCardLocal = "LOCAL";
  String get isCardLocal => _isCardLocal;

  setIsReleaseMode(bool mode) {
    _isReleaseMode = mode;
    _paymentPayload = _paymentPayload.copyWith(isLive: _isReleaseMode);
    notifyListeners();
  }

  setSecondaryPaymentSuccess(bool status) {
    _secondaryPaymentSuccess = status;
    // notifyListeners();
  }

  setConpletionFunctions({
    Function? onCloseFunc,
    Function? onSuccessFunc,
    Function? onFailureFunc,
  }) {
    onClose = onCloseFunc;
    onSuccess = onSuccessFunc;
    onFailure = onFailureFunc;
  }

  reset() {
    _paymentResponse = null;
    _paymentStatus = null;
    _errorMessage = null;
    _secondaryPaymentSuccess = false;
  }

  ///set the error message
  setErrorMessage(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  ///set the error message
  setMessage(String? message) {
    _message = message;
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
    return paymentPayload!.copyWith(
      channelType: Helper().reverseMapChannel(_paymentChannel).toLowerCase(),
      ddeviceType: Platform.isAndroid ? "Android" : "iOS",
      fee: calculateFees().toString(),
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
  _setPaymentResponse(PaymentResponseModel? prm) {
    _paymentResponse = prm;
    notifyListeners();
  }

  ///Set the fetched Available Banks to the viewnotifier
  setBanks(BanksModel bm) {
    _banksModel = bm;
    notifyListeners();
  }

  /// Set the fetched Momo networks to the viewnotifier
  setMomoNetworks(List<MomoNetworkModel> mnm) {
    _momoNetworks = mnm;
    notifyListeners();
  }

  ///Set the public key of the merchant initiating the transaction
  setPublicKey(String publicKey) {
    _publicKey = publicKey;
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
      case PaymentChannel.momo:
        return MomoResponseModel.fromJson(data as Map<String, dynamic>);
      default:
        return UssdResponseModel.fromJson(data as Map<String, dynamic>);
    }
  }

  ///Get the BIN of the card
  Future getCardBin(String cardNumber) async {
    await RequestHandler(
        request: () => paymentService.getCardBin(cardNumber: cardNumber),
        onSuccess: (_) {
          if (_merchantDetailModel!.payload.country.name ==
              _.data['country'].toString().split(" ").first) {
            _isCardLocal = "LOCAL";
          } else {
            _isCardLocal = "INTERNATIONAL";
          }
          setPaymentPayload(
              paymentPayload!.copyWith(isCardInternational: _isCardLocal));
        },
        onError: (_) => log(_.data),
        onNetworkError: (_) => log(_.data)).sendRequest();
  }

  ///fetch the data for
  ///the merchant processing payments
  Future getMerchantDetails() async {
    await RequestHandler(
        removeFocus: false,
        request: () =>
            paymentService.getMerchantInformation(publicKey: _publicKey!),
        onSuccess: (_) => setMerchantDetail(
            MerchantDetailModel.fromJson(_.data as Map<String, dynamic>)),
        onError: (_) => log("message $_"),
        onNetworkError: (_) => log("message")).sendRequest();
  }

  ///Initiate a payment
  Future initiatePayment() async {
    _setPaymentResponse(null);
    setErrorMessage(null);
    if (paymentPayload!.paymentType.toString().toLowerCase() == "card") {
      await getCardBin(paymentPayload!.cardNumber!.substring(0, 6));
    }
    await RequestHandler(
      request: () =>
          paymentService.initiatePayment(payloadModel: _getUpdatedPayload()),
      onSuccess: (_) => {
        if (!["S20", "00", "INP"].contains(_.data['data']['code']))
          setErrorMessage(_.data['data']['message']),
        _setPaymentResponse(mapPaymentResponse(_.data)),
        setMessage(_.data['data']['message']),
      },
      onError: (_) => {
        log("onError $_."),
        setErrorMessage(_.data['message']),
      },
      onNetworkError: (_) => log("onNetworkError $_"),
    ).sendRequest();
  }

  ///check the status of a transaction
  Future queryTransaction() async {
    await RequestHandler(
        request: () => paymentService.queryTransaction(
            payRef: _paymentPayload.paymentReference!),
        onSuccess: (_) => _setPaymentStatus(
            PaymentStatusModel.fromJson(_.data as Map<String, dynamic>)),
        onError: (_) => log("message $_."),
        onNetworkError: (_) => log("message $_.")).sendRequest();
  }

  ///confirm that a transaction was successful
  Future confirmTransaction(BuildContext context,
      {required Function onError, bool overlay = false}) async {
    await queryTransaction().then((value) {
      if (paymentStatus != null) {
        String code = paymentStatus!.data.code!;
        setErrorMessage(paymentStatus!.data.message);
        showSuccess(context, code, onError: onError, overlay: overlay);
      }
    });
  }

  showSuccess(BuildContext context, String code,
      {Function? onError, bool overlay = false, int popCount = 1}) {
    switch (code) {
      case "S20":
        log("Querying transaction status..");
        break;
      case "00":
        onSuccess?.call();

        if (overlay) {
          CustomOverlays().showPopup(
              PaymentSuccess(
                onPop: () => Navigate(context).pop(number: popCount),
                amount: paymentPayload!.amount!,
                logo: merchantDetailModel!.payload.logo!,
                name:
                    "${paymentPayload!.firstName} ${paymentPayload!.lastName}",
                email: paymentPayload!.email!,
              ),
              context: context);
        } else {
          setSecondaryPaymentSuccess(true);
        }

        break;
      default:
        onError?.call();
    }
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

  ///Get the list of banks available for checkout
  Future getMomoNetworks() async {
    RequestHandler(
      removeFocus: false,
      request: () => paymentService.getMomoNetworks(),
      onSuccess: (_) => {
        // log(_.data.toString()),
        setMomoNetworks(
            [...(_.data as List).map((e) => MomoNetworkModel.fromJson(e))])
      }, // setBanks(BanksModel.fromJson(_.data as Map<String, dynamic>)),
      onError: (_) => log("message $_."),
      onNetworkError: (_) => log("message $_."),
    ).sendRequest();
  }

  Future<String> otpAuthorize(
      {required String linkingRef, required String otp}) async {
    String status = "S20";
    await RequestHandler(
      request: () =>
          paymentService.otpAuthorize(otp: otp, linkingRef: linkingRef),
      onSuccess: (_) => {status = _.data['data']['code']},
      onError: (_) => log("message err$_."),
      onNetworkError: (_) => log("message err $_."),
    ).sendRequest();
    return status;
  }

  Future<String> otpMomoAuthorize(
      {required String linkingRef, required String otp}) async {
    String status = "S20";
    await RequestHandler(
      request: () =>
          paymentService.otpMomoAuthorize(otp: otp, linkingRef: linkingRef),
      onSuccess: (_) => {status = _.data['data']['code']},
      onError: (_) => log("message err$_."),
      onNetworkError: (_) => log("message err $_."),
    ).sendRequest();
    return status;
  }

  feeCalculation() async {
    String response = "0";

    log("message");
    await RequestHandler(
      request: () => paymentService.getPaymentFee(
          type: "account", amount: "2000", key: _paymentPayload.publicKey!),
      onSuccess: (_) {
        try {
          response = _.data['fee'];
          _fees = double.parse(_.data);
        } catch (e) {
          log(e.toString());
        }
      },
      onError: (_) => log("message err$_."),
      onNetworkError: (_) => log("message err $_."),
    ).sendRequest();
    notifyListeners();
    log(response);
  }

  calculateFees() {
    late double fee, optionFee, cappedAmount;

    DefaultPaymentOption feeModel =
        merchantDetailModel!.payload.country.defaultPaymentOptions.first;

    String feeMode = feeModel.paymentOptionFeeMode!;

    if (_checkIfInternational()) {
      optionFee = feeModel.internationalPaymentOptionFee!;
      cappedAmount = double.parse(merchantDetailModel!
          .payload.transactionFee.transactionCapStatus.cappedAmount!);
    } else {
      optionFee = double.parse(feeModel.paymentOptionFee!);
      cappedAmount = double.parse(merchantDetailModel!
          .payload.transactionFee.transactionCapStatus.cappedAmount!);
    }

    if (feeMode == "PERCENTAGE") {
      fee = double.parse(paymentPayload!.amount!) * (optionFee / 100);
    } else {
      fee = optionFee;
    }

    return _capAmount(fee, cappedAmount).toStringAsFixed(2);
  }

  double _capAmount(double fee, double cappedAmount) {
    return fee < cappedAmount ? fee : cappedAmount;
  }

  bool _checkIfInternational() {
    String currency =
        merchantDetailModel!.payload.country.defaultCurrency.code!;

    return paymentPayload!.currency != currency;
  }

  String amountToPay() {
    String fees = "0";
    calculateFees().then((_) {
      fees = _;
    });
    return (double.parse(fees) + double.parse(paymentPayload!.amount!))
        .toString();
  }
}

enum PaymentChannel {
  debitCard,
  bankAccount,
  ussd,
  transfer,
  changePaymentMethod,
  success,
  momo
}
