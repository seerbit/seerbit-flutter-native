import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';

class Helper {
  ///Map the Payment channels to the String
  PaymentChannel mapChannel(String channel) {
    switch (channel) {
      case "Card":
        return PaymentChannel.debitCard;
      case "ACCOUNT":
        return PaymentChannel.bankAccount;
      case "TRANSFER":
        return PaymentChannel.transfer;
      case "USSD":
        return PaymentChannel.ussd;
      case "MOMO":
        return PaymentChannel.momo;
      default:
        return PaymentChannel.debitCard;
    }
  }

  ///Map the Payment channels to the String
  String reverseMapChannel(PaymentChannel channel) {
    switch (channel) {
      case PaymentChannel.debitCard:
        return "Card";
      case PaymentChannel.bankAccount:
        return "Account";
      case PaymentChannel.transfer:
        return "Transfer";
      case PaymentChannel.ussd:
        return "Ussd";
      case PaymentChannel.momo:
        return "MOMO";
      default:
        return "Card";
    }
  }
}
