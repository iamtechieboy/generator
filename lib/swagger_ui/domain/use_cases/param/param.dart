import 'package:generator/helper/generator_helper.dart';
import 'package:generator/swagger_ui/my_functions/str_to_data_type.dart';

Future<String> paramsGenerate({required Map<String, dynamic> src}) async {
  final data = {
    "operationId": "car-place_category_list_list",
    "description": "",
    "parameters": [
      {
        "name": "search",
        "in": "query",
        "description": "A search term.",
        "required": false,
        "type": "string",
      },
      {
        "name": "limit",
        "in": "query",
        "description": "Number of results to return per page.",
        "required": false,
        "type": "integer"
      },
      {
        "name": "offset",
        "in": "query",
        "description": "The initial index from which to return the results.",
        "required": false,
        "type": "integer"
      },
      {
        "name": "region",
        "in": "query",
        "description": "Comma-separated list of region IDs",
        "required": false,
        "type": "string",
        "explode": true
      }
    ],
    "responses": {
      "200": {
        "description": "",
        "schema": {
          "required": ["count", "results"],
          "type": "object",
          "properties": {
            "count": {"type": "integer"},
            "next": {"type": "string", "format": "uri", "x-nullable": true},
            "previous": {"type": "string", "format": "uri", "x-nullable": true},
            "results": {
              "type": "array",
              "items": {"\$ref": "#/definitions/CarPlaceCategory"}
            }
          }
        }
      }
    },
    "tags": ["car-place"]
  };

  final name = (src['tags'] as String).snakeToCamelUp();
  final parametrs = src['parameters'] as List<Map<String, dynamic>>;
  String fields = '';
  String constructor = '';
  for (var i = 0; i < parametrs.length; i++) {
    /// fields
    fields += '  final  ${strToDataType(parametrs[i]['type'])}${parametrs[i]['required'] ? '?' : ''}';
    fields += '  ${parametrs[i]['name']};';

    /// fields in constructor
    constructor += '${parametrs[i]['required'] ? 'required' : ''} this.${parametrs[i]['name']},';
  }
  if ((src['responses'] as String).contains('next') && (src['responses'] as String).contains('results')) {
    fields += 'final String? next;';
    constructor += 'this.next,';
  }

  var content = '''

  class ${name}Param { 
  $fields
  const ${name}Param({
  
  $constructor
  
  });
     
}


    ''';

  return content;
}
