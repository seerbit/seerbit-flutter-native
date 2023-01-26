
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'global_components.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key, required this.label, this.hint, this.borderRadius})
      : super(key: key);
  final String label;
  final String? hint;
  final BorderRadius? borderRadius;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(label, size: 12, weight: FontWeight.bold),
        const YSpace(5),
        SizedBox(
          width: 375.w,
          height: 38.h,
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey.shade400),
              enabledBorder: OutlineInputBorder(
                  borderRadius: borderRadius ?? BorderRadius.circular(6),
                  borderSide: const BorderSide(
                      color: Color.fromARGB(255, 224, 222, 222))),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFFCCCCCC))),

              // label: CustomText(label, size: 14),
            ),
          ),
        ),
      ],
    );
  }
}