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
    Response response =
        await network.post('initiates', body: payloadModel.toJson());
    return ResponseModel.fromResponse(response);
  }
}
