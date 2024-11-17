import 'dart:io';

import 'package:generator/helper/generator_helper.dart';

class RouteModifier {
  static Future<void> modify({
    required String projectName,
    required List<String> features,
    bool isAdditional = false,
  }) async {
    print("🛠️ Modifying route structure...");

    var path = '$projectName/lib/core/routing/app_routing.dart';
    if (isAdditional) {
      path = 'lib/core/routing/app_routing.dart';
    }

    final serviceLocatorFile = File(path);
    final serviceLocatorContent = serviceLocatorFile.readAsStringSync();

    // Modify imports
    var updatedImportContent = await _importContents(
      features: features,
      fileContent: serviceLocatorContent,
      projectName: projectName,
    );

    // Modify Names constants
    var updatedNamesContent = await _nameConstantsContent(
      features: features,
      fileContent: updatedImportContent,
      projectName: projectName,
    );

    // after importing all import files
    // next step is to register all features
    var registeredFeaturesContent = await _registeredFeaturesContent(
      features: features,
      fileContent: updatedNamesContent,
      projectName: projectName,
    );

    serviceLocatorFile.writeAsStringSync(registeredFeaturesContent);
    print("Done ✅");
  }

  static Future<String> _importContents({
    required List<String> features,
    required String fileContent,
    required String projectName,
  }) async {
    var importContent = '';
    var updatedContent = '';
    final importSignature = '//::IMPORTS::';

    for (var featureName in features) {
      featureName = featureName.trim();
      featureName = featureName.convertToSnakeCase();

      // import page of each feature
      importContent +=
          "\nimport 'package:$projectName/features/$featureName/presentation/pages/${featureName}_screen.dart';";
    }

    int indexOfSignature = fileContent.indexOf(importSignature);
    if (indexOfSignature != -1) {
      // Calculate the position to insert the new data (right after the signature)
      int insertionPoint = indexOfSignature + importSignature.length;

      // Insert the new data
      updatedContent = fileContent.substring(0, insertionPoint) + importContent + fileContent.substring(insertionPoint);
    } else {
      updatedContent = fileContent;
    }

    return updatedContent;
  }

  static Future<String> _nameConstantsContent({
    required List<String> features,
    required String fileContent,
    required String projectName,
  }) async {
    var content = '';
    var updatedContent = '';
    final signature = '//::NAMES::';

    for (var featureName in features) {
      featureName = featureName.trim();
      featureName = featureName.convertToSnakeCase();

      content +=
      """\n
static const String $featureName = '/$featureName';
  """;
    }

    int indexOfSignature = fileContent.indexOf(signature);
    if (indexOfSignature != -1) {
      // Calculate the position to insert the new data (right after the signature)
      int insertionPoint = indexOfSignature + signature.length;

      // Insert the new data
      updatedContent = fileContent.substring(0, insertionPoint) + content + fileContent.substring(insertionPoint);
    } else {
      updatedContent = fileContent;
    }

    return updatedContent;
  }

  static Future<String> _registeredFeaturesContent({
    required List<String> features,
    required String fileContent,
    required String projectName,
  }) async {
    var content = '';
    var updatedContent = '';
    final signature = '//::ROUTES::';

    for (var featureName in features) {
      featureName = featureName.trim();
      var variableName = featureName;
      featureName = featureName.capitalize()!;

      /// Register all features
      content += """\n
      GoRoute(
         name: $variableName,
         path: $variableName,
         builder: (context, state) => ${featureName}Screen(),
       ),
      """;
    }

    int indexOfSignature = fileContent.indexOf(signature);
    if (indexOfSignature != -1) {
      // Calculate the position to insert the new data (right after the signature)
      int insertionPoint = indexOfSignature + signature.length;

      // Insert the new data
      updatedContent = fileContent.substring(0, insertionPoint) + content + fileContent.substring(insertionPoint);
    } else {
      updatedContent = fileContent;
    }

    return updatedContent;
  }
}
