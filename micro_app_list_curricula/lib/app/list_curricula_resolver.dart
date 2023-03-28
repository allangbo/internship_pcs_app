import 'package:micro_app_list_curricula/app/pages/list_curricula.page.dart';
import 'package:micro_commons/app/auth_route.dart';
import 'package:micro_commons/app/pages/error_page.dart';
import 'package:micro_commons/app/routes.dart';
import 'package:micro_core/app/micro_app.dart';
import 'package:micro_core/app/micro_core_utils.dart';

class ListCurriculaResolver implements MicroApp {
  @override
  String get microAppName => 'micro_app_list_curricula';

  @override
  Map<String, WidgetBuilderArgs> get routes => {
        Routes.listCurricula: (context, args) => AuthRoute(
              builder: (context, authState) => const ListCurriculaPage(),
            ),
        Routes.listCurriculaErrorPage: (context, args) => const ErrorPage(
              returnRoute: Routes.listCurricula,
              title: 'Currículos',
              message: 'Não foi possível carregar os currículos.',
            )
      };
}
