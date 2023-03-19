import 'package:flutter/material.dart';

class CustomFormButtonStyle {
  static const double fontSize = 16;
  static const FontWeight fontWeight = FontWeight.w500;
  static const double lineHeight = 1.5;
  static const double letterSpacing = -0.16;
  static const Color backgroundColor = Color(0xff356899);
  static const Color textColor = Colors.white;
}

class CustomFormButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final bool isLoading;

  const CustomFormButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.isLoading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 6),
      child: TextButton(
        onPressed: isLoading
            ? null
            : onPressed, // Desabilita o botão se isLoading for true
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: CustomFormButtonStyle.backgroundColor,
        ),
        child: Container(
          width: 327,
          height: 56,
          decoration: BoxDecoration(
            color: CustomFormButtonStyle.backgroundColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    color: CustomFormButtonStyle.textColor,
                  ) // Exibe o spinner se isLoading for true
                : Text(
                    label,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: CustomFormButtonStyle.fontSize,
                      fontWeight: CustomFormButtonStyle.fontWeight,
                      height: CustomFormButtonStyle.lineHeight,
                      letterSpacing: CustomFormButtonStyle.letterSpacing,
                      color: CustomFormButtonStyle.textColor,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
