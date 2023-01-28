// To parse this JSON data, do
//
//     final debitCardPayload = debitCardPayloadFromJson(jsonString);

import 'dart:convert';

import 'package:example/models/payload.dart';

DebitCardPayload debitCardPayloadFromJson(String str) =>
    DebitCardPayload.fromJson(json.decode(str));

String debitCardPayloadToJson(DebitCardPayload data) =>
    json.encode(data.toJson());

class DebitCardPayload extends PayloadModel {
  DebitCardPayload({
    this.fullName,
    this.mobileNumber,
    this.email,
    this.publicKey,
    this.amount,
    this.currency,
    this.country,
    this.paymentReference,
    this.productId,
    this.redirectUrl,
    this.paymentType,
    this.channelType,
    this.deviceType,
    this.sourceIp,
    this.cardNumber,
    this.cvv,
    this.expiryMonth,
    this.expiryYear,
    this.source,
    this.fee,
    this.pin,
    this.retry,
    this.rememberMe,
    this.isCardInternational,
  });

  final String? fullName;
  final String? mobileNumber;
  final String? email;
  final String? publicKey;
  final String? amount;
  final String? currency;
  final String? country;
  final String? paymentReference;
  final String? productId;
  final String? redirectUrl;
  final String? paymentType;
  final String? channelType;
  final String? deviceType;
  final String? sourceIp;
  final String? cardNumber;
  final String? cvv;
  final String? expiryMonth;
  final String? expiryYear;
  final String? source;
  final String? fee;
  final String? pin;
  final bool? retry;
  final bool? rememberMe;
  final String? isCardInternational;

  DebitCardPayload copyWith({
    String? fullName,
    String? mobileNumber,
    String? email,
    String? publicKey,
    String? amount,
    String? currency,
    String? country,
    String? paymentReference,
    String? productId,
    String? redirectUrl,
    String? paymentType,
    String? channelType,
    String? deviceType,
    String? sourceIp,
    String? cardNumber,
    String? cvv,
    String? expiryMonth,
    String? expiryYear,
    String? source,
    String? fee,
    String? pin,
    bool? retry,
    bool? rememberMe,
    String? isCardInternational,
  }) =>
      DebitCardPayload(
        fullName: fullName ?? this.fullName,
        mobileNumber: mobileNumber ?? this.mobileNumber,
        email: email ?? this.email,
        publicKey: publicKey ?? this.publicKey,
        amount: amount ?? this.amount,
        currency: currency ?? this.currency,
        country: country ?? this.country,
        paymentReference: paymentReference ?? this.paymentReference,
        productId: productId ?? this.productId,
        redirectUrl: redirectUrl ?? this.redirectUrl,
        paymentType: paymentType ?? this.paymentType,
        channelType: channelType ?? this.channelType,
        deviceType: deviceType ?? this.deviceType,
        sourceIp: sourceIp ?? this.sourceIp,
        cardNumber: cardNumber ?? this.cardNumber,
        cvv: cvv ?? this.cvv,
        expiryMonth: expiryMonth ?? this.expiryMonth,
        expiryYear: expiryYear ?? this.expiryYear,
        source: source ?? this.source,
        fee: fee ?? this.fee,
        pin: pin ?? this.pin,
        retry: retry ?? this.retry,
        rememberMe: rememberMe ?? this.rememberMe,
        isCardInternational: isCardInternational ?? this.isCardInternational,
      );

  factory DebitCardPayload.fromJson(Map<String, dynamic> json) =>
      DebitCardPayload(
        fullName: json["fullName"],
        mobileNumber: json["mobileNumber"],
        email: json["email"],
        publicKey: json["publicKey"],
        amount: json["amount"],
        currency: json["currency"],
        country: json["country"],
        paymentReference: json["paymentReference"],
        productId: json["productId"],
        redirectUrl: json["redirectUrl"],
        paymentType: json["paymentType"],
        channelType: json["channelType"],
        deviceType: json["deviceType"],
        sourceIp: json["sourceIP"],
        cardNumber: json["cardNumber"],
        cvv: json["cvv"],
        expiryMonth: json["expiryMonth"],
        expiryYear: json["expiryYear"],
        source: json["source"],
        fee: json["fee"],
        pin: json["pin"],
        retry: json["retry"],
        rememberMe: json["rememberMe"],
        isCardInternational: json["isCardInternational"],
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
        "redirectUrl": redirectUrl,
        "paymentType": paymentType,
        "channelType": channelType,
        "deviceType": deviceType,
        "sourceIP": sourceIp,
        "cardNumber": cardNumber,
        "cvv": cvv,
        "expiryMonth": expiryMonth,
        "expiryYear": expiryYear,
        "source": source,
        "fee": fee,
        "pin": pin,
        "retry": retry,
        "rememberMe": rememberMe,
        "isCardInternational": isCardInternational,
      };
}
