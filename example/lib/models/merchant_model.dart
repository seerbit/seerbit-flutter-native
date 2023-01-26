// To parse this JSON data, do
//
//     final merchantDetailModel = merchantDetailModelFromJson(jsonString);
import 'dart:convert';

MerchantDetailModel merchantDetailModelFromJson(String str) =>
    MerchantDetailModel.fromJson(json.decode(str));

String merchantDetailModelToJson(MerchantDetailModel data) =>
    json.encode(data.toJson());

class MerchantDetailModel {
  MerchantDetailModel({
    required this.payload,
    required this.message,
    required this.status,
    required this.responseCode,
  });

  final Payload payload;
  final String message;
  final String status;
  final String responseCode;

  factory MerchantDetailModel.fromJson(Map<String, dynamic> json) =>
      MerchantDetailModel(
        payload: Payload.fromJson(json["payload"]),
        message: json["message"],
        status: json["status"],
        responseCode: json["responseCode"],
      );

  Map<String, dynamic> toJson() => {
        "payload": payload.toJson(),
        "message": message,
        "status": status,
        "responseCode": responseCode,
      };
}

class Payload {
  Payload({
    required this.businessName,
    required this.transLink,
    required this.number,
    required this.livePublicKey,
    required this.testPublicKey,
    required this.address,
    required this.cardFee,
    required this.transactionFee,
    required this.defaultCurrency,
    required this.allowedCurrency,
    required this.logo,
    required this.supportEmail,
    required this.maxAmount,
    required this.minAmount,
    required this.setting,
    required this.status,
    required this.isWhiteLabelled,
    required this.country,
    required this.paymentConfigs,
    required this.channelOptionStatus,
    required this.checkoutPageConfig,
    required this.activeForValidationService,
    required this.maxThreshold,
    required this.minThreshold,
    required this.enableOvercharge,
    required this.enableUnderCharge,
    required this.enableCustomerForTransfer,
    required this.enableForDiscount,
    required this.enableDescriptor,
    required this.partnerId,
  });

  final String businessName;
  final String transLink;
  final String number;
  final String livePublicKey;
  final String testPublicKey;
  final Address address;
  final CardFee cardFee;
  final TransactionFee transactionFee;
  final String defaultCurrency;
  final List<String> allowedCurrency;
  final String logo;
  final String supportEmail;
  final int maxAmount;
  final int minAmount;
  final Setting setting;
  final String status;
  final bool isWhiteLabelled;
  final Country country;
  final List<dynamic> paymentConfigs;
  final List<ChannelOptionStatus> channelOptionStatus;
  final CheckoutPageConfig checkoutPageConfig;
  final bool activeForValidationService;
  final String maxThreshold;
  final String minThreshold;
  final bool enableOvercharge;
  final bool enableUnderCharge;
  final bool enableCustomerForTransfer;
  final bool enableForDiscount;
  final bool enableDescriptor;
  final String partnerId;

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
        businessName: json["business_name"],
        transLink: json["transLink"],
        number: json["number"],
        livePublicKey: json["live_public_key"],
        testPublicKey: json["test_public_key"],
        address: Address.fromJson(json["address"]),
        cardFee: CardFee.fromJson(json["cardFee"]),
        transactionFee: TransactionFee.fromJson(json["transactionFee"]),
        defaultCurrency: json["default_currency"],
        allowedCurrency:
            List<String>.from(json["allowedCurrency"].map((x) => x)),
        logo: json["logo"],
        supportEmail: json["support_email"],
        maxAmount: json["max_amount"],
        minAmount: json["min_amount"],
        setting: Setting.fromJson(json["setting"]),
        status: json["status"],
        isWhiteLabelled: json["isWhiteLabelled"],
        country: Country.fromJson(json["country"]),
        paymentConfigs:
            List<dynamic>.from(json["paymentConfigs"].map((x) => x)),
        channelOptionStatus: List<ChannelOptionStatus>.from(
            json["channelOptionStatus"]
                .map((x) => ChannelOptionStatus.fromJson(x))),
        checkoutPageConfig:
            CheckoutPageConfig.fromJson(json["checkoutPageConfig"]),
        activeForValidationService: json["activeForValidationService"],
        maxThreshold: json["max_threshold"],
        minThreshold: json["min_threshold"],
        enableOvercharge: json["enableOvercharge"],
        enableUnderCharge: json["enableUnderCharge"],
        enableCustomerForTransfer: json["enableCustomerForTransfer"],
        enableForDiscount: json["enableForDiscount"],
        enableDescriptor: json["enable_descriptor"],
        partnerId: json["partnerId"],
      );

  Map<String, dynamic> toJson() => {
        "business_name": businessName,
        "transLink": transLink,
        "number": number,
        "live_public_key": livePublicKey,
        "test_public_key": testPublicKey,
        "address": address.toJson(),
        "cardFee": cardFee.toJson(),
        "transactionFee": transactionFee.toJson(),
        "default_currency": defaultCurrency,
        "allowedCurrency": List<dynamic>.from(allowedCurrency.map((x) => x)),
        "logo": logo,
        "support_email": supportEmail,
        "max_amount": maxAmount,
        "min_amount": minAmount,
        "setting": setting.toJson(),
        "status": status,
        "isWhiteLabelled": isWhiteLabelled,
        "country": country.toJson(),
        "paymentConfigs": List<dynamic>.from(paymentConfigs.map((x) => x)),
        "channelOptionStatus":
            List<dynamic>.from(channelOptionStatus.map((x) => x.toJson())),
        "checkoutPageConfig": checkoutPageConfig.toJson(),
        "activeForValidationService": activeForValidationService,
        "max_threshold": maxThreshold,
        "min_threshold": minThreshold,
        "enableOvercharge": enableOvercharge,
        "enableUnderCharge": enableUnderCharge,
        "enableCustomerForTransfer": enableCustomerForTransfer,
        "enableForDiscount": enableForDiscount,
        "enable_descriptor": enableDescriptor,
        "partnerId": partnerId,
      };
}

