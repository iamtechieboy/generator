import 'package:generator/helper/generator_helper.dart';
import 'package:generator/helper/helper_models/datasource_param_model.dart';
import 'package:generator/helper/helper_models/param_content_model.dart';

import 'get_param_fields.dart';

ParamContentOfDataSource getParamContentOfDataSource(Map<String, dynamic> src) {
  List<ParamContent> contents = [];

  final get = src['get'];
  final put = src['put'];
  final patch = src['patch'];
  final post = src['post'];
  final v = 0;
  if (get != null) {
    List parameters = get['parameters'];

    final type = parameters.runtimeType;
    final gd = 'd';
    for (var i = 0; i < parameters.length; i++) {
      try {
        contents.add(
          ParamContent(
            type: parameters[i]['type'],
            name: parameters[i]['name'],
            inWhere: parameters[i]['in'],
            isRequired: parameters[i]['required'],
          ),
        );
      } catch (e) {
        throw Exception('the get fields exception');
      }
    }
  }
  final vvv = contents;
  final vv = 0;
  String inPath = '';

  for (var i = 0; i < contents.length; i++) {
    if (contents[i].inWhere == 'path') {
      inPath += '${contents[i].name.snakeToCamelDown}/';
    }
  }

  /// param class
  String paramClassName = '';
  try {
    final paramClassName = 'get${(get['operationId'] as String).snakeToCamelDown()}';
    final vv = paramClassName;
  } catch (e) {
    final v = 0;
    // throw Exception('GET OPERATION ID EXCEPTION: ${e.toString()}');
  }

  /// param class content
  final paramFields = getDatasourceParamFields(contents);

  final paramClassContent = '''
  class $paramClassName {
  ${paramFields.fields}
  const ${paramClassName}({${paramFields.constructors}});
  
  }
  
  ''';

  return ParamContentOfDataSource(inPath: inPath, paramClassName: paramClassName, paramClassContent: paramClassContent);
}
