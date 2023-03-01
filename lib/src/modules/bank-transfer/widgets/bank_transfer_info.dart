import 'package:flutter/material.dart';
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
          const CustomText("Transfer", size: 14),
          const YSpace(34),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.grey.shade300,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const YSpace(12),
                CustomText("NGN ${ppm.amount}",
                    weight: FontWeight.bold, size: 24),
                const YSpace(8),
                CustomText("Fee: NGN${mdm.payload.cardFee.mc}", size: 14),
              ],
            ),
          ),
          const YSpace(34),
          const CustomText("to the account details below", size: 14),
          const YSpace(34),
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
                const YSpace(32),
                _DetailPair(
                    leading: 'Bank Name',
                    trailing: prm.data!.payments!.bankName!),
                const YSpace(24),
                _DetailPair(
                    leading: 'Account Number',
                    trailing: prm.data!.payments!.accountNumber!),
                const YSpace(24),
                _DetailPair(
                    leading: 'Beneficiary',
                    trailing: prm.data!.payments!.walletName!),
                const YSpace(32),
              ],
            ),
          ),
          const YSpace(25),
          CustomFlatButton(
              label: "Complete Transfer",
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

class _DetailPair extends StatelessWidget {
  const _DetailPair({
    Key? key,
    required this.leading,
    required this.trailing,
  }) : super(key: key);

  final String leading, trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [CustomText(leading, size: 14), CustomText(trailing, size: 14)],
    );
  }
}
