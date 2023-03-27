import 'package:flutter/material.dart';
import 'package:micro_commons/app/components/custom_form_button.dart';

class SuccessPageStyle {
  static const Color backgroundColor = Color(0xfffafafd);
  static const Color foregroundColor = Color(0xff0c0c26);
  static const Color buttonColor = Color(0xff222461);

  static const TextStyle headlineStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: -0.42,
    color: foregroundColor,
  );

  static const TextStyle descriptionStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.5,
    letterSpacing: -0.15,
    color: foregroundColor,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.5,
    letterSpacing: -0.48,
    color: Colors.white,
  );
}

class SuccessPage extends StatelessWidget {
  final String title;
  final String returnRoute;
  final String message;
  final String labelActionButton;

  const SuccessPage(
      {Key? key,
      required this.returnRoute,
      required this.title,
      required this.message,
      required this.labelActionButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
        title: Text(
          title,
        ),
        centerTitle: true,
      ),
      backgroundColor: SuccessPageStyle.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Image.asset(
                'packages/micro_app_publish_vacancy/lib/assets/images/publish_vacancy_success.png',
                width: 200,
                height: 200,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text('Sucesso!', style: SuccessPageStyle.headlineStyle),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Text(message,
                  textAlign: TextAlign.center,
                  style: SuccessPageStyle.descriptionStyle),
            ),
            CustomFormButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, returnRoute);
                },
                label: labelActionButton),
          ],
        ),
      ),
    );
  }
}
