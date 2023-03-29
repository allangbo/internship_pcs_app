import 'package:micro_app_list_vacancies/app/pages/list_vacancies.page.dart';
import 'package:micro_app_list_vacancies/app/pages/vacancy_details.page.dart';
import 'package:micro_commons/app/auth_route.dart';
import 'package:micro_commons/app/pages/error_page.dart';
import 'package:micro_commons/app/routes.dart';
import 'package:micro_core/app/micro_app.dart';
import 'package:micro_core/app/micro_core_utils.dart';

class ListVacanciesResolver implements MicroApp {
  @override
  String get microAppName => 'micro_app_list_vacancies';

  @override
  Map<String, WidgetBuilderArgs> get routes => {
        Routes.listVacancies: (context, args) => AuthRoute(
              builder: (context, authState) => const ListVacanciesPage(),
            ),
        Routes.vacancyDetailsPage: (context, args) {
          String id = (args as Map)['id'] ?? '';
          return AuthRoute(
              builder: (context, authState) => VacancyDetailsPage(
                    vacancyId: id,
                  ));
        },
        Routes.listVacanciesErrorPage: (context, args) => const ErrorPage(
              returnRoute: Routes.listVacancies,
              title: 'Vagas Publicadas',
              message: 'Não foi possível carregar as vagas.',
            )
      };
}
