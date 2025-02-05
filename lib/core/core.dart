import 'dart:io';
export 'core.dart';

part 'service_locator.dart';

part 'app_colors.dart';

part 'app_theme.dart';

part 'app_icons.dart';

part 'app_images.dart';

part 'app_constants.dart';

part 'error_handler.dart';

part 'failure_handler.dart';

part 'dio_handler.dart';

part 'custom_interceptor.dart';

part 'app_routing.dart';

part 'shared_preference_manager.dart';

part 'usecase_handler.dart';

part 'either.dart';

part 'formatter.dart';

part 'extension.dart';

part 'enums.dart';

part 'api_endpoints.dart';

part 'datasource_util.dart';

part 'repository_util.dart';

/// Generate the core structure of the project
///  'core/service_locator.dart' - for registering all dependencies
///  'core/config/app_constants.dart' - for app key constants,
///  'core/config/app_colors.dart' - for app color constants,
///  'core/config/app_theme.dart' - for application theme,
///  'core/config/app_icons.dart' - for app icon constants,
///  'core/config/app_images.dart' - for app image constants,
///  'core/error/error_handler.dart' - for error handling,
///  'core/error/failure_handler.dart' - for error handling,
///  'core/network/dio_handler.dart' - for network setup,
///  'core/network/interceptors/custom_interceptor.dart' - for network interceptors,
///  'core/routing/app_router.dart' - for app routing,
///  'core/services/shared_preference_manager.dart' - for shared preference manager,
///  'core/usecases/base_usecase.dart' - for base usecase,
///  'core/util/either.dart' - for Either class,
///  'core/util/formatter.dart' - for formatter class,
///  'core/util/extensions/' - for extension class,
///  'core/util/enums/' - for enum class,

class Core {
  static Future<void> generateCoreStructure(String projectName) async {
    await ServiceLocatorClassGenerator.generate(projectName: projectName);
    await AppThemeClassGenerator.generate(projectName);
    await AppConstantsClassGenerator.generate(projectName);
    await AppColorClassGenerator.generate(projectName);
    await AppIconsClassGenerator.generate(projectName);
    await AppImagesClassGenerator.generate(projectName);
    await ErrorHandlerClassGenerator.generate(projectName);
    await FailureHandlerClassGenerator.generate(projectName);
    await DioHandlerClassGenerator.generate(projectName);
    await CustomInterceptorClassGenerator.generate(projectName);
    await AppRoutingClassGenerator.generate(projectName);
    await SharedPreferenceManagerClassGenerator.generate(projectName);
    await UseCaseClassGenerator.generate(projectName);
    await EitherClassGenerator.generate(projectName);
    await FormatterClassGenerator.generate(projectName);
    await ExtensionClassGenerator.generate(projectName);
    await EnumClassGenerator.generate(projectName);
    await EndPointsMixin.generate(projectName);
    await DataSourceUtilGenerator.generate(projectName);
    await RepositoryUtilGenerator.generate(projectName);
  }
}
