import 'package:base_app/app/pages/home_page.dart';
import 'package:base_app/app/routes.dart';
import 'package:flutter/material.dart';
import 'package:micro_app_publish_vacancy/app/publish_vacancy_resolver.dart';
import 'package:micro_core/app/base_app.dart';
import 'package:micro_core/app/micro_app.dart';
import 'package:micro_core/app/micro_core_utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget with BaseApp {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    super.registerRoutes();

    return MaterialApp(
      title: 'Internship 4.0',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorKey: navigatorKey,
      onGenerateRoute: super.generateRoute,
      initialRoute: '/',
    );
  }

  @override
  Map<String, WidgetBuilderArgs> get baseRoutes => {
        Routes.home: (context, args) => const HomePage(
              username: 'Usuário',
            )
      };

  @override
  List<MicroApp> get microApps => [PublishVacancyResolver()];
}
