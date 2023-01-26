import 'package:example/core/network/network.dart';
import 'package:example/models/response_model.dart';
import 'package:example/services/channel_service.dart';
import 'package:http/http.dart';

class PaymentServiceImpl implements PaymentService {
  final Network network;

  const PaymentServiceImpl({this.network = const Network()});
  @override
  getMerchantInformation() async {
    Response response =
        await network.get('SBTESTPUBK_t4G16GCA1O51AV0Va3PPretaisXubSw1');
    return ResponseModel.fromResponse(response);
  }
}
