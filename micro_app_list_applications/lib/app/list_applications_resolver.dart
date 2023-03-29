import 'package:micro_app_list_applications/app/pages/list_applications.page.dart';
import 'package:micro_commons/app/auth_route.dart';
import 'package:micro_commons/app/pages/error_page.dart';
import 'package:micro_commons/app/routes.dart';
import 'package:micro_core/app/micro_app.dart';
import 'package:micro_core/app/micro_core_utils.dart';

class ListApplicationsResolver implements MicroApp {
  @override
  String get microAppName => 'micro_app_list_applications';

  @override
  Map<String, WidgetBuilderArgs> get routes => {
        Routes.listApplications: (context, args) => AuthRoute(
              builder: (context, authState) => const ListApplicationsPage(),
            ),
        Routes.listApplicationsErrorPage: (context, args) => const ErrorPage(
              returnRoute: Routes.listVacancies,
              title: 'Candidaturas',
              message: 'Não foi possível carregar as candidaturas.',
            ),
      };
}
