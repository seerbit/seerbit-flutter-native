import 'package:example/models/payment_payload_model.dart';
import 'package:example/models/response_model.dart';

abstract class PaymentService {
  Future<ResponseModel> getMerchantInformation();
  Future<ResponseModel> initiatePayment(
      {required PaymentPayloadModel payloadModel});
  Future<ResponseModel> queryTransaction({required String payRef});
  Future<ResponseModel> getBanks();
}
  