class Address {
  Address({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
  });

  final String street;
  final String city;
  final String state;
  final String country;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json["street"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "city": city,
        "state": state,
        "country": country,
      };
}

class CardFee {
  CardFee({
    required this.mc,
    required this.verve,
    required this.visa,
  });

  final String mc;
  final String verve;
  final String visa;

  factory CardFee.fromJson(Map<String, dynamic> json) => CardFee(
        mc: json["mc"],
        verve: json["verve"],
        visa: json["visa"],
      );

  Map<String, dynamic> toJson() => {
        "mc": mc,
        "verve": verve,
        "visa": visa,
      };
}

class ChannelOptionStatus {
  ChannelOptionStatus({
    required this.name,
    required this.allowOption,
  });

  final String name;
  final bool allowOption;

  factory ChannelOptionStatus.fromJson(Map<String, dynamic> json) =>
      ChannelOptionStatus(
        name: json["name"],
        allowOption: json["allow_option"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "allow_option": allowOption,
      };
}

class CheckoutPageConfig {
  CheckoutPageConfig({
    required this.backgroundColor,
    required this.paybuttonColor,
    required this.paychannelColor,
    required this.checkAdvertStatus,
    required this.maxCheckAdvertCount,
    required this.checkoutAdverts,
  });

  final String backgroundColor;
  final String paybuttonColor;
  final String paychannelColor;
  final String checkAdvertStatus;
  final String maxCheckAdvertCount;
  final List<dynamic> checkoutAdverts;

