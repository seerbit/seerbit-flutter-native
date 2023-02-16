import 'package:example/models/merchant_model.dart';
import 'package:example/models/payment_payload_model.dart';
import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/channel_selection.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:validatorless/validatorless.dart';

class SeerbitCheckout extends StatelessWidget {
  SeerbitCheckout({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    return Builder(builder: (context) {
      MerchantDetailModel? mdm = vn.merchantDetailModel;
      if (mdm == null) {
        return SizedBox(
          height: 812.h,
          width: double.infinity,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      return SingleChildScrollView(
        child: Container(
          height: 812.h,
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          color: Colors.white,
          child: Form(
            key: _formKey,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const YSpace(22),
                Image.asset("assets/logo.png", height: 50.h, width: 50.h),
                const YSpace(12),
                CustomText("${mdm.payload.businessName} Payment Page.",
                    weight: FontWeight.bold, size: 14),
                const YSpace(24),
                Row(
                  children: [
                    Expanded(
                        child: CustomTextField(
                      label: "First Name",
                      inputType: TextInputType.name,
                      validator: Validatorless.required("Field is required"),
                      onChanged: (_) => vn.setPaymentPayload(
                          vn.paymentPayload!.copyWith(firstName: _)),
                    )),
                    const XSpace(10),
                    Expanded(
                        child: CustomTextField(
                      label: "Last Name",
                      inputType: TextInputType.name,
                      validator: Validatorless.required("Field is required"),
                      onChanged: (_) => vn.setPaymentPayload(
                          vn.paymentPayload!.copyWith(lastName: _)),
                    )),
                  ],
                ),
                const YSpace(12),
                CustomTextField(
                  label: "Email",
                  inputType: TextInputType.emailAddress,
                  validator: Validatorless.multiple([
                    Validatorless.email("This is not a valid email"),
                    Validatorless.required("Field is required")
                  ]),
                  onChanged: (_) => vn
                      .setPaymentPayload(vn.paymentPayload!.copyWith(email: _)),
                ),
                const YSpace(12),
                CustomTextField(
                  label: "Phone Number",
                  inputType: TextInputType.phone,
                  validator: Validatorless.required("Field is required"),
                  onChanged: (_) => vn.setPaymentPayload(
                      vn.paymentPayload!.copyWith(mobileNumber: _)),
                ),
                const YSpace(12),
                CustomTextField(
                  label: "Amount to charge",
                  inputType: TextInputType.number,
                  validator: Validatorless.multiple([
                    Validatorless.required("Field is required"),
                    Validatorless.number("Amount needs to be a number")
                  ]),
                  onChanged: (_) => vn.setPaymentPayload(
                      vn.paymentPayload!.copyWith(amount: _)),
                ),
                const YSpace(24),
                CustomFlatButton(
                    label: "Continue to Payment",
                    onTap: () async {
                      if (!_formKey.currentState!.validate()) return;
                      await vn.getBanks();
                      CustomOverlays().showPopup(const ChannelSelection(),
                          popPrevious: true);
                    },
                    color: _validateFields(vn) ? Colors.white54 : Colors.white,
                    bgColor: _validateFields(vn) ? Colors.grey : Colors.black),
                const YSpace(25),
                const SecuredByMarker(),
                const YSpace(25),
              ],
            ),
          ),
        ),
      );
    });
  }
}

_validateFields(ViewsNotifier vn) {
  PaymentPayloadModel? pm = vn.paymentPayload;

  return !((pm?.amount?.isNotEmpty ?? false) &&
      (pm?.firstName?.isNotEmpty ?? false) &&
      (pm?.lastName?.isNotEmpty ?? false) &&
      (pm?.mobileNumber?.isNotEmpty ?? false) &&
      (pm?.email?.isNotEmpty ?? false));
}
