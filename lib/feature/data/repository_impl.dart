import 'dart:io';

import 'package:generator/helper/generator_helper.dart';

class RepositoryImplGenerator {
  static Future<void> generate({
    required String projectName,
    required String featureName,
    bool isAdditional = false,
  }) async {
    var variableName = featureName;
    var name = featureName.capitalize()!;
    featureName = featureName.convertToSnakeCase();

    var content = """ 
import 'package:$projectName/core/error/error_handler.dart';
import 'package:$projectName/core/error/failure_handler.dart';
import 'package:$projectName/core/util/either.dart';
import 'package:$projectName/features/$featureName/data/data_sources/${featureName}_datasource.dart';
import 'package:$projectName/features/$featureName/domain/entities/${featureName}_entity.dart'; 
import 'package:$projectName/features/$featureName/domain/repositories/${featureName}_repository.dart';


class ${name}RepositoryImpl implements ${name}Repository {
    final ${name}DataSource ${variableName}DataSource;
  
    ${name}RepositoryImpl({required this.${variableName}DataSource});
  
    @override
    Future<Either<Failure, ${name}Entity>> get${name}({
    String? next,
  }) async {
    try {
      var result = await ${variableName}DataSource.get$name( 
        next: next,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    } on DioFailure catch (e) {
      return Left(DioFailure(errorMessage: e.errorMessage));
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    }
  }
}
    """;

    var path = '$projectName/lib/features/$featureName/data/repositories/${featureName}_repository_impl.dart';
    if (isAdditional) {
      path = 'lib/features/$featureName/data/repositories/${featureName}_repository_impl.dart';
    }
    File(path)
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(content);
    });
  }
}
