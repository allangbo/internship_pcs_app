import 'package:base_app/app/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:micro_commons/app/auth_state.dart';
import 'package:micro_commons/app/graphql_config.dart';
import 'package:micro_commons/app/routes.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final String username;

  const HomePage({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              final authState = Provider.of<AuthState>(context, listen: false);
              authState.setUser(null);
              Navigator.of(context).pushReplacementNamed(Routes.home);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
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
                    'lib/assets/images/profile_pic.png',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomButton(
                  imageUrl: 'lib/assets/images/publish_vacancy.png',
                  label: 'Publicar Vaga',
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.publishVacancy);
                  },
                ),
                const SizedBox(width: 16),
                CustomButton(
                  imageUrl: 'lib/assets/images/list_vacancies.png',
                  label: 'Listar Vagas',
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.listVacancies);
                  },
                ),
                const SizedBox(width: 16),
                CustomButton(
                  imageUrl: 'lib/assets/images/publish_curricula.png',
                  label: 'Publicar Currículo',
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.publishCurricula);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
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
