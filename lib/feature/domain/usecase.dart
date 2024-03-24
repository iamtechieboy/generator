import 'dart:io';

import 'package:generator/helper/generator_helper.dart';

class UseCaseGenerator {
  static Future<void> generate({
    required String featureName,
    required String projectName,
    bool isAdditional = false,
  }) async {
    var variableName = featureName;
    var name = featureName.capitalize();
    featureName = featureName.convertToSnakeCase();

    var content = """ 
import 'package:$projectName/core/usecases/base_usecase.dart';
import 'package:$projectName/core/error/failure_handler.dart';
import 'package:$projectName/core/util/either.dart';
import 'package:$projectName/features/$featureName/domain/repositories/${featureName}_repository.dart'; 
import 'package:$projectName/features/$featureName/domain/entities/${featureName}_entity.dart';
import 'package:$projectName/features/common/data/models/generic_pagination.dart';

class ${name}UseCase implements UseCase<GenericPagination<${name}Entity>, String?> {
  final ${name}Repository ${variableName}Repository;
  ${name}UseCase({
    required this.${variableName}Repository,
  });

  @override
  Future<Either<Failure, GenericPagination<${name}Entity>>> call(String? params) async {
    return await ${variableName}Repository.get$name(next:params);
  }
}
    """;

    var path = '$projectName/lib/features/$featureName/domain/use_cases/${featureName}_usecase.dart';
    if (isAdditional) {
      path = 'lib/features/$featureName/domain/use_cases/${featureName}_usecase.dart';
    }

    File(path).create(recursive: true).then(
      (File file) async {
        await file.writeAsString(content);
      },
    );
  }
}
