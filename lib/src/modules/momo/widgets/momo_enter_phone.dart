import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/models/models.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/momo/controllers/momo_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/momo/controllers/momo_response_model.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';
import 'package:seerbit_flutter_native/src/modules/widgets/amount_to_pay.dart';

class MomoEnterPhone extends StatefulWidget {
  const MomoEnterPhone({
    Key? key,
  }) : super(key: key);

  @override
  State<MomoEnterPhone> createState() => _MomoEnterPhoneState();
}

class _MomoEnterPhoneState extends State<MomoEnterPhone> {
  late Future getNetworks;
  @override
  void initState() {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context, listen: false);
    getNetworks = vn.getMomoNetworks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MomoNotifier mn = Provider.of<MomoNotifier>(context);
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
                            CustomText(vn.errorMessage.toString(),
                                size: 12, color: const Color(0xFFCC212D)),
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
            const CustomText("Choose your network to start this payment",
                size: 15, weight: FontWeight.w500),
            const YSpace(10),
            FutureBuilder(
                future: getNetworks,
                builder: (context, snapshot) {
                  return CustomDropDown(
                    label: "",
                    hint: "Select Mobile Network Operator",
                    onChanged: (_) {
                      vn.setPaymentPayload(ppm.copyWith(network: _));
                    },
                    value: null,
                    items: [...?vn.momoNetworks?.map((e) => e.networks!)],
                  );
                }),
            const YSpace(0),
            CustomTextField(
              label: "",
              hint: "0 500 000",
              inputType: TextInputType.number,
              onChanged: (_) {
                vn.setPaymentPayload(
                  ppm.copyWith(
                      mobileNumber: _.replaceAll(RegExp("[^0-9]+"), "")),
                );
              },
              formatter: [
                // PhoneInputFormatter(),
                LengthLimitingTextInputFormatter(19),
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            const YSpace(20),
            CustomFlatButton(
                fsize: 15,
                spacetop: 3,
                label: "Continue",
                prefix: mn.loading
                    ? LottieBuilder.asset(
                        'packages/seerbit_flutter_native/assets/loading.json',
                        height: 20)
                    : null,
                onTap: _notNullOrEmpty(ppm.network, 1) &&
                        _notNullOrEmpty(ppm.mobileNumber, 10)
                    ? () async {
                        // mn.changeView(CurrentCardView.pin);
                        vn.setPaymentPayload(ppm.copyWith(
                            paymentType: "MOMO",
                            channelType: "wallet",
                            paymentReference:
                                'SBT-T54267${Random().nextInt(29091020)}101122472'));
                        mn.setLoading(true);
                        await vn.initiatePayment();
                        mn.setLoading(false);
                        if (vn.errorMessage == null) {
                          if ((vn.paymentResponse as MomoResponseModel)
                                  .data
                                  ?.code ==
                              "INP") {
                            mn.changeView(CurrentCardView.otp);
                          } else {
                            mn.changeView(CurrentCardView.loading);
                          }
                        }
                      }
                    : () async {
                        // log("message");
                      },
                expand: true,
                color: const Color.fromARGB(255, 218, 218, 218),
                bgColor: _notNullOrEmpty(ppm.network, 1) &&
                        _notNullOrEmpty(ppm.mobileNumber, 10)
                    ? Colors.black
                    : const Color.fromARGB(255, 107, 107, 107)),
            const YSpace(8),
          ],
        ),
      );
    });
  }
}

_notNullOrEmpty(String? _, int length) =>
    (_?.isNotEmpty ?? false) && ((_?.length ?? 0) >= length);
