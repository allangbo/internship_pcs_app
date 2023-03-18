import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum FieldType { date, number, text }

class CustomTextFormFieldStyles {
  static const double fontSize = 14;
  static const FontWeight fontWeight = FontWeight.w500;
  static const double height = 1.5;
  static const double letterSpacing = -0.14;
  static const Color textColor = Color(0xffafb0b5);
  static const Color borderColor = Color(0xffafb0b5);
  static const String fontFamily = 'Poppins';
}

class CustomTextFormField extends StatelessWidget {
  final String label;
  final TextInputType type;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final bool readOnly;
  final void Function()? onTap;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;

  const CustomTextFormField(
      {super.key,
      required this.label,
      required this.type,
      this.validator,
      this.onSaved,
      this.controller,
      this.readOnly = false,
      this.onTap,
      this.inputFormatters,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      readOnly: readOnly,
      decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: CustomTextFormFieldStyles.borderColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: CustomTextFormFieldStyles.borderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: CustomTextFormFieldStyles.borderColor,
            ),
          ),
          labelStyle: const TextStyle(
            fontFamily: CustomTextFormFieldStyles.fontFamily,
            fontSize: CustomTextFormFieldStyles.fontSize,
            fontWeight: CustomTextFormFieldStyles.fontWeight,
            height: CustomTextFormFieldStyles.height,
            letterSpacing: CustomTextFormFieldStyles.letterSpacing,
            color: CustomTextFormFieldStyles.textColor,
          ),
          suffixIcon: type == TextInputType.datetime
              ? const InkWell(
                  child: Icon(Icons.calendar_today),
                )
              : null),
      validator: validator,
      onSaved: onSaved,
      keyboardType: type,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
    );
  }
}
