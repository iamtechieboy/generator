import 'dart:io';

import 'package:generator/helper/generator_helper.dart';

class ModelDirectoryGenerator {
  static Future<void> generate({
    required String featureName,
    required String projectName,
    bool isAdditional = false,
  }) async {
    var name = featureName.capitalize();
    featureName = featureName.convertToSnakeCase();

    var content = """ 
import 'package:json_annotation/json_annotation.dart'; 
import 'package:$projectName/features/$featureName/domain/entities/${featureName}_entity.dart';

part '${featureName}_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ${name}Model extends ${name}Entity {
  const ${name}Model({
     super.id,
     super.name, 
  });

  factory ${name}Model.fromJson(Map<String, dynamic> json) =>
      _\$${name}ModelFromJson(json);

  Map<String, dynamic> toJson() => _\$${name}ModelToJson(this);
}

    """;

    var path = '$projectName/lib/features/$featureName/data/models/${featureName}_model.dart';
    if (isAdditional) {
      path = 'lib/features/$featureName/data/models/${featureName}_model.dart';
    }

    File(path).create(recursive: true).then(
      (File file) async {
        await file.writeAsString(content);
      },
    );
  }
}
