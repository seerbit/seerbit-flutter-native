import 'package:example/models/models.dart';
import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/bank-transfer/controllers/bank_transfer_notifier.dart';
import 'package:example/modules/debit-card/controllers/debit_card_notifier.dart';
import 'package:example/modules/ussd/controllers/ussd_notifier.dart';
import 'package:example/modules/view-notifiers/view_state.dart';
import 'package:example/modules/widgets/amount_to_pay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'view-notifiers/view_notifier.dart';

class ChangePaymentMethodsView extends StatelessWidget {
  const ChangePaymentMethodsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    BankTransferNotifier bn = Provider.of<BankTransferNotifier>(context);
    UssdNotifier un = Provider.of<UssdNotifier>(context);
    DebitCardNotifier dcn = Provider.of<DebitCardNotifier>(context);
    return Builder(builder: (context) {
      MerchantDetailModel mdm = vn.merchantDetailModel!;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const YSpace(40),
          AmountToPay(fee: mdm.payload.cardFee.mc!),
          const YSpace(40),
          const CustomText("Other Payment Channels", size: 14),
          const YSpace(24),
          Visibility(
            visible: vn.isChannelActive(PaymentChannel.transfer),
            child: CustomFlatButton(
                prefix: const CustomText("Transfer", size: 14),
                alignment: MainAxisAlignment.start,
                onTap: () async => {
                      bn.changeView(CurrentCardView.loading),
                      vn.changePaymentChannel(PaymentChannel.transfer),
                    },
                expand: true,
                color: Colors.black,
                bgColor: Colors.grey.shade200),
          ),
          const YSpace(4),
          Visibility(
            visible: vn.isChannelActive(PaymentChannel.ussd),
            child: CustomFlatButton(
                prefix: const CustomText("USSD", size: 14),
                suffix: const CustomText("*bank ussd code#", size: 14),
                alignment: MainAxisAlignment.spaceBetween,
                onTap: () async => {
                      un.changeView(CurrentCardView.select),
                      vn.changePaymentChannel(PaymentChannel.ussd),
                    },
                expand: true,
                color: Colors.black,
                bgColor: Colors.grey.shade200),
          ),
          const YSpace(10),
          Visibility(
            visible: vn.isChannelActive(PaymentChannel.bankAccount),
            child: CustomFlatButton(
                alignment: MainAxisAlignment.start,
                label: "Bank Account",
                onTap: () =>
                    vn.changePaymentChannel(PaymentChannel.bankAccount),
                expand: true,
                color: Colors.black,
                bgColor: Colors.grey.shade200),
          ),
          const YSpace(10),
          Visibility(
            visible: vn.isChannelActive(PaymentChannel.debitCard),
            child: CustomFlatButton(
                prefix: const CustomText("Debit Card", size: 14),
                alignment: MainAxisAlignment.start,
                onTap: () => {
                      dcn.changeView(CurrentCardView.info),
                      vn.changePaymentChannel(PaymentChannel.debitCard),
                    },
                expand: true,
                color: Colors.black,
                bgColor: Colors.grey.shade200),
          ),
          const YSpace(42),
        ],
      );
    });
  }
}
