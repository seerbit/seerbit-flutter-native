import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'global_components.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {Key? key,
      required this.label,
      this.validator,
      this.hint,
      this.borderRadius,
      this.onChanged,
      this.formatter,
      this.initialValue,
      this.inputType,
      this.border,
      this.controller})
      : super(key: key);
  final String label;
  final String? hint, initialValue;
  final BorderRadius? borderRadius;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? formatter;
  final TextInputType? inputType;
  final OutlineInputBorder? border;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(label, size: 15, weight: FontWeight.w500),
        const YSpace(10),
        TextFormField(
          controller: controller,
          keyboardType: inputType,
          inputFormatters: formatter,
          initialValue: initialValue,
          validator: validator,
          onChanged: onChanged,
          textAlignVertical: const TextAlignVertical(y: 0.7),
          decoration: InputDecoration(
            hintText: hint,
            isDense: true,
            contentPadding: const EdgeInsets.fromLTRB(10, 15, 10, 12),
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            focusedBorder: border ??
                OutlineInputBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(3),
                    borderSide: const BorderSide(
                        width: .67, color: Color.fromARGB(255, 107, 107, 107))),
            enabledBorder: border ??
                OutlineInputBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(3),
                    borderSide: const BorderSide(
                        width: .67, color: Color.fromARGB(255, 224, 222, 222))),
            border: border ??
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3),
                    borderSide: const BorderSide(
                      color: Color(0xFFCCCCCC),
                      width: .67,
                    )),
          ),
        ),
      ],
    );
  }
}
