// To parse this JSON data, do
//
//     final debitCardResponseModel = debitCardResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:seerbit_flutter_native/src/models/models.dart';

BankAccountResponseModel debitCardResponseModelFromJson(String str) =>
    BankAccountResponseModel.fromJson(json.decode(str));

String debitCardResponseModelToJson(BankAccountResponseModel data) =>
    json.encode(data.toJson());

class BankAccountResponseModel extends PaymentResponseModel {
  BankAccountResponseModel({
    this.status,
    this.data,
  });

  final String? status;
  final Data? data;

  factory BankAccountResponseModel.fromJson(Map<String, dynamic> json) =>
      BankAccountResponseModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.code,
    this.message,
    this.payments,
  });

  final String? code;
  final String? message;
  final Payments? payments;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        code: json["code"],
        message: json["message"],
        payments: json["payments"] == null
            ? null
            : Payments.fromJson(json["payments"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "payments": payments?.toJson(),
      };
}

class Payments {
  Payments({
    this.paymentReference,
    this.linkingReference,
    this.redirectUrl,
  });

  final String? paymentReference;
  final String? linkingReference;
  final String? redirectUrl;

  factory Payments.fromJson(Map<String, dynamic> json) => Payments(
        paymentReference: json["paymentReference"],
        linkingReference: json["linkingReference"],
        redirectUrl: json["redirectUrl"],
      );

  Map<String, dynamic> toJson() => {
        "paymentReference": paymentReference,
        "linkingReference": linkingReference,
        "redirectUrl": redirectUrl,
      };
}
