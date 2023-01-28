import 'dart:developer';

import 'package:example/core/network/network.dart';
import 'package:example/models/payment_payload_model.dart';
import 'package:example/models/response_model.dart';
import 'package:example/services/channel_service.dart';
import 'package:http/http.dart';

class PaymentServiceImpl implements PaymentService {
  final Network network;

  const PaymentServiceImpl({this.network = const Network()});
  @override
  getMerchantInformation() async {
    Response response = await network
        .get('merchant/clear/SBTESTPUBK_t4G16GCA1O51AV0Va3PPretaisXubSw1');
    return ResponseModel.fromResponse(response);
  }

  @override
  Future<ResponseModel> initiatePayment(
      {required PaymentPayloadModel payloadModel}) async {
    Map body = payloadModel.toJson();
    body.removeWhere((key, value) => value == null);
    log(body.toString());
    Response response = await network.post('initiates', body: body);
    return ResponseModel.fromResponse(response);
  }

  @override
  Future<ResponseModel> queryTransaction({required String payRef}) async {
    Response response = await network.get("query/$payRef");
    return ResponseModel.fromResponse(response);
  }

  @override
  Future<ResponseModel> getBanks() async {
    Response response = await network.get("banks");
    return ResponseModel.fromResponse(response);
  }
}
