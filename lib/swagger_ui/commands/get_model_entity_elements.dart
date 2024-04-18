import 'package:generator/helper/generator_helper.dart';

import '../helper_models/field_constructor.dart';
import '../my_functions/str_to_data_type.dart';

ModelEntityElements getModelFields(Map<String, dynamic> src) {
  String fields = '';
  String constructors = '';
  String props = '';
  String superFields = '';

  final Map<String, dynamic> properties = src['properties'];
  final n = properties.map((key, value) {
    final fieldName = key.convertToSnakeCase().snakeToCamelDown();
    String fieldType = '';
    final type = value['type'];
    if (type == null) {
      try {
        fieldType = '${(value['\$ref'] as String).split('/').last}Entity';
        final fdfd = 0;
      } catch (e) {
        final b = 0;
      }
    } else {
      fieldType = strToDataType(type);
    }
    final defaultValue = strToDefaultValue(str: fieldType, isId: fieldName == 'id');
    fields += 'final $fieldType $fieldName;\n';
    constructors += 'this.$fieldName = $defaultValue,\n';
    superFields += 'super.$fieldName,\n';
    props += '$fieldName,\n';

    return MapEntry(key, value);
  });
  return ModelEntityElements(
    constructors: constructors,
    fields: fields,
    superFields: superFields,
    props: props,
  );
}
