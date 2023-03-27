import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:micro_app_publish_curricula/app/components/publish_curricula_first_form.dart';
import 'package:micro_commons/app/components/custom_text_form_field.dart';
import 'package:micro_commons/app/entities/curriculum.dart';
import 'package:validatorless/validatorless.dart';

class ActivityDialog extends StatefulWidget {
  final Function(Activity activity) onSave;

  const ActivityDialog({Key? key, required this.onSave}) : super(key: key);

  @override
  State<ActivityDialog> createState() => _ActivityDialogState();
}

class _ActivityDialogState extends State<ActivityDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late String name;
  late String description;
  late DateTime completedAt;
  late DateTime expiresAt;

  final TextEditingController _completedAtController = TextEditingController();
  final TextEditingController _expiresAtController = TextEditingController();

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
      title: const Text('Adicionar Atividade/Certificado'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFormField(
              label: 'Nome',
              validator: Validatorless.required(requiredMessage),
              onSaved: (value) {
                name = value!;
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
              label: 'Data de conclusão',
              validator: Validatorless.required(requiredMessage),
              onSaved: (value) {
                completedAt = DateFormat('dd/MM/yyyy').parse(value!);
              },
              controller: _completedAtController,
              readOnly: true,
              type: TextInputType.datetime,
              onTap: () => _selectDate(context, _completedAtController),
            ),
            const SizedBox(height: 16.0),
            CustomTextFormField(
              label: 'Data de expiração',
              validator: Validatorless.required(requiredMessage),
              onSaved: (value) {
                expiresAt = DateFormat('dd/MM/yyyy').parse(value!);
              },
              controller: _expiresAtController,
              readOnly: true,
              type: TextInputType.datetime,
              onTap: () => _selectDate(context, _expiresAtController),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  widget.onSave(Activity(
                    name: name,
                    description: description,
                    completedAt: completedAt,
                    expiresAt: expiresAt,
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
