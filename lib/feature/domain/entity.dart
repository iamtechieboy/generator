import 'dart:io';

import 'package:generator/helper/generator_helper.dart';

class EntityDirectoryGenerator {
  static Future<void> generate({
    required String featureName,
    required String projectName,
    bool isAdditional = false,
  }) async {
    var name = featureName.capitalize();
    featureName = featureName.convertToSnakeCase();

    var content = """ 
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:$projectName/features/$featureName/data/models/${featureName}_model.dart';


class ${name}Entity extends Equatable {
  final int id;
  final String name;

  const ${name}Entity({
    this.id = -1,
    this.name = '',
  });

  @override
  List<Object?> get props => [
        id,name,
      ];
}

class ${name}Converter
    implements JsonConverter<${name}Entity, Map<String, dynamic>> {
  const ${name}Converter();

  @override
  ${name}Entity fromJson(Map<String, dynamic> json) =>
      ${name}Model.fromJson(json);

  @override
  Map<String, dynamic> toJson(${name}Entity object) => {
    'id': object.id,
    'name': object.name,
    };
}

    """;

    var path = '$projectName/lib/features/$featureName/domain/entities/${featureName}_entity.dart';
    if (isAdditional) {
      path = 'lib/features/$featureName/domain/entities/${featureName}_entity.dart';
    }

    File(path).create(recursive: true).then(
      (File file) async {
        await file.writeAsString(content);
      },
    );
  }
}
