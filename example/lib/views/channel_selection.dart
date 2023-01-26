import 'package:animate_do/animate_do.dart';
import 'package:example/views/view-notifiers/view_notifier.dart';
import 'package:example/views/widgets/bank_account_channel.dart';
import 'package:example/views/widgets/debit_card/debit_card_channel.dart';
import 'package:example/views/widgets/secured_by_marker.dart';
import 'package:example/views/widgets/transfer_to_bank_channel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'global_components/global_components.dart';

class ChannelSelection extends StatelessWidget {
  const ChannelSelection({super.key});

  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    return SingleChildScrollView(
      child: AnimatedContainer(
        // height: 600.h,
        duration: const Duration(seconds: 1),
        width: 270.w,
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const YSpace(22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/logo.png", height: 50.h, width: 50.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    CustomText("Ollie Ollie",
                        size: 12, weight: FontWeight.bold),
                    YSpace(6),
                    CustomText("olaz@gmail.com", size: 12)
                  ],
                )
              ],
            ),
            FadeInUp(
              key: Key(vn.paymentChannel.toString()),
              child: SizedBox(
                width: double.infinity,
                child: Builder(builder: (context) {
                  switch (vn.paymentChannel) {
                    case PaymentChannel.debitCard:
                      return const DebitCardChannel();
                    case PaymentChannel.bankAccount:
                      return const BankAccountChannel();
                    case PaymentChannel.transfer:
                      return const TransferToBankChannel();
                    default:
                      return const DebitCardChannel();
                  }
                }),
              ),
            ),
            const YSpace(25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: 1, width: 60, color: Colors.grey.shade300),
                const XSpace(10),
                const Text("or pay via"),
                const XSpace(10),
                Container(height: 1, width: 60, color: Colors.grey.shade300),
              ],
            ),
            const YSpace(12),
            Column(
              children: [
                CustomFlatButton(
                    // label: "Transfer",
                    prefix: const CustomText("Transfer",
                        size: 14, weight: FontWeight.bold),
                    alignment: MainAxisAlignment.start,
                    onTap: () =>
                        vn.changePaymentChannel(PaymentChannel.transfer),
                    expand: true,
                    color: Colors.black,
                    bgColor: Colors.grey.shade200),
                const YSpace(4),
                CustomFlatButton(
                    prefix: const CustomText("USSD",
                        size: 14, weight: FontWeight.bold),
                    suffix: const CustomText("*bank ussd code#",
                        size: 14, weight: FontWeight.bold),
                    alignment: MainAxisAlignment.spaceBetween,
                    onTap: () => vn.changePaymentChannel(PaymentChannel.ussd),
                    expand: true,
                    color: Colors.black,
                    bgColor: Colors.grey.shade200),
                const YSpace(4),
                CustomFlatButton(
                    alignment: MainAxisAlignment.start,
                    label: "Bank Account",
                    onTap: () =>
                        vn.changePaymentChannel(PaymentChannel.bankAccount),
                    expand: true,
                    color: Colors.black,
                    bgColor: Colors.grey.shade200),
              ],
            ),
            const YSpace(25),
            const SecuredByMarker(),
            const YSpace(25),
          ],
        ),
      ),
    );
  }
}
