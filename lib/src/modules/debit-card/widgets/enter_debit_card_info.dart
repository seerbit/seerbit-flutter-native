import 'dart:developer';
import 'dart:math' as math;

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:lottie/lottie.dart';
import 'package:pattern_formatter/pattern_formatter.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/models/models.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/debit-card/controllers/debit_card_model.dart';
import 'package:seerbit_flutter_native/src/modules/debit-card/controllers/debit_card_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';
import 'package:seerbit_flutter_native/src/modules/widgets/amount_to_pay.dart';

class EnterDebitCardInfo extends StatefulWidget {
  const EnterDebitCardInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<EnterDebitCardInfo> createState() => _EnterDebitCardInfoState();
}

class _EnterDebitCardInfoState extends State<EnterDebitCardInfo> {
  FocusNode cardFocusNode = FocusNode();
  FocusNode dateFocusNode = FocusNode();
  FocusNode cvvFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    DebitCardNotifier dcn = Provider.of<DebitCardNotifier>(context);
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    return Builder(builder: (context) {
      MerchantDetailModel mdm = vn.merchantDetailModel!;
      PaymentPayloadModel ppm = vn.paymentPayload!;
      return Form(
        child: FocusScope(
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
                    duration: const Duration(microseconds: 200),
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
                              SizedBox(
                                width: 300,
                                child: CustomText(vn.errorMessage.toString(),
                                    size: 12, color: const Color(0xFFCC212D)),
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.close,
                            size: 14,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const YSpace(32),
              CustomTextField(
                focusNode: cardFocusNode,
                initialValue: CreditCardNumberInputFormatter()
                    .formatEditUpdate(TextEditingValue.empty,
                        TextEditingValue(text: ppm.cardNumber.toString()))
                    .text,
                label: "Debit/credit card details",
                hint: "Card Number",
                inputType: TextInputType.number,
                onChanged: (_) {
                  vn.setPaymentPayload(
                      ppm.copyWith(cardNumber: _.replaceAll(" ", "")));
                  if (_.length == 19) {
                    cardFocusNode.unfocus();
                    dateFocusNode.requestFocus();
                  }
                },
                formatter: [
                  CreditCardFormatter(),
                  LengthLimitingTextInputFormatter(19)
                ],
              ),
              const YSpace(8),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: "",
                      focusNode: dateFocusNode,
                      inputType: TextInputType.number,
                      onChanged: (_) {
                        vn.setPaymentPayload(ppm.copyWith(
                            expiryYear: _.split("/").last,
                            expiryMonth: _.split('/').first));
                        if (_.length == 5) {
                          dateFocusNode.unfocus();
                          cvvFocusNode.requestFocus();
                        }
                      },
                      initialValue: ppm.expiryYear != null
                          ? "${ppm.expiryMonth}/${ppm.expiryYear}"
                          : null,
                      hint: "MM/YY",
                      formatter: [CreditCardExpirationDateFormatter()],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(3),
                          bottomLeft: Radius.circular(3)),
                    ),
                  ),
                  Expanded(
                      child: CustomTextField(
                    label: "",
                    focusNode: cvvFocusNode,
                    inputType: TextInputType.number,
                    initialValue: ppm.cvv,
                    hint: "CVV",
                    onChanged: (_) {
                      vn.setPaymentPayload(ppm.copyWith(cvv: _));
                      if (_.length == 3) {
                        cvvFocusNode.unfocus();
                      }
                    },
                    formatter: [CreditCardCvcInputFormatter()],
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(3),
                        bottomRight: Radius.circular(3)),
                  )),
                ],
              ),
              const YSpace(20),
              CustomFlatButton(
                  fsize: 15,
                  spacetop: 3,
                  label: "PAY NGN ${ppm.amount}",
                  prefix: dcn.loading
                      ? LottieBuilder.asset('assets/loading.json', height: 20)
                      : null,
                  onTap: (_notNullOrEmpty(ppm.cvv, 3) &&
                          _notNullOrEmpty(ppm.cardNumber, 16) &&
                          _notNullOrEmpty(ppm.expiryMonth, 2) &&
                          _notNullOrEmpty(ppm.expiryYear, 2))
                      ? () async {
                          vn.setPaymentPayload(ppm.copyWith(
                              paymentType: "CARD",
                              paymentReference:
                                  'SBT-T54267${math.Random().nextInt(29091020)}101122472'));
                          dcn.setLoading(true);
                          await vn.initiatePayment();
                          dcn.setLoading(false);
                          if (vn.errorMessage == null) {
                            if ((vn.paymentResponse as DebitCardResponseModel)
                                    .data
                                    ?.payments
                                    ?.redirectUrl !=
                                null) {
                              dcn.changeView(CurrentCardView.redirect);
                            } else {
                              dcn.changeView(CurrentCardView.pin);
                            }
                          }
                        }
                      : () async {
                          log("message");
                        },
                  expand: true,
                  color: const Color.fromARGB(255, 218, 218, 218),
                  bgColor: (_notNullOrEmpty(ppm.cvv, 3) &&
                          _notNullOrEmpty(ppm.cardNumber, 16) &&
                          _notNullOrEmpty(ppm.expiryMonth, 2) &&
                          _notNullOrEmpty(ppm.expiryYear, 2))
                      ? Colors.black
                      : const Color.fromARGB(255, 107, 107, 107)),
              const YSpace(8),
              if (!vn.isReleaseMode)
                Center(
                  child: TextButton(
                    child: const CustomText("Display Test Cards",
                        size: 12, weight: FontWeight.w500),
                    onPressed: () => dcn.changeView(CurrentCardView.testCards),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}

_notNullOrEmpty(String? _, int length) =>
    (_?.isNotEmpty ?? false) && ((_?.length ?? 0) >= length);
