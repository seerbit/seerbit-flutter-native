// To parse this JSON data, do
//
//     final debitCardResponseModel = debitCardResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:seerbit_flutter_native/src/models/models.dart';

DebitCardResponseModel debitCardResponseModelFromJson(String str) =>
    DebitCardResponseModel.fromJson(json.decode(str));

String debitCardResponseModelToJson(DebitCardResponseModel data) =>
    json.encode(data.toJson());

class DebitCardResponseModel extends PaymentResponseModel {
  DebitCardResponseModel({
    this.status,
    this.data,
  });

  final String? status;
  final Data? data;

  factory DebitCardResponseModel.fromJson(Map<String, dynamic> json) =>
      DebitCardResponseModel(
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
