import 'package:base_app/app/colors/default_custom_color.dart';
import 'package:base_app/app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:micro_app_curricula_details/app/curricula_details_resolver.dart';
import 'package:micro_app_list_applications/app/list_applications_resolver.dart';
import 'package:micro_app_list_vacancies/app/list_vacancies_resolver.dart';
import 'package:micro_app_login/app/login_resolver.dart';
import 'package:micro_app_publish_curricula/app/publish_curricula_resolver.dart';
import 'package:micro_app_publish_vacancy/app/publish_vacancy_resolver.dart';
import 'package:micro_app_list_curricula/app/list_curricula_resolver.dart';
import 'package:micro_commons/app/auth_route.dart';
import 'package:micro_commons/app/auth_state.dart';
import 'package:micro_commons/app/routes.dart';
import 'package:micro_core/app/base_app.dart';
import 'package:micro_core/app/micro_app.dart';
import 'package:micro_core/app/micro_core_utils.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget with BaseApp {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    super.registerRoutes();

    return ChangeNotifierProvider(
      create: (context) {
        final authState = AuthState();
        authState.init();
        return authState;
      },
      child: MaterialApp(
        title: 'Internship 4.0',
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
        ],
        theme: ThemeData(
          primarySwatch: defaultCustomColor,
        ),
        navigatorKey: navigatorKey,
        onGenerateRoute: super.generateRoute,
        initialRoute: Routes.home,
      ),
    );
  }

  @override
  Map<String, WidgetBuilderArgs> get baseRoutes => {
        Routes.home: (context, args) => AuthRoute(
              builder: (context, authState) => HomePage(
                user: authState.user,
              ),
            ),
      };

  @override
  List<MicroApp> get microApps => [
        PublishVacancyResolver(),
        ListVacanciesResolver(),
        LoginResolver(),
        PublishCurriculaResolver(),
        ListCurriculaResolver(),
        ListApplicationsResolver(),
        CurriculaDetailsResolver()
      ];
}
