import 'package:example/global_components/global_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransferToBankChannel extends StatelessWidget {
  const TransferToBankChannel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            child: CustomText("NGN 101.50", size: 26, weight: FontWeight.w900),
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
            children: const [
              _DetailPair(leading: 'Bank Name', trailing: '9SB Payments'),
              _DetailPair(leading: 'Account Number', trailing: '9812381231'),
              _DetailPair(
                  leading: 'Beneficiary', trailing: 'Seerbit Technologies'),
              _DetailPair(leading: 'Account Number', trailing: '9812381231'),
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
            color: Colors.white54,
            bgColor: Colors.grey),
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
      children: [CustomText(leading, size: 12), CustomText(trailing, size: 12)],
    );
  }
}
