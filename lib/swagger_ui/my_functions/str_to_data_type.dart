String strToDataType(String str) {
  String type = '';
  switch (str) {
    case 'string':
      type = 'String';
      break;
    case 'integer':
      type = 'int';
      break;
    case 'array':
      type = 'List';
      break;
    case 'number':
      type = 'num';
      break;
    case 'boolean':
      type = 'bool';
      break;
    case 'object':
      type = 'Object';
      break;
    default:
      type = '${str}Entity';
  }
  if (type.isEmpty) {
    final sf = 0;
  }
  return type;
}

String strToDefaultValue({required String str, required bool isId}) {
  var v = '';
  switch (str) {
    case 'String':
      v = "''";
      break;
    case 'int':
      v = '0';
      break;
    case 'List':
      v = 'const []';
      break;
    case 'num':
      v = '0';
      break;
    case 'bool':
      v = 'false';
      break;
    default:
      v = 'const $str()';
  }
  if (v == '') {
    final f = 0;
  }
  if (isId) v = '-1';
  return v;
}
