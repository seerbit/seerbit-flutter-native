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
    Response response = await network.get('checkout/merchant/clear/$publicKey');
    return ResponseModel.fromResponse(response);
  }

  @override
  Future<ResponseModel> initiatePayment(
      {required PaymentPayloadModel payloadModel}) async {
    Map body = payloadModel.toJson();
    body.removeWhere((key, value) => value == null);
    log(body.toString());
    Response response = await network.post(
        '${const Api.dev().getSandbox(payloadModel.paymentType!)}/initiates',
        body: body);
    log('${const Api.dev().getSandbox(payloadModel.paymentType!)}/initiates');
    log(response.body.toString());
    return ResponseModel.fromResponse(response);
  }

  @override
  Future<ResponseModel> queryTransaction({required String payRef}) async {
    Response response = await network
        .get("${const Api.dev().getSandbox("query")}/query/$payRef");
    return ResponseModel.fromResponse(response);
  }

  @override
  Future<ResponseModel> getBanks() async {
    Response response =
        await network.get("${const Api.dev().getSandbox("banks")}/banks");
    return ResponseModel.fromResponse(response);
  }

  @override
  Future<ResponseModel> otpAuthorize(
      {required String linkingRef, required String otp}) async {
    Response response =
        await network.post("${const Api.dev().getSandbox("CARD")}/otp", body: {
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
    Response response =
        await network.post("https://seerbitapi.com/checkout/momo/otp", body: {
      "transaction": {
        "linkingreference": linkingRef,
        "otp": otp,
      }
    });
    return ResponseModel.fromResponse(response);
  }

  @override
  Future<ResponseModel> getMomoNetworks() async {
    Response response = await network.get("tranmgt/networks/GH/00000103");

    return ResponseModel.fromResponse(response);
  }

  @override
  Future<ResponseModel> getPaymentFee(
      {required String type,
      required String amount,
      required String key}) async {
    Response response = await network.post(
        "https://gex2635n2p5f6zvjckeqygbcha0cmlnp.lambda-url.eu-west-2.on.aws",
        body: {
          "key": "SBPUBK_0HSRUO39Y4WZABLHEFMHTTLKYYJ52MTS",
          "type": "account",
          "amount": "1022200"
        });

    return ResponseModel.fromResponse(response);
  }
}
