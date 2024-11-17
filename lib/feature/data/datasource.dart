import 'dart:io';

import 'package:generator/helper/generator_helper.dart';

class DatasourceGenerator {
  static Future<void> generate(
      {required String projectName, required String featureName, bool isAdditional = false}) async {
    var name = featureName.capitalize();
    featureName = featureName.convertToSnakeCase();

    var content = '''
import 'package:dio/dio.dart';
import 'package:$projectName/core/error/error_handler.dart'; 
import 'package:$projectName/features/$featureName/data/models/${featureName}_model.dart';

abstract class ${name}DataSource {     
  Future<${name}Model> get$name({required String? next});
}

class ${name}DataSourceImpl implements ${name}DataSource {
  final Dio _dio;

  ${name}DataSourceImpl(this._dio);

  @override
  Future<${name}Model> get$name({required String? next}) async {
    try {
      final response = await _dio.get(
        'replece/this/with/your/end_point',
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return ${name}Model.fromJson(response.data);
      } else {
        var message = response.data["message"];
        message ??= response.data["error_message"];
        throw ServerException(
          statusCode: response.statusCode ?? 500,
          errorMessage: message,
        );
      }
    } on ServerException {
      rethrow;
    } on DioException catch (e) {
      throw DioException(requestOptions: e.requestOptions);
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    } catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }
}
    ''';

    var path = '$projectName/lib/features/$featureName/data/data_sources/${featureName}_datasource.dart';
    if (isAdditional) {
      path = 'lib/features/$featureName/data/data_sources/${featureName}_datasource.dart';
    }
    File(path).create(recursive: true).then((File file) async {
      await file.writeAsString(content);
    });
  }
}
