import 'dart:developer';
import 'dart:math' as math;

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:lottie/lottie.dart';
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
  int characterLimit = 19;

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
                          const Icon(Icons.close, size: 14)
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
                  setState(() {
                    characterLimit = getCreditCardLength(_) +
                        (((getCreditCardLength(_) / 4) - 1).ceil());
                  });
                  print(characterLimit);
                  if (_.length == characterLimit) {
                    cardFocusNode.unfocus();
                    dateFocusNode.requestFocus();
                  }
                },
                formatter: [
                  FourDigitTextInputFormatter(),
                  LengthLimitingTextInputFormatter(characterLimit)
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
                  label:
                      "PAY NGN ${double.parse(ppm.amount!) + double.parse(vn.calculateFees())}",
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
                          await vn.getCardBin(ppm.cardNumber!.substring(0, 6));

                          if (vn.isCardLocal != "INTERNATIONAL") {
                            await vn.initiatePayment();
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
                          } else {
                            dcn.changeView(CurrentCardView.address);
                          }
                          dcn.setLoading(false);
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

int getCreditCardLength(String value) {
  int cardLength = 16;
  String firstSixDigits = value.replaceAll(" ", "");
  List bucket_19_1 = [19];
  List bucket_14_3 = [300, 301, 302, 303, 304, 305];
  List bucket_14_2 = [36];
  List bucket_15_2 = [34, 37];
  List bucket_19_2 = [50];
  List bucket_16_2 = [54, 55, 65, 51];
  List bucket_16_4 = [
    6011,
    ...List.generate(3590 - 3528, (index) => 3590 + index),
    6304,
    6706,
    6771,
    6709,
    6759,
    6761,
    6763,
    6762
  ];
  List bucket_16_6 = [
    ...List.generate(622926 - 622126, (index) => 622126 + index)
  ];
  List bucket_16_3 = [637, 638, 639, 644, 645, 646, 647, 648, 649];

  List bucket_19_4 = [5018, 5018, 5020, 5038];
  if (firstSixDigits.isNotEmpty) {
    if (bucket_19_1.contains(int.parse(firstSixDigits.substring(0, 1)))) {
      cardLength = 19;
    }
  }
  if (firstSixDigits.length > 2) {
    if (bucket_19_2.contains(int.parse(firstSixDigits.substring(0, 2)))) {
      cardLength = 19;
    }
    if (bucket_14_2.contains(int.parse(firstSixDigits.substring(0, 2)))) {
      cardLength = 14;
    }
    if (bucket_15_2.contains(int.parse(firstSixDigits.substring(0, 2)))) {
      cardLength = 15;
    }
    if (bucket_16_2.contains(int.parse(firstSixDigits.substring(0, 2)))) {
      cardLength = 16;
    }
  }
  if (firstSixDigits.length > 3) {
    if (bucket_14_3.contains(int.parse(firstSixDigits.substring(0, 3)))) {
      cardLength = 14;
    }

    if (bucket_16_3.contains(int.parse(firstSixDigits.substring(0, 3)))) {
      cardLength = 16;
    }
  }
  if (firstSixDigits.length > 4) {
    if (bucket_16_4.contains(int.parse(firstSixDigits.substring(0, 4)))) {
      cardLength = 16;
    }
    if (bucket_19_4.contains(int.parse(firstSixDigits.substring(0, 4)))) {
      cardLength = 19;
    }
  }
  if (firstSixDigits.length > 6) {
    if (bucket_16_6.contains(int.parse(firstSixDigits.substring(0, 6)))) {
      cardLength = 16;
    }
  }

  return cardLength;
}

class FourDigitTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String text = newValue.text.replaceAll(' ', '');
    String formattedText = '';

    for (int i = 0; i < text.length; i += 4) {
      int endIndex = i + 4;
      if (endIndex > text.length) {
        endIndex = text.length;
      }

      String segment = text.substring(i, endIndex);
      formattedText += segment;

      if (endIndex < text.length) {
        formattedText += ' ';
      }
    }

    return newValue.copyWith(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
