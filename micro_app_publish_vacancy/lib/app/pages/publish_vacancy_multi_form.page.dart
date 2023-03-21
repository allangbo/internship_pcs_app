import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:micro_app_publish_vacancy/app/components/publish_vacancy_first_form.dart';
import 'package:micro_app_publish_vacancy/app/components/publish_vacancy_fourth_form.dart';
import 'package:micro_app_publish_vacancy/app/components/publish_vacancy_second_form.dart';
import 'package:micro_app_publish_vacancy/app/components/publish_vacancy_third_form.dart';
import 'package:micro_app_publish_vacancy/app/publish_vacancy_routes.dart';
import 'package:micro_app_publish_vacancy/app/services/vacancy.service.dart';
import 'package:micro_commons/app/components/custom_form_button.dart';
import 'package:micro_commons/app/entities/internship_vacancy.dart';

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
  bool _isLoading = false;

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
    currentStep == 0
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

    setState(() {
      _isLoading = true;
    });

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
        return CustomFormButton(
          onPressed: () {
            _submitVacancy(runMutation);
          },
          label: 'Publicar',
          isLoading: _isLoading,
        );
      }

      onCompleted(dynamic resultData) {
        if (resultData != null) {
          Navigator.pushReplacementNamed(
              context, PublishVacancyRoutes.successPage);
        } else {
          Navigator.pushReplacementNamed(
              context, PublishVacancyRoutes.errorPage);
        }
        setState(() {
          _isLoading = false;
        });
      }

      return _vacancyService.getPublishVacancyMutationWidget(
          builder, onCompleted);
    } else {
      return CustomFormButton(
        onPressed: _onStepContinue,
        label: 'Próximo',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: (currentStep > 0)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  _onStepCancel();
                },
              )
            : null,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(
                  context); // fecha a tela atual e retorna à tela anterior
            },
          ),
        ],
        title: const Text(
          "Publicar Vaga ",
        ),
        centerTitle: true,
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Stepper(
            elevation: 5,
            type: StepperType.horizontal,
            currentStep: currentStep,
            onStepCancel: _onStepCancel,
            onStepContinue: _onStepContinue,
            onStepTapped: _onStepTapped,
            controlsBuilder: (context, ControlsDetails details) {
              return Container();
            },
            steps: getSteps(),
          )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _getContinueButton(),
          ],
        ),
      ),
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
