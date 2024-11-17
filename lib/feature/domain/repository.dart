import 'dart:io';

import 'package:generator/helper/generator_helper.dart';

class RepositoryGenerator {
  static Future<void> generate({
    required String featureName,
    required String projectName,
    bool isAdditional = false,
  }) async {
    var name = featureName.capitalize();
    featureName = featureName.convertToSnakeCase();

    var content = """ 
import 'package:$projectName/core/error/failure_handler.dart';
import 'package:$projectName/core/util/either.dart';
import 'package:$projectName/features/$featureName/domain/entities/${featureName}_entity.dart';

abstract class ${name}Repository {
  Future<Either<Failure, ${name}Entity>> get$name({required String? next});
}
    """;

    var path = '$projectName/lib/features/$featureName/domain/repositories/${featureName}_repository.dart';
    if(isAdditional) {
      path = 'lib/features/$featureName/domain/repositories/${featureName}_repository.dart';
    }

    File(path)
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(content);
    });
  }
}
