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
    this.address,
    this.city,
    this.state,
    this.postalCode,
    this.billingCountry,
    this.firstName,
    this.isLive,
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

  final String? address, city, state, postalCode, billingCountry;
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
  final bool? isLive;
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

  PaymentPayloadModel copyWith(
          {String? firstName,
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
          bool? isLive,
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
          String? address,
          String? city,
          String? state,
          String? postalCode,
          String? billingCountry}) =>
      PaymentPayloadModel(
        address: address ?? this.address,
        city: city ?? this.city,
        state: state ?? this.state,
        postalCode: postalCode ?? this.postalCode,
        billingCountry: billingCountry ?? this.billingCountry,
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
        isLive: isLive ?? this.isLive,
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
        address: json["address"],
        city: json['city'],
        state: json['state'],
        postalCode: json['postalCode'],
        billingCountry: json["billingCountry"],
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
        "address": address,
        "city": city,
        "state": state,
        "postalCode": postalCode,
        "billingCountry": billingCountry
      };
}

Map<String, dynamic> map = {
  "publicKey": null,
  "productId": "",
  "redirectUrl": "https://google.com",
  "deviceType": "Desktop",
  "sourceIP": "0.0.0.1",
  "retry": false,
  "rememberMe": false,
  "ddeviceType": "Desktop",
  "accountName": "Amos Oruaroghene",
  "accountNumber": null,
  "bvn": null,
  "dateOfBirth": null,
  "network": null,
  "fullName": null
};
// {firstName: awda,
//  lastName: asd,
  // mobileNumber: 09123123, email: awd@mail.com, publicKey: SBTESTPUBK_t4G16GCA1O51AV0Va3PPretaisXubSw1, amount: 1000, currency: NGN, country: NG, paymentReference: ST-1232231152750181, productId: , redirectUrl: https://google.com, paymentType: USSD, channelType: ussd, deviceType: Desktop, sourceIP: 0.0.0.1, fee: 34.20, retry: false, rememberMe: false, bankCode: 058, ddeviceType: Desktop, accountName: Amos Oruaroghene, accountNumber: 0107629596, bvn: 12345678901, dateOfBirth: 1/19/2023, network: MTN},
// Map<String, dynamic> map = {
//   "fullName": "Amos Oruaroghene",
//   "mobileNumber": "404",
//   "email": "inspiron.amos@gmail.com" ,
//   "publicKey": "SBTESTPUBK_t4G16GCA1O51AV0Va3PPretaisXubSw1",
//   "amount": "101.50",
//   "currency": "NGN",
//   "country": "NG",
//   "paymentReference": "SBT-T54367073117",
//   "productId": "",
//   "productDescription": "",
//   "redirectUrl": "http://localhost:3002/#/",
//   "paymentType": "USSD",
//   "channelType": "ussd",
//   "ddeviceType": "Desktop",
//   "sourceIP": "102.88.63.64",
//   "source": "",
//   "fee": "1.50",
//   "retry": true,
//   "bankCode": "044"
// };
