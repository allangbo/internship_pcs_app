import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:micro_app_publish_curricula/app/components/publish_curricula_first_form.dart';
import 'package:micro_commons/app/components/custom_text_form_field.dart';
import 'package:micro_commons/app/entities/curriculum.dart';
import 'package:validatorless/validatorless.dart';

class ExperienceDialog extends StatefulWidget {
  final void Function(Experience experience) onSave;

  const ExperienceDialog({Key? key, required this.onSave}) : super(key: key);

  @override
  State<ExperienceDialog> createState() => _ExperienceDialogState();
}

class _ExperienceDialogState extends State<ExperienceDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String company;
  late String role;
  late String description;
  late DateTime startedAt;
  late DateTime endedAt;

  final TextEditingController _startedAtController = TextEditingController();
  final TextEditingController _endedAtController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Adicionar Experiência'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFormField(
              label: 'Empresa',
              validator: Validatorless.required(requiredMessage),
              onSaved: (value) {
                company = value!;
              },
              type: TextInputType.text,
            ),
            const SizedBox(height: 16.0),
            CustomTextFormField(
              label: 'Cargo',
              validator: Validatorless.required(requiredMessage),
              onSaved: (value) {
                role = value!;
              },
              type: TextInputType.text,
            ),
            const SizedBox(height: 16.0),
            CustomTextFormField(
              label: 'Descrição',
              validator: Validatorless.required(requiredMessage),
              onSaved: (value) {
                description = value!;
              },
              type: TextInputType.text,
            ),
            const SizedBox(height: 16.0),
            CustomTextFormField(
              label: 'Data de início',
              validator: Validatorless.required(requiredMessage),
              onSaved: (value) {
                startedAt = DateFormat('dd/MM/yyyy').parse(value!);
              },
              controller: _startedAtController,
              readOnly: true,
              type: TextInputType.datetime,
              onTap: () => _selectDate(context, _startedAtController),
            ),
            const SizedBox(height: 16.0),
            CustomTextFormField(
              label: 'Data de término',
              validator: Validatorless.required(requiredMessage),
              onSaved: (value) {
                endedAt = DateFormat('dd/MM/yyyy').parse(value!);
              },
              controller: _endedAtController,
              readOnly: true,
              type: TextInputType.datetime,
              onTap: () => _selectDate(context, _endedAtController),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  widget.onSave(Experience(
                    company: company,
                    role: role,
                    description: description,
                    startedAt: startedAt,
                    endedAt: endedAt,
                  ));
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        ),
      ),
    );
  }
}
