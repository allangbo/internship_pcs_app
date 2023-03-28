import 'package:flutter/material.dart';

class CustomDropdownFormFieldStyles {
  static const double fontSize = 14;
  static const FontWeight fontWeight = FontWeight.w500;
  static const double height = 1.5;
  static const double letterSpacing = -0.14;
  static const Color textColor = Color(0xffafb0b5);
  static const Color borderColor = Color(0xffafb0b5);
  static const String fontFamily = 'Poppins';
}

class CustomDropdownFormField extends StatefulWidget {
  final String? value;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final List<String> items;
  final List<String> itemCaptions;
  final String label;

  const CustomDropdownFormField({
    super.key,
    required this.items,
    required this.itemCaptions,
    required this.label,
    this.validator,
    this.onSaved,
    this.value,
  }) : assert(items.length == itemCaptions.length);

  @override
  State<CustomDropdownFormField> createState() =>
      _CustomDropdownFormFieldState();
}

class _CustomDropdownFormFieldState extends State<CustomDropdownFormField> {
  String? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value ?? widget.items[0];
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _value,
      validator: widget.validator,
      onSaved: widget.onSaved,
      onChanged: (String? newValue) {
        setState(() {
          _value = newValue;
        });
      },
      items: widget.items.asMap().entries.map<DropdownMenuItem<String>>((entry) {
        return DropdownMenuItem<String>(
          value: entry.value,
          child: Text(
            widget.itemCaptions[entry.key],
            style: const TextStyle(
              fontFamily: CustomDropdownFormFieldStyles.fontFamily,
              fontSize: CustomDropdownFormFieldStyles.fontSize,
              fontWeight: CustomDropdownFormFieldStyles.fontWeight,
              height: CustomDropdownFormFieldStyles.height,
              letterSpacing: CustomDropdownFormFieldStyles.letterSpacing,
              color: CustomDropdownFormFieldStyles.textColor,
            ),
          ),
        );
      }).toList(),
      decoration: InputDecoration(
        labelText: widget.label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: CustomDropdownFormFieldStyles.borderColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: CustomDropdownFormFieldStyles.borderColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: CustomDropdownFormFieldStyles.borderColor,
          ),
        ),
        labelStyle: const TextStyle(
          fontFamily: CustomDropdownFormFieldStyles.fontFamily,
          fontSize: CustomDropdownFormFieldStyles.fontSize,
          fontWeight: CustomDropdownFormFieldStyles.fontWeight,
          height: CustomDropdownFormFieldStyles.height,
          letterSpacing: CustomDropdownFormFieldStyles.letterSpacing,
          color: CustomDropdownFormFieldStyles.textColor,
        ),
      ),
    );
  }
}
