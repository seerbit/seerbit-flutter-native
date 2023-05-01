import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/models/models.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/debit-card/controllers/debit_card_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';
import 'package:seerbit_flutter_native/src/modules/widgets/amount_to_pay.dart';
import 'package:validatorless/validatorless.dart';

import '../controllers/debit_card_model.dart';

class DebitAddress extends StatefulWidget {
  const DebitAddress({super.key});

  @override
  State<DebitAddress> createState() => _DebitAddressState();
}

class _DebitAddressState extends State<DebitAddress> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    DebitCardNotifier dcn = Provider.of<DebitCardNotifier>(context);
    return Builder(builder: (context) {
      PaymentPayloadModel ppm = vn.paymentPayload!;
      MerchantDetailModel mdm = vn.merchantDetailModel!;
      return Form(
        key: _formKey,
        child: Column(
          children: [
            AmountToPay(fee: mdm.payload.cardFee.mc!),
            const YSpace(12),
            const CustomText(
              'Address Verification',
              align: TextAlign.center,
              height: 1.5,
              size: 16,
              weight: FontWeight.bold,
            ),
            const YSpace(16),
            CustomTextField(
              label: "Address",
              validator: Validatorless.required("Field is required"),
              onChanged: (_) =>
                  vn.setPaymentPayload(vn.paymentPayload!.copyWith(address: _)),
            ),
            const YSpace(12),
            CustomTextField(
              label: "City",
              validator: Validatorless.required("Field is required"),
              onChanged: (_) =>
                  vn.setPaymentPayload(vn.paymentPayload!.copyWith(city: _)),
            ),
            const YSpace(12),
            CustomTextField(
              label: "State",
              validator: Validatorless.required("Field is required"),
              onChanged: (_) =>
                  vn.setPaymentPayload(vn.paymentPayload!.copyWith(state: _)),
            ),
            const YSpace(12),
            CustomTextField(
              label: "Post Code",
              validator: Validatorless.required("Field is required"),
              onChanged: (_) => vn.setPaymentPayload(
                  vn.paymentPayload!.copyWith(postalCode: _)),
            ),
            const YSpace(12),
            CustomFlatButton(
              bgColor: Colors.black,
              color: Colors.white,
              prefix: dcn.loading
                  ? LottieBuilder.asset('assets/loading.json', height: 20)
                  : null,
              onTap: () async {
                if (!_formKey.currentState!.validate()) {
                  return;
                }
                dcn.setLoading(true);
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
                dcn.setLoading(false);
              },
              label: "Proceed to payment",
            ),
            const YSpace(12),
          ],
        ),
      );
    });
  }
}