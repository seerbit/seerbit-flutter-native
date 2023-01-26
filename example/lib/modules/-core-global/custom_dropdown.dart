import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'global_components.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown(
      {Key? key,
      required this.label,
      this.initialValue,
      required this.hint,
      required this.value,
      this.onChanged,
      this.validator,
      required this.items})
      : super(key: key);
  final String label, hint;
  final String? initialValue, value;
  final List<String> items;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // height: 50.h,
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFCCCCCC)),
              borderRadius: BorderRadius.circular(6)),
          child: DropdownButtonHideUnderline(
            child: DropdownButtonFormField(
                validator: (value) {
                  if (value == null) return "This is required";
                  return null;
                },
                decoration: const InputDecoration(
                    hintStyle: TextStyle(),
                    labelStyle: TextStyle(),
                    // label: CustomText(label, size: 12),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent))),
                value: value,
                style: const TextStyle(color: Colors.black, fontSize: 11),
                hint: Padding(
                  padding: EdgeInsets.only(left: 16.w),
                  child:
                      CustomText(hint, size: 12, color: Colors.grey.shade500),
                ),
                items: items
                    .map((e) => DropdownMenuItem(
                        value: e,
                        child: Padding(
                            padding: EdgeInsets.only(left: 16.w),
                            child: CustomText(e, size: 12))))
                    .toList(),
                icon: Padding(
                    padding: EdgeInsets.only(right: 10.w),
                    child: const Icon(Icons.keyboard_arrow_down)),
                onChanged: (_) {
                  if (onChanged != null) {
                    onChanged!(_.toString());
                  }
                }),
          ),
        ),
      ],
    );
  }
}
