import 'package:example/models/models.dart';
import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/debit-card/controllers/debit_card_notifier.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
import 'package:example/modules/view-notifiers/view_state.dart';
import 'package:example/modules/widgets/amount_to_pay.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EnterDebitCardInfo extends StatelessWidget {
  const EnterDebitCardInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DebitCardNotifier dcn = Provider.of<DebitCardNotifier>(context);
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    return Builder(builder: (context) {
      MerchantDetailModel mdm = vn.merchantDetailModel!;
      PaymentPayloadModel ppm = vn.paymentPayload!;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AmountToPay(fee: mdm.payload.cardFee.mc!),
          const YSpace(32),
          const CustomTextField(
              label: "Debit/credit card details", hint: "Card number"),
          Row(
            children: const [
              Expanded(
                child: CustomTextField(
                  label: "",
                  hint: "MM/YY",
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10)),
                ),
              ),
              Expanded(
                  child: CustomTextField(
                label: "",
                hint: "CVV",
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
              )),
            ],
          ),
          const YSpace(20),
          CustomFlatButton(
              label: "PAY NGN ${ppm.amount}",
              onTap: () => dcn.changeView(CurrentCardView.pin),
              expand: true,
              color: Colors.white54,
              bgColor: Colors.grey),
        ],
      );
    });
  }
}
