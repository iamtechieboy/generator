import 'dart:io';
import 'package:generator/swagger_ui/helper_models/field_constructor.dart';

void generateModel(
    {required String label, required String name, required String projectName, required ModelEntityElements data}) {
  var content = """
import 'package:json_annotation/json_annotation.dart'; 
import 'package:$projectName/features/swaggerUIModels/$label/${label}_entity.dart';

part '${label}_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake) 
class ${name}Model extends ${name}Entity {
  const ${name}Model({
    ${data.superFields}
  });

  factory ${name}Model.fromJson(Map<String, dynamic> json) =>
      _\$${name}ModelFromJson(json);

  Map<String, dynamic> toJson() => _\$${name}ModelToJson(this);
}

    """;

  File('$projectName/lib/features/swaggerUIModels/$label/${label}_model.dart')
      .create(recursive: true)
      .then((File file) async {
    await file.writeAsString(content);
  });
}
