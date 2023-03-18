import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String imageUrl;
  final String label;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.imageUrl,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: ElevatedButton(
        onPressed: onPressed,
        style: CustomButtonStyle.buttonStyle,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: CustomButtonStyle.imageBackgroundColor,
                shape: BoxShape.circle,
                boxShadow: CustomButtonStyle.imageBoxShadow,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: CustomButtonStyle.fontFamily,
                fontSize: CustomButtonStyle.fontSize,
                fontWeight: CustomButtonStyle.fontWeight,
                height: CustomButtonStyle.fontHeight,
                letterSpacing: CustomButtonStyle.letterSpacing,
                color: CustomButtonStyle.fontColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButtonStyle {
  static const String fontFamily = 'Poppins';
  static const FontWeight fontWeight = FontWeight.w500;
  static const double fontHeight = 1.6;
  static const double letterSpacing = -0.13;
  static const Color fontColor = Color(0xff0c0c26);
  static const double fontSize = 14;

  static const Color buttonBackgroundColor = Colors.white;
  static const Color buttonForegroundColor = Color(0xff0c0c26);
  static const List<BoxShadow> buttonBoxShadow = [
    BoxShadow(
      color: Color(0x05000000),
      offset: Offset(0, 4),
      blurRadius: 10,
    ),
  ];
  static final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    foregroundColor: buttonForegroundColor,
    backgroundColor: buttonBackgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shadowColor: const Color(0x05000000),
    elevation: 10,
  );

  static const Color imageBackgroundColor = Colors.white;
  static final List<BoxShadow> imageBoxShadow = [
    const BoxShadow(
      color: Color(0x05000000),
      offset: Offset(0, 4),
      blurRadius: 10,
    ),
  ];
}
