import 'package:seerbit_flutter_native/src/modules/-core-global/-core-global.dart';
import 'package:seerbit_flutter_native/src/modules/bank-transfer/controllers/bank_transfer_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/bank-transfer/controllers/bank_transfer_response_model.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_notifier.dart';
import 'package:seerbit_flutter_native/src/modules/view-notifiers/view_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class BankTransferInfo extends StatelessWidget {
  const BankTransferInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ViewsNotifier vn = Provider.of<ViewsNotifier>(context);
    TransferResponseModel prm = (vn.paymentResponse as TransferResponseModel);
    BankTransferNotifier bn = Provider.of<BankTransferNotifier>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const YSpace(43),
        const CustomText("Transfer", size: 14),
        const YSpace(34),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.grey.shade300,
          ),
          child: Padding(
            padding: const EdgeInsets.all(18.0) +
                const EdgeInsets.only(left: 10, right: 10),
            child: const CustomText("NGN 101.50",
                size: 24, weight: FontWeight.w900),
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
