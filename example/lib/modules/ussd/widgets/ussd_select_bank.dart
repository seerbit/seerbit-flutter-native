import 'package:example/models/models.dart';
import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/ussd/controllers/ussd_notifier.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
import 'package:example/modules/view-notifiers/view_state.dart';
import 'package:example/modules/widgets/amount_to_pay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          AmountToPay(
            fee: mdm.payload.cardFee.mc!,
          ),
          const YSpace(24),
          const CustomText("Choose your bank to start this payment",
              size: 12, weight: FontWeight.bold),
          const YSpace(12),
          CustomDropDown(
              label: "label",
              hint: "Select Bank",
              value: null,
              onChanged: (_) async {
                vn.setPaymentPayload(ppm.copyWith(
                    channelType: "ussd",
                    paymentType: "USSD",
                    bankCode: vn.banksModel?.data.merchantBanks
                        .firstWhere((e) => e.bankName != _)
                        .bankCode));
                un.changeView(CurrentCardView.progress);
                await vn.initiatePayment();
                un.changeView(CurrentCardView.info);
              },
              items: [
                ...?vn.banksModel?.data.merchantBanks
                    .map((e) => e.bankName!)
                    .toList()
              ]),
        ],
      );
    });
  }
}
