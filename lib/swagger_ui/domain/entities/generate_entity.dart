import 'dart:io';
import 'package:generator/swagger_ui/helper_models/field_constructor.dart';

void generateEntity(
    {required String label, required String name, required String projectName, required ModelEntityElements data}) {
  var content = """
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:$projectName/features/swaggerUIModels/$label/${label}_model.dart';

class ${name}Entity extends Equatable {  
  ${data.fields}
  const ${name}Entity({
    ${data.constructors}
  });

  @override
  List<Object?> get props => [
      ${data.props}
      ];
}

class ${name}Converter
    implements JsonConverter<${name}Entity, Map<String, dynamic>> {
  const ${name}Converter();

  @override
  ${name}Entity fromJson(Map<String, dynamic> json) =>
      ${name}Model.fromJson(json);

  @override
  Map<String, dynamic> toJson(${name}Entity object) => {};
}

    """;

  File('$projectName/lib/features/swaggerUIModels/$label/${label}_entity.dart')
      .create(recursive: true)
      .then((File file) async {
    await file.writeAsString(content);
  });
}
