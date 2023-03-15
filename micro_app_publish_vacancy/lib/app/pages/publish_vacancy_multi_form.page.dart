import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:micro_app_publish_vacancy/app/entities/internship_vacancy.dart';
import 'package:micro_app_publish_vacancy/app/components/publish_vacancy_first_form.dart';
import 'package:micro_app_publish_vacancy/app/components/publish_vacancy_fourth_form.dart';
import 'package:micro_app_publish_vacancy/app/components/publish_vacancy_second_form.dart';
import 'package:micro_app_publish_vacancy/app/components/publish_vacancy_third_form.dart';
import 'package:micro_app_publish_vacancy/app/services/vacancy.service.dart';

class PublishVacancyMultiFormPage extends StatefulWidget {
  const PublishVacancyMultiFormPage({super.key});

  @override
  State<PublishVacancyMultiFormPage> createState() =>
      _PublishVacancyMultiFormPageState();
}

class _PublishVacancyMultiFormPageState
    extends State<PublishVacancyMultiFormPage> {
  int currentStep = 0;
  final _firstFormKey = GlobalKey<PublishVacancyFirstFormState>();
  final _secondFormKey = GlobalKey<PublishVacancySecondFormState>();
  final _thirdFormKey = GlobalKey<PublishVacancyThirdFormState>();
  final _fourthFormKey = GlobalKey<PublishVacancyFourthFormState>();
  final _vacancyService = VacancyService();

  bool _isCurrentStepValid() {
    final firstFormState = _firstFormKey.currentState;
    final secondFormState = _secondFormKey.currentState;
    final thirdFormState = _thirdFormKey.currentState;
    bool isCurrentStepValid = false;
    switch (currentStep) {
      case 0:
        isCurrentStepValid = firstFormState?.validateForm() ?? false;
        break;
      case 1:
        isCurrentStepValid = secondFormState?.validateForm() ?? false;
        break;
      case 2:
        isCurrentStepValid = thirdFormState?.validateForm() ?? false;
        break;
      case 3:
        isCurrentStepValid = true;
        break;
      default:
        isCurrentStepValid = false;
    }

    return isCurrentStepValid;
  }

  _onStepContinue() {
    bool isLastStep = (currentStep == getSteps().length - 1);

    if (_isCurrentStepValid() && !isLastStep) {
      setState(() {
        currentStep += 1;
      });
    }
  }

  _onStepTapped(int step) {
    if (_isCurrentStepValid()) {
      setState(() {
        currentStep = step;
      });
    }
  }

  _onStepCancel() {
    () => currentStep == 0
        ? null
        : setState(() {
            currentStep -= 1;
          });
  }

  _submitVacancy(RunMutation runMutation) {
    final firstFormState = _firstFormKey.currentState;
    final secondFormState = _secondFormKey.currentState;
    final thirdFormState = _thirdFormKey.currentState;
    final fourthFormState = _fourthFormKey.currentState;

    if (_isCurrentStepValid()) {
      final InternshipVacancy vacancy = InternshipVacancy(
          name: firstFormState!.name,
          openingDate: firstFormState.openingDate,
          closingDate: firstFormState.closingDate,
          description: secondFormState!.description,
          requirements: thirdFormState!.requirements,
          modality: firstFormState.modality,
          scholarship: firstFormState.scholarship,
          city: firstFormState.city,
          area: firstFormState.area,
          benefits: firstFormState.benefits,
          steps: fourthFormState!.steps);
      runMutation({'input': vacancy.toJson()});
    }
  }

  _getContinueButton() {
    bool isLastStep = (currentStep == getSteps().length - 1);
    if (isLastStep) {
      builder(RunMutation runMutation, QueryResult? result) {
        return TextButton(
          onPressed: () {
            _submitVacancy(runMutation);
          },
          child: const Text(
            'PRÓXIMO',
            style: TextStyle(color: Colors.blue),
          ),
        );
      }

      onCompleted(dynamic resultData) {
        print(resultData);
      }

      return _vacancyService.getPublishVacancyMutationWidget(
          builder, onCompleted);
    } else {
      return TextButton(
        onPressed: _onStepContinue,
        child: const Text(
          'PRÓXIMO',
          style: TextStyle(color: Colors.blue),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cadastro de Vaga ",
        ),
        centerTitle: true,
      ),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Stepper(
            elevation: 5,
            type: StepperType.horizontal,
            currentStep: currentStep,
            onStepCancel: _onStepCancel,
            onStepContinue: _onStepContinue,
            onStepTapped: _onStepTapped,
            controlsBuilder: (context, _) {
              return Row(
                children: <Widget>[
                  _getContinueButton(),
                  TextButton(
                    onPressed: _onStepCancel,
                    child: const Text(
                      'CANCELAR',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              );
            },
            steps: getSteps(),
          )),
    );
  }

  List<Step> getSteps() {
    return <Step>[
      Step(
        state: currentStep > 0 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 0,
        title: const Text(""),
        content: PublishVacancyFirstForm(
          key: _firstFormKey,
        ),
      ),
      Step(
        state: currentStep > 1 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 1,
        title: const Text(""),
        content: PublishVacancySecondForm(
          key: _secondFormKey,
        ),
      ),
      Step(
        state: currentStep > 2 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 2,
        title: const Text(""),
        content: PublishVacancyThirdForm(
          key: _thirdFormKey,
        ),
      ),
      Step(
        state: currentStep > 3 ? StepState.complete : StepState.indexed,
        isActive: currentStep >= 3,
        title: const Text(""),
        content: PublishVacancyFourthForm(
          key: _fourthFormKey,
        ),
      ),
    ];
  }
}
