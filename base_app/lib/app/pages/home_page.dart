import 'package:base_app/app/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:micro_commons/app/auth_state.dart';
import 'package:micro_commons/app/graphql_config.dart';
import 'package:micro_commons/app/routes.dart';
import 'package:micro_commons/app/userRole.enum.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final String username;

  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authState = Provider.of<AuthState>(context, listen: false);

    return Scaffold(
      backgroundColor: const Color(0xfffafafd),
      appBar: AppBar(
        title: const Text(
          'Internship 4.0',
          style: CustomAppBarStyle.titleStyle,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              GraphQLConfig(url: '').setToken(null);
              authState.setUser(null);
              Navigator.of(context).pushReplacementNamed(Routes.home);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Bem-vindo(a) de volta!',
                style: CustomTextStyle.welcomeMessageStyle,
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage(
                      'packages/micro_commons/lib/assets/images/default_image.png',
                    ),
                    radius: 25,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    username,
                    style: CustomTextStyle.usernameStyle,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Serviços',
                style: CustomTextStyle.servicesTitleStyle,
              ),
              const SizedBox(height: 20),
              _getMenuButtons(context, authState)
            ],
          ),
        ),
      ),
    );
  }

  _getMenuButtons(BuildContext context, AuthState authState) {
    final userType = authState.user?.userRole ?? UserRole.STUDENT;
    switch (userType) {
      case UserRole.COMPANY:
        return _getCompanyMenuButtons(context);
      case UserRole.PROFESSOR:
        return _getTeacherMenuButtons(context);
      case UserRole.STUDENT:
        return _getStudentMenuButtons(context);
      default:
        return _getStudentMenuButtons(context);
    }
  }

  Widget _getListCurriculaButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
      child: CustomButton(
        imageUrl: 'lib/assets/images/list_curricula.png',
        label: 'Currículos',
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.listCurricula);
        },
      ),
    );
  }

  Widget _getPublishCurriculaButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
      child: CustomButton(
        imageUrl: 'lib/assets/images/publish_curricula.png',
        label: 'Enviar Currículo',
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.publishCurricula);
        },
      ),
    );
  }

  Widget _getListVacanciesButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
      child: CustomButton(
        imageUrl: 'lib/assets/images/list_vacancies.png',
        label: 'Vagas',
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.listVacancies);
        },
      ),
    );
  }

  Widget _getPublishVacancyButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
      child: CustomButton(
        imageUrl: 'lib/assets/images/publish_vacancy.png',
        label: 'Publicar Vaga',
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.publishVacancy);
        },
      ),
    );
  }

  Widget _getProfileButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
      child: CustomButton(
        imageUrl: 'lib/assets/images/profile.png',
        label: 'Perfil',
        onPressed: () {},
      ),
    );
  }

  Widget _getListApplicationButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
      child: CustomButton(
        imageUrl: 'lib/assets/images/list_application.png',
        label: 'Candidaturas',
        onPressed: () {
          Navigator.of(context).pushNamed(Routes.listApplications);
        },
      ),
    );
  }

  Widget _getNotificationsButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
      child: CustomButton(
        imageUrl: 'lib/assets/images/notifications.png',
        label: 'Notificações',
        onPressed: () {},
      ),
    );
  }

  Widget _getListStudentsButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
      child: CustomButton(
        imageUrl: 'lib/assets/images/list_students.png',
        label: 'Estudantes',
        onPressed: () {},
      ),
    );
  }

  Widget _getListCompaniesButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 15.0, 0, 15.0),
      child: CustomButton(
        imageUrl: 'lib/assets/images/list_companies.png',
        label: 'Empresas',
        onPressed: () {},
      ),
    );
  }

  Widget _getStudentMenuButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            _getProfileButton(context),
            _getListApplicationButton(context),
            _getNotificationsButton(context),
          ],
        ),
        const SizedBox(width: 30),
        Column(
          children: [
            _getListVacanciesButton(context),
            _getPublishCurriculaButton(context)
          ],
        ),
      ],
    );
  }

  Widget _getCompanyMenuButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            _getProfileButton(context),
            _getPublishVacancyButton(context),
          ],
        ),
        const SizedBox(width: 30),
        Column(
          children: [
            _getListVacanciesButton(context),
            _getNotificationsButton(context)
          ],
        ),
      ],
    );
  }

  Widget _getTeacherMenuButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            _getListStudentsButton(context),
            _getListCurriculaButton(context),
            _getListApplicationButton(context),
          ],
        ),
        const SizedBox(width: 30),
        Column(
          children: [
            _getListVacanciesButton(context),
            _getListCompaniesButton(context),
            _getNotificationsButton(context),
          ],
        ),
      ],
    );
  }
}

class CustomAppBarStyle {
  static const titleStyle = TextStyle(
    fontFamily: 'Poppins',
  );
}

class CustomTextStyle {
  static const welcomeMessageStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 18,
    color: Color(0xff0c0c26),
  );

  static const usernameStyle = TextStyle(
      fontFamily: 'Poppins',
      fontSize: 22,
      color: Color(0xff0c0c26),
      fontWeight: FontWeight.bold);

  static const servicesTitleStyle = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color(0xff0c0c26),
  );
}
