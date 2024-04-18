import 'package:generator/helper/helper_models/param_content_model.dart';
import 'package:generator/helper/helper_models/param_model_fields.dart';

ParamModelFields getDatasourceParamFields(List<ParamContent> src) {
  String fields = '';
  String constructors = '';
  for (var i = 0; i < src.length; i++) {
    String fieldType = '';
    String fieldName = '';
    String defaultValue = '';
    fields += 'final $fieldType $fieldName; ';
    constructors += 'this.$fieldName = $defaultValue, ';
  }
  return ParamModelFields(fields: fields, constructors: constructors);
}
