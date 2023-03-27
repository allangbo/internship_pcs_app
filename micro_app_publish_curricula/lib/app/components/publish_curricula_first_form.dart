import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:micro_app_publish_curricula/app/components/activity_dialog.dart';
import 'package:micro_app_publish_curricula/app/components/experience_dialog.dart';
import 'package:micro_commons/app/components/custom_list_title.dart';
import 'package:micro_commons/app/components/custom_text_form_field.dart';
import 'package:micro_commons/app/entities/curriculum.dart';
import 'package:validatorless/validatorless.dart';

String requiredMessage = 'Este campo é obrigatório';

class PublishCurriculaFirstForm extends StatefulWidget {
  const PublishCurriculaFirstForm({Key? key}) : super(key: key);

  @override
  State<PublishCurriculaFirstForm> createState() =>
      PublishCurriculaFirstFormState();
}

class PublishCurriculaFirstFormState extends State<PublishCurriculaFirstForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _graduationYearController =
      TextEditingController();

  late String name;
  late String lastName;
  late String degreeCourse;
  late DateTime graduationYear;
  List<Experience> pastExperiences = [];
  List<Activity> certificates = [];

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

  void _addExperience() {
    showDialog(
        context: context,
        builder: (context) {
          return ExperienceDialog(
            onSave: (Experience experience) {
              setState(() {
                pastExperiences.add(experience);
              });
              Navigator.pop(context);
            },
          );
        });
  }

  void _removeExperience(int index) {
    setState(() {
      pastExperiences.removeAt(index);
    });
  }

  void _addActivity() {
    showDialog(
        context: context,
        builder: (context) {
          return ActivityDialog(
            onSave: (Activity activity) {
              setState(() {
                certificates.add(activity);
              });
              Navigator.pop(context);
            },
          );
        });
  }

  void _removeActivity(int index) {
    setState(() {
      certificates.removeAt(index);
    });
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
          "Publicar Currículo",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "Disponibilize seu currículo!",
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
                    label: 'Nome',
                    validator: Validatorless.required(requiredMessage),
                    onSaved: (value) {
                      name = value!;
                    },
                    type: TextInputType.text,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                    label: 'Sobrenome',
                    validator: Validatorless.required(requiredMessage),
                    onSaved: (value) {
                      lastName = value!;
                    },
                    type: TextInputType.text,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                    label: 'Curso de Graduação',
                    validator: Validatorless.required(requiredMessage),
                    onSaved: (value) {
                      degreeCourse = value!;
                    },
                    type: TextInputType.text,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                    label: 'Ano de Graduação',
                    validator: Validatorless.required(requiredMessage),
                    onSaved: (value) {
                      graduationYear = DateFormat('dd/MM/yyyy').parse(value!);
                    },
                    controller: _graduationYearController,
                    readOnly: true,
                    type: TextInputType.datetime,
                    onTap: () =>
                        _selectDate(context, _graduationYearController),
                  ),
                  const SizedBox(height: 16.0),
                  ListTile(
                    title: const Text('Experiências passadas',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        )),
                    trailing: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: _addExperience,
                    ),
                  ),
                  Column(
                    children: pastExperiences.map((experience) {
                      int index = pastExperiences.indexOf(experience);

                      return CustomListTile(
                          title: experience.company,
                          subTitle: experience.role,
                          index: index,
                          onDeletePressed: () => _removeExperience(index));
                    }).toList(),
                  ),
                  const SizedBox(height: 16.0),
                  ListTile(
                    title: const Text('Certificados',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                        )),
                    trailing: IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: _addActivity,
                    ),
                  ),
                  Column(
                    children: certificates.map((activity) {
                      int index = certificates.indexOf(activity);

                      return CustomListTile(
                          title: activity.name,
                          subTitle: activity.description,
                          index: index,
                          onDeletePressed: () => _removeActivity(index));
                    }).toList(),
                  ),
                ])),
      ]),
    );
  }
}
