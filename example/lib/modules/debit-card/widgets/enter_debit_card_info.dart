import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:example/models/models.dart';
import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/debit-card/controllers/debit_card_notifier.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
import 'package:example/modules/view-notifiers/view_state.dart';
import 'package:example/modules/widgets/amount_to_pay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class EnterDebitCardInfo extends StatelessWidget {
  EnterDebitCardInfo({
    Key? key,
  }) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    DebitCardNotifier dcn = Provider.of<DebitCardNotifier>(context);
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    return Builder(builder: (context) {
      MerchantDetailModel mdm = vn.merchantDetailModel!;
      PaymentPayloadModel ppm = vn.paymentPayload!;
      return Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AmountToPay(fee: mdm.payload.cardFee.mc!),
            const YSpace(12),
            Visibility(
              visible: vn.errorMessage != null,
              child: GestureDetector(
                onTap: () => vn.setErrorMessage(null),
                child: FadeInUp(
                  key: Key(vn.errorMessage.toString()),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    // height: 35,
                    decoration: BoxDecoration(
                        color: const Color(0xFFFFD6D6),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: const Color(0xFFFF6262))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomText('Transaction Failed',
                                size: 12,
                                color: Color(0xFFCC212D),
                                weight: FontWeight.bold),
                            const YSpace(8),
                            CustomText(vn.errorMessage.toString(),
                                size: 12, color: const Color(0xFFCC212D)),
                          ],
                        ),
                        GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.close,
                              size: 14,
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const YSpace(32),
            CustomTextField(
              initialValue: CreditCardNumberInputFormatter()
                  .formatEditUpdate(TextEditingValue.empty,
                      TextEditingValue(text: ppm.cardNumber.toString()))
                  .text,
              label: "Debit/credit card details",
              hint: "Card number",
              onChanged: (_) {
                vn.setPaymentPayload(
                    ppm.copyWith(cardNumber: _.replaceAll(" ", "")));
              },
              formatter: [CreditCardNumberInputFormatter()],
            ),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    label: "",
                    onChanged: (_) {
                      vn.setPaymentPayload(ppm.copyWith(
                          expiryYear: _.split("/").last,
                          expiryMonth: _.split('/').first));
                    },
                    initialValue: ppm.expiryYear != null
                        ? "${ppm.expiryMonth}/${ppm.expiryYear}"
                        : null,
                    hint: "MM/YY",
                    formatter: [CreditCardExpirationDateFormatter()],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                  ),
                ),
                Expanded(
                    child: CustomTextField(
                  label: "",
                  initialValue: ppm.cvv,
                  hint: "CVV",
                  onChanged: (_) {
                    vn.setPaymentPayload(ppm.copyWith(cvv: _));
                  },
                  formatter: [CreditCardCvcInputFormatter()],
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                )),
              ],
            ),
            const YSpace(20),
            CustomFlatButton(
                label: "PAY NGN ${ppm.amount}",
                prefix: dcn.loading
                    ? LottieBuilder.asset(
                        'assets/loading.json',
                        height: 20,
                      )
                    : null,
                onTap: (_notNullOrEmpty(ppm.cvv, 3) &&
                        _notNullOrEmpty(ppm.cardNumber, 16) &&
                        _notNullOrEmpty(ppm.expiryMonth, 2) &&
                        _notNullOrEmpty(ppm.expiryYear, 2))
                    ? () async {
                        dcn.setLoading(true);
                        await vn.initiatePayment();
                        dcn.setLoading(false);
                        if (vn.errorMessage == null) {
                          dcn.changeView(CurrentCardView.pin);
                        }
                      }
                    : () async {
                        log("message");
                      },
                expand: true,
                color: Colors.white,
                bgColor: (_notNullOrEmpty(ppm.cvv, 3) &&
                        _notNullOrEmpty(ppm.cardNumber, 16) &&
                        _notNullOrEmpty(ppm.expiryMonth, 2) &&
                        _notNullOrEmpty(ppm.expiryYear, 2))
                    ? Colors.black
                    : Colors.grey),
            const YSpace(8),
            Center(
              child: TextButton(
                child: const CustomText("Display Test Cards",
                    size: 12, weight: FontWeight.bold),
                onPressed: () => dcn.changeView(CurrentCardView.testCards),
              ),
            ),
          ],
        ),
      );
    });
  }
}

_notNullOrEmpty(String? _, int length) =>
    (_?.isNotEmpty ?? false) && ((_?.length ?? 0) >= length);
