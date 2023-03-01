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
              size: 12, weight: FontWeight.bold),
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
                          bankCode: vn.banksModel?.data.merchantBanks
                              .firstWhere((e) => e.bankName != _)
                              .bankCode));
                      un.changeView(CurrentCardView.progress);

                      await vn.initiatePayment();
                      if (vn.errorMessage == null) {
                        un.changeView(CurrentCardView.info);
                      } else {
                        un.changeView(CurrentCardView.initializeError);
                      }
                    },
                    items: [
                      ...?vn.banksModel?.data.merchantBanks
                          .map((e) => e.bankName!)
                          .toList()
                    ]);
              }),
        ],
      );
    });
  }
}
