import 'dart:io';

import 'package:generator/helper/generator_helper.dart';

class WidgetGenerator {
  static Future<void> generate({
    required String projectName,
    required String featureName,
    bool isAdditional = false,
  }) async {
    var content = """
/// You can put your common widgets that are used in this page here
    """;
    featureName = featureName.convertToSnakeCase();

    var path = '$projectName/lib/features/$featureName/presentation/widgets/${featureName}_widget.dart';
    if(isAdditional) {
      path = 'lib/features/$featureName/presentation/widgets/${featureName}_widget.dart';
    }

    File(path)
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(content);
    });
  }
}
