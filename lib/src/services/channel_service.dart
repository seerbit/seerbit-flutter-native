import 'package:seerbit_flutter_native/src/models/payment_payload_model.dart';
import 'package:seerbit_flutter_native/src/models/response_model.dart';

abstract class PaymentService {
  Future<ResponseModel> getMerchantInformation({required String publicKey});
  Future<ResponseModel> initiatePayment(
      {required PaymentPayloadModel payloadModel});
  Future<ResponseModel> queryTransaction({required String payRef});
  Future<ResponseModel> getBanks();
  Future<ResponseModel> otpAuthorize(
      {required String linkingRef, required String otp});
  Future<ResponseModel> getMomoNetworks();

  Future<ResponseModel> otpMomoAuthorize(
      {required String linkingRef, required String otp});

  Future<ResponseModel> getPaymentFee(
      {required String type, required String amount, required String key});
}
