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
import 'package:$projectName/core/network/api_endpoints.dart';
import 'package:$projectName/core/util/datasource/datasource_utils.dart';


abstract class ${name}DataSource {     
  Future<${name}Model> get$name(String params);
}

class ${name}DataSourceImpl with ApiEndPoints, DataSourceUtil implements ${name}DataSource {
  final Dio _dio;

  ${name}DataSourceImpl(this._dio);

  @override
  Future<${name}Model> get$name(params) async {
     return await checkResponse<${name}Model>(() async {
      final response = await _dio.post(
        placeEndPointsHere,
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return ${name}Model.fromJson(response.data);
      } else {
        throw extractMessage(response);
      }
    });
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
