import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

String requiredMessage = 'Este campo é obrigatório';

class PublishVacancyThirdForm extends StatefulWidget {
  const PublishVacancyThirdForm({super.key});

  @override
  State<PublishVacancyThirdForm> createState() =>
      PublishVacancyThirdFormState();
}

class PublishVacancyThirdFormState extends State<PublishVacancyThirdForm> {
  final _formKey = GlobalKey<FormState>();

  late String requirements;

  bool validateForm() {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Requisitos da Vaga',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onSaved: (value) {
                  requirements = value!;
                },
                keyboardType: TextInputType.multiline,
                validator: Validatorless.required(requiredMessage),
              ),
            ]),
      ),
    );
  }
}
