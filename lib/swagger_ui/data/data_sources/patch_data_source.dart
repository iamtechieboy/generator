import 'dart:io';
import 'package:generator/helper/generator_helper.dart';

Future<void> patchDataSource({required String label, required String projectName}) async {
  var name = label.capitalize();

  var content = """ 

import 'package:dio/dio.dart';
import 'package:$projectName/core/exceptions/exceptions.dart'; 
import 'package:$projectName/features/$label/data/models/${label}_model.dart';

abstract class ${name}DataSource { 
  Future<${name}Model> get${name}s({required String? next});
}

class ${name}DataSourceImpl implements ${name}DataSource {
  final Dio _dio;

  ${name}DataSourceImpl(this._dio);


  @override
  Future<${name}Model>> get${name}s({required String? next}) async {
    try {
      final response = await _dio.patch(
        'replece/this/with/your/end_point',
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return ${name}Model.fromJson(response.data);
      } else {
        throw ServerException(
          statusCode: response.statusCode ?? 400,
          errorMessage:  response.data,
        );
      }
    } on ServerException catch (e) {
      throw ServerException(statusCode: e.statusCode, errorMessage: e.errorMessage);
    } on DioError {
      throw DioException();
    } on Exception catch (e) {
      throw ParsingException(errorMessage: e.toString());
    }
  }
}

 
    """;

  await File('lib/features/$label/data/data_sources/${label}_datasource.dart')
      .create(recursive: true)
      .then((File file) async {
    await file.writeAsString(content);
  });
}
