import 'package:micro_app_curricula_details/app/pages/curricula_details.page.dart';
import 'package:micro_commons/app/auth_route.dart';
import 'package:micro_commons/app/pages/error_page.dart';
import 'package:micro_commons/app/routes.dart';
import 'package:micro_commons/app/userRole.enum.dart';
import 'package:micro_core/app/micro_app.dart';
import 'package:micro_core/app/micro_core_utils.dart';

class CurriculaDetailsResolver implements MicroApp {
  @override
  String get microAppName => 'micro_app_curricula_details';

  @override
  Map<String, WidgetBuilderArgs> get routes => {
        Routes.curriculaDetailsPage: (context, args) {
          String studentId = (args as Map)['studentId'] ?? '';
          UserRole userType = (args)['userType'] ?? '';
          return AuthRoute(
              builder: (context, authState) => CurriculumDetailsPage(
                    studentId: studentId,
                    userType: userType,
                  ));
        },
        Routes.curriculaDetailsErrorPage: (context, args) => const ErrorPage(
              returnRoute: Routes.listApplications,
              title: 'Visualização de Currículo',
              message: 'Não foi possível carregar o curriículo do aluno.',
            ),
      };
}
