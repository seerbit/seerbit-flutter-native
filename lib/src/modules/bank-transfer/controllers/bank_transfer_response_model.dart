// To parse this JSON data, do
//
//     final transferResponseModel = transferResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:seerbit_flutter_native/src/models/payment_response_model.dart';

TransferResponseModel transferResponseModelFromJson(String str) =>
    TransferResponseModel.fromJson(json.decode(str));

String transferResponseModelToJson(TransferResponseModel data) =>
    json.encode(data.toJson());

class TransferResponseModel extends PaymentResponseModel {
  TransferResponseModel({
    required this.status,
    required this.data,
  });

  final String? status;
  
  final Data? data;

  TransferResponseModel copyWith({
    String? status,
    Data? data,
  }) =>
      TransferResponseModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory TransferResponseModel.fromJson(Map<String, dynamic> json) =>
      TransferResponseModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    required this.code,
    required this.message,
    required this.payments,
  });

  final String? code;
  final String? message;
  final Payments? payments;

  Data copyWith({
    String? code,
    String? message,
    Payments? payments,
  }) =>
      Data(
        code: code ?? this.code,
        message: message ?? this.message,
        payments: payments ?? this.payments,
      );

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        code: json["code"],
        message: json["message"],
        payments: Payments.fromJson(json["payments"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "payments": payments?.toJson(),
      };
}

class Payments {
  Payments({
    required this.paymentReference,
    required this.linkingReference,
    required this.walletName,
    required this.wallet,
    required this.bankName,
    required this.accountNumber,
  });

  final String? paymentReference;
  final String? linkingReference;
  final String? walletName;
  final String? wallet;
  final String? bankName;
  final String? accountNumber;

  Payments copyWith({
    String? paymentReference,
    String? linkingReference,
    String? walletName,
    String? wallet,
    String? bankName,
    String? accountNumber,
  }) =>
      Payments(
        paymentReference: paymentReference ?? this.paymentReference,
        linkingReference: linkingReference ?? this.linkingReference,
        walletName: walletName ?? this.walletName,
        wallet: wallet ?? this.wallet,
        bankName: bankName ?? this.bankName,
        accountNumber: accountNumber ?? this.accountNumber,
      );

  factory Payments.fromJson(Map<String, dynamic> json) => Payments(
        paymentReference: json["paymentReference"],
        linkingReference: json["linkingReference"],
        walletName: json["walletName"],
        wallet: json["wallet"],
        bankName: json["bankName"],
        accountNumber: json["accountNumber"],
      );

  Map<String, dynamic> toJson() => {
        "paymentReference": paymentReference,
        "linkingReference": linkingReference,
        "walletName": walletName,
        "wallet": wallet,
        "bankName": bankName,
        "accountNumber": accountNumber,
      };
}
