import 'package:micro_app_list_vacancies/app/pages/list_vacancies.page.dart';
import 'package:micro_core/app/micro_app.dart';
import 'package:micro_core/app/micro_core_utils.dart';

class ListVacanciesResolver implements MicroApp {
  @override
  String get microAppName => 'micro_app_list_vacancies';

  @override
  Map<String, WidgetBuilderArgs> get routes => {
        '/list_vacancies': (context, args) => const ListVacanciesPage(),
      };
}
