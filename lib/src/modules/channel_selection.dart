import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/core/navigator.dart';
import 'package:seerbit_flutter_native/src/models/models.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/bank-account/views/bank_account_channel.dart';
import 'package:seerbit_flutter_native/src/modules/bank-transfer/views/transfer_to_bank_channel.dart';
import 'package:seerbit_flutter_native/src/modules/change_payment_methods.dart';
import 'package:seerbit_flutter_native/src/modules/debit-card/views/debit_card_channel.dart';
import 'package:seerbit_flutter_native/src/modules/momo/views/momo_channel.dart';
import 'package:seerbit_flutter_native/src/modules/payment_success.dart';
import 'package:seerbit_flutter_native/src/modules/ussd/views/ussd_channel.dart';

import 'view-notifiers/view_notifier.dart';

class ChannelSelection extends StatelessWidget {
  const ChannelSelection({super.key});

  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);

    MerchantDetailModel mdm = vn.merchantDetailModel!;
    PaymentPayloadModel ppm = vn.paymentPayload!;
    return SizedBox(
      // height: 800.h,
      child: Builder(
        builder: (context) {
          if (vn.paymentSuccess) {
            return PaymentSuccess(
              onPop: () => Navigate(context).pop(),
              amount: ppm.amount,
              logo: mdm.payload.logo!,
              email: ppm.email!,
              name: "${ppm.firstName} ${ppm.lastName}",
            );
          }
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            height: 800.h,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const YSpace(22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(mdm.payload.logo!,
                          height: 50.h, width: 50.h),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CustomText("${ppm.firstName} ${ppm.lastName}",
                              size: 12, weight: FontWeight.bold),
                          const YSpace(6),
                          CustomText("${ppm.email}", size: 12)
                        ],
                      )
                    ],
                  ),
                  FadeInUp(
                    duration: const Duration(microseconds: 200),
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
                            return const BankTransferChannel();
                          case PaymentChannel.ussd:
                            return const UssdChannel();
                          case PaymentChannel.changePaymentMethod:
                            return const ChangePaymentMethodsView();
                          case PaymentChannel.momo:
                            return const MomoChannel();
                          default:
                            return const DebitCardChannel();
                        }
                      }),
                    ),
                  ),
                  // const Spacer(),
                  const YSpace(50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if ((vn.paymentChannel !=
                          PaymentChannel.changePaymentMethod))
                        Visibility(
                          visible: vn.paymentPayload?.currency != "USD",
                          child: Row(
                            children: [
                              CustomFlatButton(
                                onTap: () {
                                  vn.changePaymentChannel(
                                      PaymentChannel.changePaymentMethod);
                                },
                                label: "Change Payment Method",
                                bgColor: const Color(0xFFF0F0F0),
                                size: Size(190.w, 42),
                              ),
                              const XSpace(3),
                            ],
                          ),
                        ),
                      Expanded(
                        child: CustomFlatButton(
                          onTap: () {
                            Navigate(context).pop();
                          },
                          label: "Cancel Payment",
                          color: const Color(0xFFFF2300),
                          size: Size(
                              vn.paymentChannel ==
                                      PaymentChannel.changePaymentMethod
                                  ? 160
                                  : 130,
                              42),
                          bgColor: const Color(0xFFFF2300).withOpacity(.17),
                        ),
                      ),
                    ],
                  ),
                  const YSpace(24),
                  const YSpace(25),
                  const SecuredByMarker(),
                  const YSpace(25),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
