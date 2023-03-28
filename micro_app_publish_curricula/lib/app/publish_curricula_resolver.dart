import 'package:micro_app_publish_curricula/app/pages/publish_curricula_multi_form.page.dart';
import 'package:micro_commons/app/auth_route.dart';
import 'package:micro_commons/app/pages/error_page.dart';
import 'package:micro_commons/app/pages/success_page.dart';
import 'package:micro_commons/app/routes.dart';
import 'package:micro_core/app/micro_app.dart';
import 'package:micro_core/app/micro_core_utils.dart';

class PublishCurriculaResolver implements MicroApp {
  @override
  String get microAppName => 'micro_app_publish_curricula';

  @override
  Map<String, WidgetBuilderArgs> get routes => {
        Routes.publishCurricula: (context, args) => AuthRoute(
              builder: (context, authState) =>
                  const PublishCurriculaMultiFormPage(),
            ),
        Routes.publishCurriculaErrorPage: (context, args) => const ErrorPage(
              returnRoute: Routes.publishCurricula,
              title: 'Publicar Currículo',
              message: 'Não foi possível publicar o currículo.',
            ),
        Routes.publishCurriculaSuccessPage: (context, args) =>
            const SuccessPage(
              returnRoute: Routes.home,
              title: 'Publicar Currículo',
              message: 'Sucesso ao publicar o currículo.',
              labelActionButton: 'Retornar para o início',
            )
      };
}
