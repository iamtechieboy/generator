part of 'core.dart';

/// Generate network classes
class DioHandlerClassGenerator {
  static Future<void> generate(String projectName) async {
    print("🛠️ Generating network classes...");

    Directory('$projectName/lib/core/network').createSync(recursive: true);
    final networkDirectory = File('$projectName/lib/core/network/dio_handler.dart');

    networkDirectory.writeAsStringSync(
      """
import 'package:dio/dio.dart';
import 'package:$projectName/core/config/app_constants.dart';
import 'package:$projectName/core/network/interceptor/custom_interceptor.dart';
import 'package:$projectName/core/services/shared_preference_manager.dart';

      
class DioSettings {
  void setBaseOptions({String? lang, String? baseUrl}) {
    _dioBaseOptions().baseUrl = baseUrl ?? AppConstants.baseUrl;
    _dioBaseOptions().headers['Authorization'] = SharedPreferenceManager.getString(
      AppConstants.token,
      defValue: '',
    );
    _dioBaseOptions().headers['Accept-Language'] = lang ?? 'en';
  }

  BaseOptions _dioBaseOptions({String? baseUrl}) => BaseOptions(
        baseUrl: baseUrl ?? AppConstants.baseUrl,
        connectTimeout: const Duration(milliseconds: 35000),
        receiveTimeout: const Duration(milliseconds: 35000),
        followRedirects: false,
        headers: {
          'Authorization': SharedPreferenceManager.getString(
            AppConstants.token,
            defValue: '',
          ),
          'Accept-Language': SharedPreferenceManager.getString(
            AppConstants.language,
            defValue: 'en',
          ),
          // 'Accept': "application/json",
          // 'Contract': AppConstants.CONTRACT_API,
        },
        validateStatus: (status) => status != null && status <= 500,
      );

  Dio dio({String? baseurl}) {
    final Dio dio = Dio(_dioBaseOptions(baseUrl: baseurl));
    dio.interceptors
      ..add(LogInterceptor(
        responseBody: true,
        requestBody: true,
        request: true,
        requestHeader: true,
      ))
      ..add(CustomInterceptor(dio: dio));
    return dio;
  }
}
      """,
    );
    print("Done ✅");
  }
}
