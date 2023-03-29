import 'package:flutter/material.dart';
import 'package:micro_app_publish_curricula/app/components/publish_curricula_first_form.dart';
import 'package:micro_app_publish_curricula/app/services/curricula.service.dart';
import 'package:micro_commons/app/components/custom_form_button.dart';
import 'package:micro_commons/app/entities/curriculum.dart';
import 'package:micro_commons/app/routes.dart';

class PublishCurriculaMultiFormPage extends StatefulWidget {
  const PublishCurriculaMultiFormPage({super.key});

  @override
  State<PublishCurriculaMultiFormPage> createState() =>
      _PublishCurriculaMultiFormPageState();
}

class _PublishCurriculaMultiFormPageState
    extends State<PublishCurriculaMultiFormPage> {
  int currentStep = 0;
  final _firstFormKey = GlobalKey<PublishCurriculaFirstFormState>();
  final _curriculaService = CurriculaService();
  bool _isLoading = false;

  bool _isCurrentStepValid() {
    final firstFormState = _firstFormKey.currentState;

    bool isCurrentStepValid = false;
    switch (currentStep) {
      case 0:
        isCurrentStepValid = firstFormState?.validateForm() ?? false;
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

  _submitCurriculum() async {
    final firstFormState = _firstFormKey.currentState;
    final navigator = Navigator.of(context);

    if (_isCurrentStepValid()) {
      setState(() {
        _isLoading = true;
      });
      final Curriculum curriculum = Curriculum(
          name: firstFormState!.name,
          lastName: firstFormState.lastName,
          degreeCourse: firstFormState.degreeCourse,
          graduationYear: firstFormState.graduationYear,
          pastExperiences: firstFormState.pastExperiences,
          certificates: firstFormState.certificates);
      String? id = await _curriculaService.publishCurriculum(curriculum);

      //todo: modificar essa linha e remover id == -1
      if (id != null || id == '-1') {
        navigator.pushReplacementNamed(Routes.publishCurriculaSuccessPage);
      } else {
        navigator.pushReplacementNamed(Routes.publishCurriculaErrorPage);
      }
      setState(() {
        _isLoading = false;
      });
    }
  }

  _getContinueButton() {
    bool isLastStep = (currentStep == getSteps().length - 1);
    if (isLastStep) {
      return CustomFormButton(
        onPressed: () => _submitCurriculum(),
        label: 'Submeter',
        isLoading: _isLoading,
      );
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
              Navigator.pop(context);
            },
          ),
        ],
        title: const Text(
          "Publicar Currículo",
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
        content: PublishCurriculaFirstForm(
          key: _firstFormKey,
        ),
      ),
    ];
  }
}
