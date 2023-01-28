// To parse this JSON data, do
//
//     final banksModel = banksModelFromJson(jsonString);

import 'dart:convert';

BanksModel banksModelFromJson(String str) =>
    BanksModel.fromJson(json.decode(str));

String banksModelToJson(BanksModel data) => json.encode(data.toJson());

class BanksModel {
  BanksModel({
    required this.status,
    required this.data,
  });

  final String? status;
  final Data data;

  factory BanksModel.fromJson(Map<String, dynamic> json) => BanksModel(
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
    required this.merchantBanks,
    required this.message,
  });

  final String? code;
  final List<MerchantBank> merchantBanks;
  final String? message;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        code: json["code"],
        merchantBanks: List<MerchantBank>.from(
            json["merchantBanks"].map((x) => MerchantBank.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "merchantBanks":
            List<dynamic>.from(merchantBanks.map((x) => x.toJson())),
        "message": message,
      };
}

class MerchantBank {
  MerchantBank({
    required this.bankName,
    required this.bankCode,
    required this.directConnection,
    required this.url,
    required this.logo,
    required this.status,
    required this.operation,
    required this.minimumAmount,
    required this.requiredFields,
  });

  final String? bankName;
  final String? bankCode;
  final String? directConnection;
  final String? url;
  final String? logo;
  final String? status;
  final String? operation;
  final double? minimumAmount;
  final RequiredFields requiredFields;

  factory MerchantBank.fromJson(Map<String, dynamic> json) => MerchantBank(
        bankName: json["bankName"],
        bankCode: json["bankCode"],
        directConnection: json["directConnection"],
        url: json["url"],
        logo: json["logo"],
        status: json["status"],
        operation: json["operation"],
        minimumAmount: json["minimumAmount"],
        requiredFields: RequiredFields.fromJson(json["requiredFields"]),
      );

  Map<String, dynamic> toJson() => {
        "bankName": bankName,
        "bankCode": bankCode,
        "directConnection": directConnection,
        "url": url,
        "logo": logo,
        "status": status,
        "operation": operation,
        "minimumAmount": minimumAmount,
        "requiredFields": requiredFields.toJson(),
      };
}

class RequiredFields {
  RequiredFields({
    required this.accountName,
    required this.accountNumber,
    required this.isBankCode,
    required this.bvn,
    required this.dateOfBirth,
    required this.mobileNumber,
  });

  final String? accountName;
  final String? accountNumber;
  final String? isBankCode;
  final String? bvn;
  final String? dateOfBirth;
  final String? mobileNumber;

  factory RequiredFields.fromJson(Map<String, dynamic> json) => RequiredFields(
        accountName: json["accountName"],
        accountNumber: json["accountNumber"],
        isBankCode: json["isBankCode"],
        bvn: json["bvn"],
        dateOfBirth: json["dateOfBirth"],
        mobileNumber: json["mobileNumber"],
      );

  Map<String, dynamic> toJson() => {
        "accountName": accountName,
        "accountNumber": accountNumber,
        "isBankCode": isBankCode,
        "bvn": bvn,
        "dateOfBirth": dateOfBirth,
        "mobileNumber": mobileNumber,
      };
}
