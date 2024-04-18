import 'dart:io';

import 'package:generator/helper/generator_helper.dart';

Future<void> deleteDataSource({required String label, required String projectName}) async {
  var name = label.capitalize();

  var content = """ 
import 'package:dio/dio.dart';
import 'package:$projectName/core/exceptions/exceptions.dart'; 
import 'package:$projectName/features/pagination/data/models/generic_pagination.dart';
import 'package:$projectName/features/$label/data/models/${label}_model.dart';

abstract class ${name}DataSource {     
  Future<GenericPagination<${name}Model>> get${name}s({required String? next});
}

class ${name}DataSourceImpl implements ${name}DataSource {
  final Dio _dio;
  
  ${name}DataSourceImpl(this._dio);
  
  @override
  Future<GenericPagination<${name}Model>> get${name}s({required String? next}) async {
    try {
      final response = await _dio.get(
        'replece/this/with/your/end_point',
      );
      if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
        return GenericPagination(next: null, previous:null, results:List.generate(10, (index) =>${name}Model(name: 'name \$index',id: index)), count: 10);
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
