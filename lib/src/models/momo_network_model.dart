// To parse this JSON data, do
//
//     final momoNetworkModel = momoNetworkModelFromJson(jsonString);

import 'dart:convert';

MomoNetworkModel momoNetworkModelFromJson(String str) =>
    MomoNetworkModel.fromJson(json.decode(str));

String momoNetworkModelToJson(MomoNetworkModel data) =>
    json.encode(data.toJson());

class MomoNetworkModel {
  MomoNetworkModel({
    this.id,
    this.networks,
    this.networkCode,
    this.countryCode,
    this.status,
    this.processorCode,
    this.voucherCode,
  });

  final int? id;
  final String? networks;
  final String? networkCode;
  final String? countryCode;
  final String? status;
  final String? processorCode;
  final bool? voucherCode;

  factory MomoNetworkModel.fromJson(Map<String, dynamic> json) =>
      MomoNetworkModel(
        id: json["id"],
        networks: json["networks"],
        networkCode: json["networkCode"],
        countryCode: json["countryCode"],
        status: json["status"],
        processorCode: json["processorCode"],
        voucherCode: json["voucherCode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "networks": networks,
        "networkCode": networkCode,
        "countryCode": countryCode,
        "status": status,
        "processorCode": processorCode,
        "voucherCode": voucherCode,
      };
}
