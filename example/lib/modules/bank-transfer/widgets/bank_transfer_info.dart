import 'package:example/modules/-core-global/-core-global.dart';
import 'package:example/modules/bank-transfer/controllers/bank_transfer_response_model.dart';
import 'package:example/modules/view-notifiers/view_notifier.dart';
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
    return Builder(builder: (context) {
      TransferResponseModel prm = (vn.paymentResponse as TransferResponseModel);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const YSpace(25),
          const CustomText("Transfer the exact amount including decimals",
              size: 14, color: Colors.red),
          const YSpace(12),
          Material(
            color: Colors.grey.shade300,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child:
                  CustomText("NGN 101.50", size: 26, weight: FontWeight.w900),
            ),
          ),
          const YSpace(12),
          const CustomText("to", size: 14),
          const YSpace(12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            height: 100.h,
            color: Colors.grey.shade300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _DetailPair(
                    leading: 'Bank Name',
                    trailing: prm.data!.payments!.bankName!),
                _DetailPair(
                    leading: 'Account Number',
                    trailing: prm.data!.payments!.accountNumber!),
                _DetailPair(
                    leading: 'Beneficiary',
                    trailing: prm.data!.payments!.walletName!),
                const _DetailPair(leading: 'Validity', trailing: '30-minutes'),
              ],
            ),
          ),
          const YSpace(15),
          const CustomText("Account number can only be used once",
              size: 12, color: Colors.red),
          const YSpace(12),
          // const YSpace(12),
          CustomFlatButton(
              label: "I have completed this transfer",
              onTap: () {},
              expand: true,
              color: Colors.white,
              bgColor: Colors.black),
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