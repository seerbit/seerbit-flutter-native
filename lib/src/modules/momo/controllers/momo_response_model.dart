// To parse this JSON data, do
//
//     final momoResponseModel = momoResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:seerbit_flutter_native/src/models/payment_response_model.dart';

MomoResponseModel momoResponseModelFromJson(String str) =>
    MomoResponseModel.fromJson(json.decode(str));

String momoResponseModelToJson(MomoResponseModel data) =>
    json.encode(data.toJson());

class MomoResponseModel extends PaymentResponseModel {
  MomoResponseModel({
    this.status,
    this.data,
  });

  final String? status;
  final Data? data;

  factory MomoResponseModel.fromJson(Map<String, dynamic> json) =>
      MomoResponseModel(
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
  });

  final String? paymentReference;
  final String? linkingReference;

  factory Payments.fromJson(Map<String, dynamic> json) => Payments(
        paymentReference: json["paymentReference"],
        linkingReference: json["linkingReference"],
      );

  Map<String, dynamic> toJson() => {
        "paymentReference": paymentReference,
        "linkingReference": linkingReference,
      };
}
