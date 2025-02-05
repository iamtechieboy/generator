part of 'core.dart';

/// Generate enum class
class DataSourceUtilGenerator {
  static Future<void> generate(projectName) async {
    print("🛠️ Generating datasource util class...");

    Directory('$projectName/lib/core/util/datasource').createSync(recursive: true);
    final datasource = File('$projectName/lib/core/util/datasource/datasource_utils.dart');

    datasource.writeAsStringSync(
      """
import 'package:$projectName/core/error/error_handler.dart';
import 'package:dio/dio.dart';

typedef CheckResponse<T> = Future<T> Function();

/// DataSourceUtil mixin for handling response from the server

mixin DataSourceUtil {
  checkResponse<T>(CheckResponse checkResponseFunction) {
    try {
      return checkResponseFunction();
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }

  ServerException extractMessage(Response response) {
    var message = response.data["message"];
    message ??= response.data["error_message"];
    throw ServerException(
      statusCode: response.statusCode ?? 500,
      errorMessage: message,
    );
  }
}
    """,
    );
  }
}
