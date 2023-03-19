import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:micro_app_publish_vacancy/app/components/custom_dropdown_field.dart';
import 'package:micro_app_publish_vacancy/app/components/custom_text_form_field.dart';
import 'package:validatorless/validatorless.dart';

String requiredMessage = 'Este campo é obrigatório';

class PublishVacancyFirstForm extends StatefulWidget {
  const PublishVacancyFirstForm({Key? key}) : super(key: key);

  @override
  State<PublishVacancyFirstForm> createState() =>
      PublishVacancyFirstFormState();
}

class PublishVacancyFirstFormState extends State<PublishVacancyFirstForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _openingDateController = TextEditingController();
  final TextEditingController _closingDateController = TextEditingController();
  String? _selectedModality;

  late String name;
  late DateTime openingDate;
  late DateTime closingDate;
  late String modality;
  double? scholarship;
  String? city;
  String? area;
  String? benefits;

  Future<void> _selectDate(
      BuildContext context, TextEditingController dateController) async {
    final DateTime? selectedDate = await showDatePicker(
      locale: const Locale('pt', 'BR'),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (selectedDate != null) {
      dateController.text = DateFormat('dd/MM/yyyy').format(selectedDate);
    }
  }

  bool validateForm() {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
    }

    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: [
        const Text(
          "Publicar Vaga",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Torne uma vaga disponível!",
          style: TextStyle(
            fontSize: 18,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 20),
        Form(
            key: _formKey,
            child: ListView(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: [
                  CustomTextFormField(
                    label: 'Nome da Vaga',
                    validator: Validatorless.required(requiredMessage),
                    onSaved: (value) {
                      name = value!;
                    },
                    type: TextInputType.text,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                    label: 'Área Principal',
                    validator: Validatorless.required(requiredMessage),
                    onSaved: (value) {
                      area = value!;
                    },
                    type: TextInputType.text,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                    label: 'Data Abertura',
                    validator: Validatorless.required(requiredMessage),
                    onSaved: (value) {
                      openingDate = DateFormat('dd/MM/yyyy').parse(value!);
                    },
                    controller: _openingDateController,
                    readOnly: true,
                    type: TextInputType.datetime,
                    onTap: () => _selectDate(context, _openingDateController),
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                    label: 'Data Fechamento',
                    validator: Validatorless.required(requiredMessage),
                    onSaved: (value) {
                      closingDate = DateFormat('dd/MM/yyyy').parse(value!);
                    },
                    controller: _closingDateController,
                    readOnly: true,
                    type: TextInputType.datetime,
                    onTap: () => _selectDate(context, _closingDateController),
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                    label: 'Cidade',
                    onSaved: (value) {
                      city = value!;
                    },
                    type: TextInputType.text,
                  ),
                  const SizedBox(height: 16.0),
                  CustomDropdownFormField(
                    items: const ['Remoto', 'Presencial', 'Híbrido'],
                    label: 'Modalidade de Estágio',
                    validator: Validatorless.required(requiredMessage),
                    onSaved: (value) {
                      modality = value!;
                    },
                    value: _selectedModality,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                    label: 'Bolsa Estágio',
                    onSaved: (value) {
                      scholarship =
                          value != null ? double.tryParse(value) : null;
                    },
                    type: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RealInputFormatter(moeda: true),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                      label: 'Benefícios',
                      onSaved: (value) {
                        benefits = value;
                      },
                      type: TextInputType.multiline,
                      maxLines: 3),
                ])),
      ]),
    );
  }
}
