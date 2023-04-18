import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:seerbit_flutter_native/src/models/models.dart';
import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/bank-transfer/controllers/bank_transfer_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/bank-transfer/controllers/bank_transfer_response_model.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';

class BankTransferInfo extends StatelessWidget {
  const BankTransferInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    TransferResponseModel prm = (vn.paymentResponse as TransferResponseModel);
    BankTransferNotifier bn = Provider.of<BankTransferNotifier>(context);
    return Builder(builder: (context) {
      PaymentPayloadModel ppm = vn.paymentPayload!;
      MerchantDetailModel mdm = vn.merchantDetailModel!;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const YSpace(43),
          const CustomText(
            "Transfer the exact amount including decimals",
            size: 14,
            color: Colors.red,
          ),
          const YSpace(34),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w) +
                EdgeInsets.only(top: 5.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.shade300,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                    "NGN ${double.parse(ppm.amount!) + double.parse(vn.calculateFees())}",
                    weight: FontWeight.bold,
                    size: 24),
              ],
            ),
          ),
          const YSpace(12),
          const CustomText("to", size: 14, weight: FontWeight.bold),
          const YSpace(12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            // height: 100.h,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.shade300,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const YSpace(24),
                DetailPair(
                  leading: 'Account Number',
                  trailing: "${prm.data!.payments!.accountNumber!} ",
                  actionWidget: Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                    ),
                    child: GestureDetector(
                      child: const Icon(Icons.copy, size: 15),
                      onTap: () {
                        Clipboard.setData(ClipboardData(
                            text: prm.data!.payments!.accountNumber!));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Account copied!'),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const YSpace(24),
                DetailPair(
                    leading: 'Bank Name',
                    trailing: prm.data!.payments!.bankName!),
                const YSpace(24),
                DetailPair(
                    leading: 'Beneficiary',
                    trailing: prm.data!.payments!.walletName!),
                const YSpace(24),
                const DetailPair(leading: 'Validity', trailing: "30 minutes"),
                const YSpace(24),
              ],
            ),
          ),
          const YSpace(12),
          const CustomText(
            "Account number can only be used once",
            size: 14,
            color: Colors.red,
          ),
          const YSpace(25),
          CustomFlatButton(
              label: "I have completed this bank transfer",
              onTap: () {
                bn.changeView(CurrentCardView.confirmPayment);
              },
              expand: true,
              color: Colors.white,
              bgColor: Colors.black),
          const YSpace(12),
        ],
      );
    });
  }
}

class DetailPair extends StatelessWidget {
  const DetailPair({
    Key? key,
    required this.leading,
    required this.trailing,
    this.actionWidget,
  }) : super(key: key);

  final String leading, trailing;
  final Widget? actionWidget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(leading, size: 14),
        Row(
          children: [
            CustomText(trailing, size: 14),
            if (actionWidget != null) actionWidget!
          ],
        )
      ],
    );
  }
}
