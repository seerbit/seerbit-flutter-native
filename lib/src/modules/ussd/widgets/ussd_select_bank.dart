import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/models/models.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/ussd/controllers/ussd_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';
import 'package:seerbit_flutter_native/src/modules/widgets/amount_to_pay.dart';

class UssdSelectBank extends StatelessWidget {
  const UssdSelectBank({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UssdNotifier un = Provider.of<UssdNotifier>(context);
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    return Builder(builder: (context) {
      PaymentPayloadModel ppm = vn.paymentPayload!;
      MerchantDetailModel mdm = vn.merchantDetailModel!;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AmountToPay(fee: mdm.payload.cardFee.mc!),
          const YSpace(24),
          const CustomText("Choose your bank to start this payment",
              size: 12, weight: FontWeight.w500),
          const YSpace(12),
          FutureBuilder(
              future: vn.getBanks(),
              builder: (context, snapshot) {
                if (vn.banksModel == null) const CircularProgressIndicator();
                return CustomDropDown(
                    label: "label",
                    hint: "Select Bank",
                    value: null,
                    onChanged: (_) async {
                      vn.setPaymentPayload(ppm.copyWith(
                          channelType: "ussd",
                          paymentType: "USSD",
                          paymentReference:
                              "ST-1232231${math.Random().nextInt(200000000)}",
                          bankCode: banks.firstWhere(
                              (e) => e["bankName"] == _)["bankCode"]));
                      un.changeView(CurrentCardView.progress);

                      await vn.initiatePayment();
                      if (vn.errorMessage == null) {
                        un.changeView(CurrentCardView.info);
                      } else {
                        un.changeView(CurrentCardView.initializeError);
                      }
                    },
                    items: [...banks.map((e) => e["bankName"]!).toList()]);
              }),
        ],
      );
    });
  }
}

List banks = [
  {"bankCode": '044', "bankName": 'ACCESS BANK PLC', "abb": "ACCESS BANK's"},
  {"bankCode": '063', "bankName": 'ACCESS DIAMOND', "abb": "ACCESS DIAMOND's"},
  {"bankCode": '050', "bankName": 'ECOBANK NIGERIA PLC', "abb": "ECOBANK's"},
  {
    "bankCode": '070',
    "bankName": 'FIDELITY BANK PLC',
    "abb": "FIDELITY BANK's"
  },
  {
    "bankCode": '011',
    "bankName": 'FIRST BANK OF NIGERIA PLC',
    "abb": "FIRST BANK's"
  },
  {
    "bankCode": '214',
    "bankName": 'FIRST CITY MONUMENT BANK PLC',
    "abb": "FCMB's"
  },
  {"bankCode": '058', "bankName": 'Guarantee Trust Bank', "abb": "GTBank's"},
  {"bankCode": '030', "bankName": 'HERITAGE BANK', "abb": "HERITAGE BANK's"},
  {
    "bankCode": '090175',
    "bankName": 'HIGHSTREET MICROFINANCE BANK',
    "abb": "HIGHSTREET's"
  },
  {"bankCode": '082', "bankName": 'KEYSTONE BANK', "abb": "KEYSTONE BANK's"},
  {
    "bankCode": '221',
    "bankName": 'STANBIC IBTC BANK PLC',
    "abb": "STANBIC IBTC's"
  },
  {
    "bankCode": '032',
    "bankName": 'UNION BANK OF NIGERIA PLC',
    "abb": "UNION BANK's"
  },
  {"bankCode": '215', "bankName": 'UNITY BANK PLC', "abb": "UNITY BANK's"},
  {"bankCode": '090110', "bankName": 'VFD MICROFINANCE BANK', "abb": "VFD's"},
  {"bankCode": '035', "bankName": 'WEMA BANK PLC', "abb": "WEMA BANK's"},
  {"bankCode": '057', "bankName": 'Zenith Bank', "abb": "Zenith Bank's"},
  {"bankCode": '322', "bankName": 'Zenith Mobile', "abb": "Zenith Mobile's"}
];
