import 'package:example/models/merchant_model.dart';
import 'package:example/modules/-core-global/custom_over_lay.dart';
import 'package:example/modules/-core-global/secured_by_marker.dart';
import 'package:example/modules/channel_selection.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '-core-global/global_components.dart';

class SeerbitCheckout extends StatelessWidget {
  SeerbitCheckout({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    return Builder(builder: (context) {
      MerchantDetailModel mdm = vn.merchantDetailModel!;
      return SingleChildScrollView(
        child: Container(
          // width: 270.w,
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          color: Colors.white,
          child: Form(
            key: _formKey,
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
                      onChanged: (_) => vn.setPaymentPayload(
                          vn.paymentPayload!.copyWith(firstName: _)),
                    )),
                    const XSpace(10),
                    Expanded(
                        child: CustomTextField(
                      label: "Last Name",
                      onChanged: (_) => vn.setPaymentPayload(
                          vn.paymentPayload!.copyWith(lastName: _)),
                    )),
                  ],
                ),
                const YSpace(12),
                CustomTextField(
                  label: "Email",
                  onChanged: (_) => vn
                      .setPaymentPayload(vn.paymentPayload!.copyWith(email: _)),
                ),
                const YSpace(12),
                CustomTextField(
                  label: "Phone Number",
                  onChanged: (_) => vn.setPaymentPayload(
                      vn.paymentPayload!.copyWith(mobileNumber: _)),
                ),
                const YSpace(12),
                CustomTextField(
                  label: "Amount to charge",
                  validator: (_) {
                    return null;
                  },
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
                    color: Colors.white54,
                    bgColor: Colors.grey),
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
