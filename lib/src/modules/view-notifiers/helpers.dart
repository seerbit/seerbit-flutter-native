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

  // String aesDecrypt(String encryptedData, String key, String iv) {
  //   // Convert the encrypted data, key, and IV to byte arrays
  //   Uint8List encryptedBytes = base64.decode(encryptedData);
  //   Uint8List keyBytes = utf8.encode(key);
  //   Uint8List ivBytes = utf8.encode(iv);

  //   // Set up the AES cipher parameters
  //   final params = new CBCBlockCipherParameters(
  //       new PaddedBlockCipherParameters(new KeyParameter(keyBytes), null),
  //       ivBytes);

  //   // Initialize the cipher with the parameters
  //   final cipher = new PaddedBlockCipher("AES/CBC/PKCS7")..init(false, params);

  //   // Decrypt the encrypted data
  //   final decryptedBytes = cipher.process(encryptedBytes);

  //   // Return the decrypted data as a string
  //   return utf8.decode(decryptedBytes);
  // }

}
