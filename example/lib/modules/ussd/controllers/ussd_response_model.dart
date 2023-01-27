// To parse this JSON data, do
//
//     final ussdResponseModel = ussdResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:example/models/payment_response_model.dart';

UssdResponseModel ussdResponseModelFromJson(String str) =>
    UssdResponseModel.fromJson(json.decode(str));

String ussdResponseModelToJson(UssdResponseModel data) =>
    json.encode(data.toJson());

class UssdResponseModel extends PaymentResponseModel {
  UssdResponseModel({
    required this.status,
    required this.data,
  });

  final String status;
  final Data data;

  UssdResponseModel copyWith({
    String? status,
    Data? data,
  }) =>
      UssdResponseModel(
        status: status ?? this.status,
        data: data ?? this.data,
      );

  factory UssdResponseModel.fromJson(Map<String, dynamic> json) =>
      UssdResponseModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.code,
    required this.message,
    required this.payments,
  });

  final String code;
  final String message;
  final Payments payments;

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
        "payments": payments.toJson(),
      };
}

class Payments {
  Payments({
    required this.paymentReference,
    required this.linkingReference,
    required this.providerreference,
    required this.ussdDailCode,
  });

  final String paymentReference;
  final String linkingReference;
  final String providerreference;
  final String ussdDailCode;

  Payments copyWith({
    String? paymentReference,
    String? linkingReference,
    String? providerreference,
    String? ussdDailCode,
  }) =>
      Payments(
        paymentReference: paymentReference ?? this.paymentReference,
        linkingReference: linkingReference ?? this.linkingReference,
        providerreference: providerreference ?? this.providerreference,
        ussdDailCode: ussdDailCode ?? this.ussdDailCode,
      );

  factory Payments.fromJson(Map<String, dynamic> json) => Payments(
        paymentReference: json["paymentReference"],
        linkingReference: json["linkingReference"],
        providerreference: json["providerreference"],
        ussdDailCode: json["ussdDailCode"],
      );

  Map<String, dynamic> toJson() => {
        "paymentReference": paymentReference,
        "linkingReference": linkingReference,
        "providerreference": providerreference,
        "ussdDailCode": ussdDailCode,
      };
}
