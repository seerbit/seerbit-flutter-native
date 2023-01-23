import 'package:example/global_components/box_sizing.dart';
import 'package:example/global_components/custom_flat_button.dart';
import 'package:example/global_components/custom_text.dart';
import 'package:example/global_components/custom_text_field.dart';
import 'package:example/views/channel_selection.dart';
import 'package:example/views/widgets/custom_over_lay.dart';
import 'package:example/views/widgets/secured_by_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SeerbitCheckout extends StatelessWidget {
  const SeerbitCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        // height: 600.h,
        width: 270.w,
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const YSpace(22),
            Image.asset("assets/logo.png", height: 50.h, width: 50.h),
            const YSpace(12),
            const CustomText("Centric Gateway ltd Payment Page.",
                weight: FontWeight.bold, size: 14),
            const YSpace(24),
            Row(
              children: const [
                Expanded(child: CustomTextField(label: "First Name")),
                XSpace(10),
                Expanded(child: CustomTextField(label: "Last Name")),
              ],
            ),
            const YSpace(12),
            const CustomTextField(label: "Email"),
            const YSpace(12),
            const CustomTextField(label: "Phone Number"),
            const YSpace(12),
            const CustomTextField(label: "Amount to charge"),
            const YSpace(24),
            CustomFlatButton(
                label: "Continue to Payment",
                onTap: () {
                  CustomOverlays()
                      .showPopup(const ChannelSelection(), popPrevious: true);
                },
                color: Colors.white54,
                bgColor: Colors.grey),
            const YSpace(25),
            const SecuredByMarker(),
            const YSpace(25),
          ],
        ),
      ),
    );
  }
}
