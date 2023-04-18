import 'dart:developer';

import 'package:http/http.dart';
import 'package:seerbit_flutter_native/src/core/network/api.dart';
import 'package:seerbit_flutter_native/src/core/network/network.dart';
import 'package:seerbit_flutter_native/src/models/payment_payload_model.dart';
import 'package:seerbit_flutter_native/src/models/response_model.dart';
import 'package:seerbit_flutter_native/src/services/channel_service.dart';

class PaymentServiceImpl implements PaymentService {
  final Network network;

  const PaymentServiceImpl({this.network = const Network()});

  @override
  getMerchantInformation({required String publicKey}) async {
    Response response =
        await network.get('${const Api.live().host}merchant/clear/$publicKey');
    return ResponseModel.fromResponse(response);
  }

  @override
  Future<ResponseModel> initiatePayment(
      {required PaymentPayloadModel payloadModel}) async {
    Map body = payloadModel.toJson();
    body.removeWhere((key, value) =>
        (value == null) || (["isLive", "firstName", "lastName"].contains(key)));

    // log(body.toString());
    log("IsLive:${payloadModel.isLive}");
    bool isLive = (payloadModel.isLive ?? true);
    bool isCard = payloadModel.paymentType.toString().toLowerCase() == "card";
    Response response;
    if (isLive) {
      log("got in here1");
      response =
          await network.post('${const Api.live().host}initiates', body: body);
    } else {
      log("got in here");
      response = await network.post(
        '${!isCard ? const Api.live().host : const Api.dev().host}initiates',
        body: body,
      );
    }

    return ResponseModel.fromResponse(response);
  }

  @override
  Future<ResponseModel> queryTransaction({required String payRef}) async {
    Response response =
        await network.get("${const Api.live().host}query/$payRef");
    return ResponseModel.fromResponse(response);
  }

  @override
  Future<ResponseModel> getBanks() async {
    Response response = await network.get("${const Api.live().host}banks");
    return ResponseModel.fromResponse(response);
  }

  @override
  Future<ResponseModel> otpAuthorize(
      {required String linkingRef, required String otp}) async {
    Response response =
        await network.post("${const Api.live().host}otp", body: {
      "transaction": {
        "linkingreference": linkingRef,
        "otp": otp,
      }
    });
    return ResponseModel.fromResponse(response);
  }

  @override
  Future<ResponseModel> otpMomoAuthorize(
      {required String linkingRef, required String otp}) async {
    Response response = await network.post(
        "https://seerbitapi.com/checkout/momo/otp",
        useBaseUrl: false,
        body: {
          "transaction": {
            "linkingreference": linkingRef,
            "otp": otp,
          }
        });
    return ResponseModel.fromResponse(response);
  }

  @override
  Future<ResponseModel> getMomoNetworks() async {
    Response response = await network.get(
      "https://seerbitapi.com/tranmgt/networks/GH/00000103",
    );

    return ResponseModel.fromResponse(response);
  }

  @override
  Future<ResponseModel> getPaymentFee(
      {required String type,
      required String amount,
      required String key}) async {
    Response response = await network.post(
        "https://checkout.service.seerbitapi.com",
        useBaseUrl: false,
        body: {"key": key, "type": type, "amount": amount});

    return ResponseModel.fromResponse(response);
  }

  @override
  Future<ResponseModel> getCardBin({required String cardNumber}) async {
    Response response =
        await network.get("https://seerbitapi.com/checkout/bin/$cardNumber");
    return ResponseModel.fromResponse(response);
  }
}
