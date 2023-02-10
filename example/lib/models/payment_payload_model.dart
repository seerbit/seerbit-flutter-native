// To parse this JSON data, do
//
//     final paymentPayloadModel = paymentPayloadModelFromJson(jsonString);

import 'dart:convert';

PaymentPayloadModel paymentPayloadModelFromJson(String str) =>
    PaymentPayloadModel.fromJson(json.decode(str));

String paymentPayloadModelToJson(PaymentPayloadModel data) =>
    json.encode(data.toJson());

class PaymentPayloadModel {
  PaymentPayloadModel({
    this.firstName,
    this.lastName,
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
    this.paymentPayloadModelNew,
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
    this.productDescription,
    this.amountControl,
    this.walletDaysActive,
    this.bankCode,
    this.ddeviceType,
    this.accountName,
    this.accountNumber,
    this.bvn,
    this.dateOfBirth,
    this.scheduleId,
    this.network,
    this.voucherCode,
  });

  final String? firstName;
  final String? lastName;
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
  final String? paymentPayloadModelNew;
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
  final String? productDescription;
  final String? amountControl;
  final String? walletDaysActive;
  final String? bankCode;
  final String? ddeviceType;
  final String? accountName;
  final String? accountNumber;
  final String? bvn;
  final String? dateOfBirth;
  final String? scheduleId;
  final String? network;
  final String? voucherCode;

  PaymentPayloadModel copyWith({
    String? firstName,
    String? lastName,
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
    String? paymentPayloadModelNew,
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
    String? productDescription,
    String? amountControl,
    String? walletDaysActive,
    String? bankCode,
    String? ddeviceType,
    String? accountName,
    String? accountNumber,
    String? bvn,
    String? dateOfBirth,
    String? scheduleId,
    String? network,
    String? voucherCode,
  }) =>
      PaymentPayloadModel(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
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
        paymentPayloadModelNew:
            paymentPayloadModelNew ?? this.paymentPayloadModelNew,
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
        productDescription: productDescription ?? this.productDescription,
        amountControl: amountControl ?? this.amountControl,
        walletDaysActive: walletDaysActive ?? this.walletDaysActive,
        bankCode: bankCode ?? this.bankCode,
        ddeviceType: ddeviceType ?? this.ddeviceType,
        accountName: accountName ?? this.accountName,
        accountNumber: accountNumber ?? this.accountNumber,
        bvn: bvn ?? this.bvn,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        scheduleId: scheduleId ?? this.scheduleId,
        network: network ?? this.network,
        voucherCode: voucherCode ?? this.voucherCode,
      );

  factory PaymentPayloadModel.empty() => PaymentPayloadModel.fromJson(map);

  factory PaymentPayloadModel.fromJson(Map<String, dynamic> json) =>
      PaymentPayloadModel(
        firstName: json["firstName"],
        lastName: json["lastName"],
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
        paymentPayloadModelNew: json["new"],
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
        productDescription: json["productDescription"],
        amountControl: json["amountControl"],
        walletDaysActive: json["walletDaysActive"],
        bankCode: json["bankCode"],
        ddeviceType: json["ddeviceType"],
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        bvn: json["bvn"],
        dateOfBirth: json["dateOfBirth"],
        scheduleId: json["scheduleId"],
        network: json["network"],
        voucherCode: json["voucherCode"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName,
        "lastName": lastName,
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
        "new": paymentPayloadModelNew,
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
        "productDescription": productDescription,
        "amountControl": amountControl,
        "walletDaysActive": walletDaysActive,
        "bankCode": bankCode,
        "ddeviceType": ddeviceType,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "bvn": bvn,
        "dateOfBirth": dateOfBirth,
        "scheduleId": scheduleId,
        "network": network,
        "voucherCode": voucherCode,
      };
}

Map<String, dynamic> map = {
  "fullName": "Amos Oruaroghne",
  "mobileNumber": "07084324226",
  "email": "inspiron.amos@gsail.com",
  "publicKey": "SBTESTPUBK_t4G16GCA1O51AV0Va3PPretaisXubSw1",
  "amount": "924.20",
  "currency": "NGN",
  "country": "NG",
  "paymentReference": "ST-T54267012257a",
  "productId": "",
  "redirectUrl": "http://localhost:3002/#/",
  "paymentType": "TRANSFER",
  "channelType": "Transfer",
  "new": "stuff",
  "deviceType": "Desktop",
  "sourceIP": "0.0.0.1",
  "cardNumber": null,
  "cvv": null,
  "expiryMonth": null,
  "expiryYear": null,
  "source": "",
  "fee": "34.20",
  "pin": "",
  "retry": false,
  "rememberMe": false,
  "isCardInternational": "LOCAL",
  "productDescription": "",
  "amountControl": "FIXEDAMOUNT",
  "walletDaysActive": "1",
  "bankCode": "",
  "firstName": "as",
  "lastName": "as",
  "ddeviceType": "Desktop",
  "accountName": "Amos Oruaroghene",
  "accountNumber": "0107629596",
  "bvn": "12345678901",
  "dateOfBirth": "1/19/2023",
  "scheduleId": "",
  "network": "MTN",
  "voucherCode": "",
};