  factory CheckoutPageConfig.fromJson(Map<String, dynamic> json) =>
      CheckoutPageConfig(
        backgroundColor: json["backgroundColor"],
        paybuttonColor: json["paybuttonColor"],
        paychannelColor: json["paychannelColor"],
        checkAdvertStatus: json["checkAdvertStatus"],
        maxCheckAdvertCount: json["maxCheckAdvertCount"],
        checkoutAdverts:
            List<dynamic>.from(json["checkoutAdverts"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "backgroundColor": backgroundColor,
        "paybuttonColor": paybuttonColor,
        "paychannelColor": paychannelColor,
        "checkAdvertStatus": checkAdvertStatus,
        "maxCheckAdvertCount": maxCheckAdvertCount,
        "checkoutAdverts": List<dynamic>.from(checkoutAdverts.map((x) => x)),
      };
}

class Country {
  Country({
    required this.name,
    required this.nameCode,
    required this.countryCode,
    required this.countryCode2,
    required this.status,
    required this.websiteUrl,
    required this.continent,
    required this.defaultCurrency,
    required this.defaultPaymentOptions,
  });

  final String name;
  final String nameCode;
  final String countryCode;
  final String countryCode2;
  final String status;
  final String websiteUrl;
  final String continent;
  final DefaultCurrency defaultCurrency;
  final List<DefaultPaymentOption> defaultPaymentOptions;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
        name: json["name"],
        nameCode: json["nameCode"],
        countryCode: json["countryCode"],
        countryCode2: json["countryCode2"],
        status: json["status"],
        websiteUrl: json["websiteUrl"],
        continent: json["continent"],
        defaultCurrency: DefaultCurrency.fromJson(json["defaultCurrency"]),
        defaultPaymentOptions: List<DefaultPaymentOption>.from(
            json["defaultPaymentOptions"]
                .map((x) => DefaultPaymentOption.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "nameCode": nameCode,
        "countryCode": countryCode,
        "countryCode2": countryCode2,
        "status": status,
        "websiteUrl": websiteUrl,
        "continent": continent,
        "defaultCurrency": defaultCurrency.toJson(),
        "defaultPaymentOptions":
            List<dynamic>.from(defaultPaymentOptions.map((x) => x.toJson())),
      };
}

class DefaultCurrency {
  DefaultCurrency({
    required this.country,
    required this.currency,
    required this.code,
    required this.number,
  });

  final String country;
  final String currency;
  final String code;
  final String number;

  factory DefaultCurrency.fromJson(Map<String, dynamic> json) =>
      DefaultCurrency(
        country: json["country"],
        currency: json["currency"],
        code: json["code"],
        number: json["number"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
        "currency": currency,
        "code": code,
        "number": number,
      };
}

class DefaultPaymentOption {
  DefaultPaymentOption({
    required this.name,
    required this.viewName,
    required this.code,
    required this.number,
    required this.type,
    required this.description,
    required this.allowOption,
    required this.status,
    required this.paymentOptionFeeMode,
    required this.applyFixCharge,
    required this.paymentOptionFee,
    required this.internationalPaymentOptionFee,
    required this.internationalPaymentOptionMode,
    required this.paymentOptionCapStatus,
    required this.internationalPaymentOptionCapStatus,
    required this.fixCharge,
  });

  final String name;
  final String viewName;
  final String code;
  final String number;
  final String type;
  final String description;
  final bool allowOption;
  final String status;
  final String paymentOptionFeeMode;
  final bool applyFixCharge;
  final String paymentOptionFee;
  final double internationalPaymentOptionFee;
  final String internationalPaymentOptionMode;
  final PaymentOptionCapStatus paymentOptionCapStatus;
  final InternationalPaymentOptionCapStatus internationalPaymentOptionCapStatus;
  final String fixCharge;

  factory DefaultPaymentOption.fromJson(Map<String, dynamic> json) =>
      DefaultPaymentOption(
        name: json["name"],
        viewName: json["viewName"],
        code: json["code"],
        number: json["number"],
        type: json["type"],
        description: json["description"],
        allowOption: json["allow_option"],
        status: json["status"],
        paymentOptionFeeMode: json["paymentOptionFeeMode"],
        applyFixCharge: json["applyFixCharge"],
        paymentOptionFee: json["paymentOptionFee"],
        internationalPaymentOptionFee:
            json["internationalPaymentOptionFee"]?.toDouble(),
        internationalPaymentOptionMode: json["internationalPaymentOptionMode"],
        paymentOptionCapStatus:
            PaymentOptionCapStatus.fromJson(json["paymentOptionCapStatus"]),
        internationalPaymentOptionCapStatus:
            InternationalPaymentOptionCapStatus.fromJson(
                json["internationalPaymentOptionCapStatus"]),
        fixCharge: json["fixCharge"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "viewName": viewName,
        "code": code,
        "number": number,
        "type": type,
        "description": description,
        "allow_option": allowOption,
        "status": status,
        "paymentOptionFeeMode": paymentOptionFeeMode,
        "applyFixCharge": applyFixCharge,
        "paymentOptionFee": paymentOptionFee,
        "internationalPaymentOptionFee": internationalPaymentOptionFee,
        "internationalPaymentOptionMode": internationalPaymentOptionMode,
        "paymentOptionCapStatus": paymentOptionCapStatus.toJson(),
        "internationalPaymentOptionCapStatus":
            internationalPaymentOptionCapStatus.toJson(),
        "fixCharge": fixCharge,
      };
}

class InternationalPaymentOptionCapStatus {
  InternationalPaymentOptionCapStatus({
    required this.inCappedAmount,
  });

  final int inCappedAmount;

  factory InternationalPaymentOptionCapStatus.fromJson(
          Map<String, dynamic> json) =>
      InternationalPaymentOptionCapStatus(
        inCappedAmount: json["inCappedAmount"],
      );

  Map<String, dynamic> toJson() => {
        "inCappedAmount": inCappedAmount,
      };
}

class PaymentOptionCapStatus {
  PaymentOptionCapStatus({
    required this.cappedSettlement,
    required this.cappedAmount,
  });

  final String cappedSettlement;
  final int cappedAmount;

  factory PaymentOptionCapStatus.fromJson(Map<String, dynamic> json) =>
      PaymentOptionCapStatus(
        cappedSettlement: json["cappedSettlement"],
        cappedAmount: json["cappedAmount"],
      );

  Map<String, dynamic> toJson() => {
        "cappedSettlement": cappedSettlement,
        "cappedAmount": cappedAmount,
      };
}

class Setting {
  Setting({
    required this.cardOption,
    required this.bankOption,
    required this.transferOption,
    required this.displayFee,
    required this.emailReceiptCustomer,
    required this.emailReceiptMerchant,
    required this.payday,
    required this.mode,
    required this.chargeOption,
    required this.applySettlementPattern,
  });

  final bool cardOption;
  final bool bankOption;
  final bool transferOption;
  final bool displayFee;
  final bool emailReceiptCustomer;
  final bool emailReceiptMerchant;
  final String payday;
  final String mode;
  final String chargeOption;
  final bool applySettlementPattern;

  factory Setting.fromJson(Map<String, dynamic> json) => Setting(
        cardOption: json["card_option"],
        bankOption: json["bank_option"],
        transferOption: json["transfer_option"],
        displayFee: json["display_fee"],
        emailReceiptCustomer: json["email_receipt_customer"],
        emailReceiptMerchant: json["email_receipt_merchant"],
        payday: json["payday"],
        mode: json["mode"],
        chargeOption: json["charge_option"],
        applySettlementPattern: json["applySettlementPattern"],
      );

  Map<String, dynamic> toJson() => {
        "card_option": cardOption,
        "bank_option": bankOption,
        "transfer_option": transferOption,
        "display_fee": displayFee,
        "email_receipt_customer": emailReceiptCustomer,
        "email_receipt_merchant": emailReceiptMerchant,
        "payday": payday,
        "mode": mode,
        "charge_option": chargeOption,
        "applySettlementPattern": applySettlementPattern,
      };
}

class TransactionFee {
  TransactionFee({
    required this.cardTransactionFee,
    required this.accountTransactionFee,
    required this.defaultFee,
    required this.transactionCapStatus,
  });

  final AccountTransactionFeeClass cardTransactionFee;
  final AccountTransactionFeeClass accountTransactionFee;
  final DefaultFee defaultFee;
  final TransactionCapStatus transactionCapStatus;

  factory TransactionFee.fromJson(Map<String, dynamic> json) => TransactionFee(
        cardTransactionFee:
            AccountTransactionFeeClass.fromJson(json["cardTransactionFee"]),
        accountTransactionFee:
            AccountTransactionFeeClass.fromJson(json["accountTransactionFee"]),
        defaultFee: DefaultFee.fromJson(json["defaultFee"]),
        transactionCapStatus:
            TransactionCapStatus.fromJson(json["transactionCapStatus"]),
      );

  Map<String, dynamic> toJson() => {
        "cardTransactionFee": cardTransactionFee.toJson(),
        "accountTransactionFee": accountTransactionFee.toJson(),
        "defaultFee": defaultFee.toJson(),
        "transactionCapStatus": transactionCapStatus.toJson(),
      };
}

class AccountTransactionFeeClass {
  AccountTransactionFeeClass();

  factory AccountTransactionFeeClass.fromJson(Map<String, dynamic> json) =>
      AccountTransactionFeeClass();

  Map<String, dynamic> toJson() => {};
}

class DefaultFee {
  DefaultFee({
    required this.mccCategory,
    required this.mccPercentage,
  });

  final String mccCategory;
  final String mccPercentage;

  factory DefaultFee.fromJson(Map<String, dynamic> json) => DefaultFee(
        mccCategory: json["mccCategory"],
        mccPercentage: json["mccPercentage"],
      );

  Map<String, dynamic> toJson() => {
        "mccCategory": mccCategory,
        "mccPercentage": mccPercentage,
      };
}

class TransactionCapStatus {
  TransactionCapStatus({
    required this.cappedSettlement,
    required this.cappedAmount,
  });

  final String cappedSettlement;
  final String cappedAmount;

  factory TransactionCapStatus.fromJson(Map<String, dynamic> json) =>
      TransactionCapStatus(
        cappedSettlement: json["cappedSettlement"],
        cappedAmount: json["cappedAmount"],
      );

  Map<String, dynamic> toJson() => {
        "cappedSettlement": cappedSettlement,
        "cappedAmount": cappedAmount,
      };
}
