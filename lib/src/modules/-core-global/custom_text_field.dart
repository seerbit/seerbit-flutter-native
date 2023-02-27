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
      this.border})
      : super(key: key);
  final String label;
  final String? hint, initialValue;
  final BorderRadius? borderRadius;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? formatter;
  final TextInputType? inputType;
  final OutlineInputBorder? border;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(label, size: 12, weight: FontWeight.bold),
        const YSpace(5),
        TextFormField(
          keyboardType: inputType,
          inputFormatters: formatter,
          initialValue: initialValue,
          validator: validator,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            enabledBorder: border ??
                OutlineInputBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(6),
                    borderSide: const BorderSide(
                        color: Color.fromARGB(255, 224, 222, 222))),
            border: border ??
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                    borderSide: const BorderSide(color: Color(0xFFCCCCCC))),

            // label: CustomText(label, size: 14),
          ),
        ),
      ],
    );
  }
}
