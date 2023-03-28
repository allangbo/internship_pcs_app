import 'package:flutter/material.dart';
import 'package:micro_commons/app/components/custom_text_form_field.dart';
import 'package:validatorless/validatorless.dart';

String requiredMessage = 'Este campo é obrigatório';

class PublishVacancySecondForm extends StatefulWidget {
  const PublishVacancySecondForm({Key? key}) : super(key: key);

  @override
  State<PublishVacancySecondForm> createState() =>
      PublishVacancySecondFormState();
}

class PublishVacancySecondFormState extends State<PublishVacancySecondForm> {
  final _formKey = GlobalKey<FormState>();

  late String description;

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
              CustomTextFormField(
                  label: 'Descrição da Vaga',
                  validator: Validatorless.required(requiredMessage),
                  onSaved: (value) {
                    description = value!;
                  },
                  type: TextInputType.multiline,
                  maxLines: 3),
            ]),
      ),
    );
  }
}
