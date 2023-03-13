import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
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
      child: Form(
          key: _formKey,
          child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Nome da Vaga'),
                    validator: Validatorless.required(requiredMessage),
                    onSaved: (value) {
                      name = value!;
                    }),
                const SizedBox(height: 16.0),
                TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Área Principal'),
                    onSaved: (value) {
                      area = value;
                    }),
                const SizedBox(height: 16.0),
                TextFormField(
                    controller: _openingDateController,
                    decoration: const InputDecoration(
                        labelText: 'Data Abertura',
                        suffixIcon: InkWell(
                          child: Icon(Icons.calendar_today),
                        )),
                    readOnly: true,
                    onTap: () => _selectDate(context, _openingDateController),
                    validator: Validatorless.required(requiredMessage),
                    onSaved: (value) {
                      openingDate = DateFormat('dd/MM/yyyy').parse(value!);
                    },
                    keyboardType: TextInputType.datetime),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _closingDateController,
                  decoration: const InputDecoration(
                      labelText: 'Data Fechamento',
                      suffixIcon: InkWell(
                        child: Icon(Icons.calendar_today),
                      )),
                  readOnly: true,
                  onTap: () => _selectDate(context, _closingDateController),
                  validator: Validatorless.required(requiredMessage),
                  onSaved: (value) {
                    closingDate = DateFormat('dd/MM/yyyy').parse(value!);
                  },
                  keyboardType: TextInputType.datetime,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                    decoration: const InputDecoration(labelText: 'Cidade'),
                    onSaved: (value) {
                      city = value;
                    }),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: _selectedModality,
                  validator: Validatorless.required(requiredMessage),
                  onSaved: (value) {
                    modality = value!;
                  },
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedModality = newValue;
                    });
                  },
                  items: <String>['Remoto', 'Presencial', 'Híbrido']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Modalidade de Estágio',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Bolsa Estágio',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RealInputFormatter(moeda: true),
                    ],
                    onSaved: (value) {
                      scholarship =
                          value != null ? double.tryParse(value) : null;
                    }),
                const SizedBox(height: 16.0),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Benefícios',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                  onSaved: (value) {
                    benefits = value;
                  },
                  keyboardType: TextInputType.multiline,
                ),
              ])),
    );
  }
}
