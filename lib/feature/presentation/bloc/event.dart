import 'dart:io';

import 'package:generator/helper/generator_helper.dart';

class EventGenerator {
  static Future<void> generate({
    required String featureName,
    required String projectName,
    bool isAdditional = false,
  }) async {
    var name = featureName.capitalize();
    featureName = featureName.convertToSnakeCase();

    var content = """
part of '${featureName}_bloc.dart'; 

abstract class ${name}Event {}

class ${name}GetEvent extends ${name}Event {
  final int id;
  ${name}GetEvent({
    required this.id,
  });
}
    """;

    var path = '$projectName/lib/features/$featureName/presentation/blocs/$featureName/${featureName}_event.dart';
    if (isAdditional) {
      path = 'lib/features/$featureName/presentation/blocs/$featureName/${featureName}_event.dart';
    }

    File(path).create(recursive: true).then((File file) async {
      await file.writeAsString(content);
    });
  }
}
