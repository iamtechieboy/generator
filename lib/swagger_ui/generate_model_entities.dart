import 'package:generator/helper/generator_helper.dart';
import 'package:generator/swagger_ui/commands/get_model_entity_elements.dart';
import 'package:generator/swagger_ui/data/models/generate_model.dart';
import 'package:generator/swagger_ui/domain/entities/generate_entity.dart';

class GenerateModelEntity {
  static Future<void> generate({required Map<String, dynamic> data, required String projectName}) async {
    print("‼️ Generation started");
    final values = data.values.toList();
    final keys = data.keys.toList();

    for (var i = 0; i < values.length; i++) {
      if (keys[i].contains('/')) continue;
      final modelFields = getModelFields(values[i]);
      final label = keys[i].convertToSnakeCase();
      print("🔥 Generating $label");
      generateEntity(label: label, projectName: projectName, data: modelFields, name: keys[i]);
      generateModel(label: label, projectName: projectName, data: modelFields, name: keys[i]);
      print("🎉 $label generated");
    }
  }
}
