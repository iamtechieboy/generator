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

@JsonSerializable(explicitToJson: true)
class ${name}Model {

  final int id;
  final String name;

  ${name}Model({
    this.id = 0,
    this.name = "",
  });

  factory ${name}Model.fromJson(Map<String, dynamic> json) =>
      _\$${name}ModelFromJson(json);

  Map<String, dynamic> toJson() => _\$${name}ModelToJson(this);
  
  ${name}Entity toEntity() {
    return ${name}Entity(
      id: id,
      name: name,
    );
  }

  factory ${name}Model.fromEntity(${name}Entity entity) {
    return ${name}Model(
      id: entity.id,
      name: entity.name,
    );
  }
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
