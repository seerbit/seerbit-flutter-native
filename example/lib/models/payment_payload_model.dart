// To parse this JSON data, do
//
//     final PaymentPayloadModel = paymentPayloadFromJson(jsonString);

import 'dart:convert';

PaymentPayloadModel paymentPayloadFromJson(String str) =>
    PaymentPayloadModel.fromJson(json.decode(str));

String paymentPayloadToJson(PaymentPayloadModel data) => json.encode(data.toJson());

class PaymentPayloadModel {
  PaymentPayloadModel({
    required this.fullName,
    required this.mobileNumber,
    required this.email,
    required this.publicKey,
    required this.amount,
    required this.currency,
    required this.country,
    required this.paymentReference,
    required this.productId,
    required this.productDescription,
    required this.redirectUrl,
    required this.paymentType,
    required this.channelType,
    required this.ddeviceType,
    required this.sourceIp,
    required this.source,
    required this.fee,
    required this.retry,
    required this.bankCode,
  });

  final String fullName;
  final String mobileNumber;
  final String email;
  final String publicKey;
  final String amount;
  final String currency;
  final String country;
  final String paymentReference;
  final String productId;
  final String productDescription;
  final String redirectUrl;
  final String paymentType;
  final String channelType;
  final String ddeviceType;
  final String sourceIp;
  final String source;
  final String fee;
  final bool retry;
  final String bankCode;

  PaymentPayloadModel copyWith({
    String? fullName,
    String? mobileNumber,
    String? email,
    String? publicKey,
    String? amount,
    String? currency,
    String? country,
    String? paymentReference,
    String? productId,
    String? productDescription,
    String? redirectUrl,
    String? paymentType,
    String? channelType,
    String? ddeviceType,
    String? sourceIp,
    String? source,
    String? fee,
    bool? retry,
    String? bankCode,
  }) =>
      PaymentPayloadModel(
        fullName: fullName ?? this.fullName,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        email: email ?? this.email,
        publicKey: publicKey ?? this.publicKey,
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
        country: country ?? this.country,
        paymentReference: paymentReference ?? this.paymentReference,
        productId: productId ?? this.productId,
        productDescription: productDescription ?? this.productDescription,
        redirectUrl: redirectUrl ?? this.redirectUrl,
        paymentType: paymentType ?? this.paymentType,
        channelType: channelType ?? this.channelType,
        ddeviceType: ddeviceType ?? this.ddeviceType,
        sourceIp: sourceIp ?? this.sourceIp,
        source: source ?? this.source,
        fee: fee ?? this.fee,
        retry: retry ?? this.retry,
        bankCode: bankCode ?? this.bankCode,
      );

  factory PaymentPayloadModel.fromJson(Map<String, dynamic> json) => PaymentPayloadModel(
        fullName: json["fullName"],
        mobileNumber: json["mobileNumber"],
        email: json["email"],
        publicKey: json["publicKey"],
        amount: json["amount"],
        currency: json["currency"],
        country: json["country"],
        paymentReference: json["paymentReference"],
        productId: json["productId"],
        productDescription: json["productDescription"],
        redirectUrl: json["redirectUrl"],
        paymentType: json["paymentType"],
        channelType: json["channelType"],
        ddeviceType: json["ddeviceType"],
        sourceIp: json["sourceIP"],
        source: json["source"],
        fee: json["fee"],
        retry: json["retry"],
        bankCode: json["bankCode"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "mobileNumber": mobileNumber,
        "email": email,
        "publicKey": publicKey,
        "amount": amount,
        "currency": currency,
        "country": country,
        "paymentReference": paymentReference,
        "productId": productId,
        "productDescription": productDescription,
        "redirectUrl": redirectUrl,
        "paymentType": paymentType,
        "channelType": channelType,
        "ddeviceType": ddeviceType,
        "sourceIP": sourceIp,
        "source": source,
        "fee": fee,
        "retry": retry,
        "bankCode": bankCode,
      };
}
