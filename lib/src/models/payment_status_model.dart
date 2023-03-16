// To parse this JSON data, do
//
//     final paymentStatusModel = paymentStatusModelFromJson(jsonString);

import 'dart:convert';

PaymentStatusModel paymentStatusModelFromJson(String str) =>
    PaymentStatusModel.fromJson(json.decode(str));

String paymentStatusModelToJson(PaymentStatusModel data) =>
    json.encode(data.toJson());

class PaymentStatusModel {
  PaymentStatusModel({
    required this.status,
    required this.data,
  });

  final String? status;
  final Data data;

  factory PaymentStatusModel.fromJson(Map<String, dynamic> json) =>
      PaymentStatusModel(
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
    required this.customers,
  });

  final String? code;
  final String? message;
  final Payments payments;
  final Customers customers;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        code: json["code"],
        message: json["message"],
        payments: Payments.fromJson(json["payments"]),
        customers: Customers.fromJson(json["customers"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "payments": payments.toJson(),
        "customers": customers.toJson(),
      };
}

class Customers {
  Customers({
    required this.customerId,
    required this.customerName,
    required this.customerMobile,
    required this.customerEmail,
    required this.fee,
  });

  final String? customerId;
  final String? customerName;
  final String? customerMobile;
  final String? customerEmail;
  final String? fee;

  factory Customers.fromJson(Map<String, dynamic> json) => Customers(
        customerId: json["customerId"],
        customerName: json["customerName"],
        customerMobile: json["customerMobile"],
        customerEmail: json["customerEmail"],
        fee: json["fee"],
      );

  Map<String, dynamic> toJson() => {
        "customerId": customerId,
        "customerName": customerName,
        "customerMobile": customerMobile,
        "customerEmail": customerEmail,
        "fee": fee,
      };
}

class Payments {
  Payments({
    required this.redirectLink,
    required this.amount,
    required this.fee,
    required this.mobilenumber,
    required this.publicKey,
    required this.paymentType,
    required this.productId,
    required this.productDescription,
    required this.gatewayMessage,
    required this.gatewayCode,
    required this.gatewayref,
    required this.businessName,
    required this.mode,
    required this.redirecturl,
    required this.channelType,
    required this.sourceIp,
    required this.country,
    required this.currency,
    required this.paymentReference,
    required this.bankCode,
    required this.reason,
    required this.transactionProcessedTime,
  });

  final String? redirectLink;
  final double? amount;
  final String? fee;
  final String? mobilenumber;
  final String? publicKey;
  final String? paymentType;
  final String? productId;
  final String? productDescription;
  final String? gatewayMessage;
  final String? gatewayCode;
  final String? gatewayref;
  final String? businessName;
  final String? mode;
  final String? channelType;
  final String? sourceIp;
  final String? country;
  final String? currency;
  final String? paymentReference;
  final String? bankCode;
  final String? reason;
  final DateTime? transactionProcessedTime;
  final String? redirecturl;

  factory Payments.fromJson(Map<String, dynamic> json) => Payments(
        redirectLink: json["redirectLink"],
        amount: json["amount"]?.toDouble(),
        fee: json["fee"],
        mobilenumber: json["mobilenumber"],
        publicKey: json["publicKey"],
        paymentType: json["paymentType"],
        productId: json["productId"],
        productDescription: json["productDescription"],
        gatewayMessage: json["gatewayMessage"],
        gatewayCode: json["gatewayCode"],
        gatewayref: json["gatewayref"],
        businessName: json["businessName"],
        mode: json["mode"],
        redirecturl: json["redirecturl"],
        channelType: json["channelType"],
        sourceIp: json["sourceIP"],
        country: json["country"],
        currency: json["currency"],
        paymentReference: json["paymentReference"],
        bankCode: json["bankCode"],
        reason: json["reason"],
        transactionProcessedTime:
            DateTime.parse(json["transactionProcessedTime"]),
      );

  Map<String, dynamic> toJson() => {
        "redirectLink": redirectLink,
        "amount": amount,
        "fee": fee,
        "mobilenumber": mobilenumber,
        "publicKey": publicKey,
        "paymentType": paymentType,
        "productId": productId,
        "productDescription": productDescription,
        "gatewayMessage": gatewayMessage,
        "gatewayCode": gatewayCode,
        "gatewayref": gatewayref,
        "businessName": businessName,
        "mode": mode,
        "redirecturl": redirecturl,
        "channelType": channelType,
        "sourceIP": sourceIp,
        "country": country,
        "currency": currency,
        "paymentReference": paymentReference,
        "bankCode": bankCode,
        "reason": reason,
        "transactionProcessedTime": transactionProcessedTime?.toIso8601String(),
      };
}
