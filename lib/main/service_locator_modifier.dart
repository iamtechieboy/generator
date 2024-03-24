import 'dart:io';

import 'package:generator/helper/generator_helper.dart';

class ServiceLocatorModifier {
  static Future<void> modify({
    required String projectName,
    required List<String> features,
    bool isAdditional = false,
  }) async {
    print("🛠️ Modifying service locator...");

    var path = '$projectName/lib/core/service_locator.dart';
    if (isAdditional) {
      path = 'lib/core/service_locator.dart';
    }
    final serviceLocatorFile = File(path);
    final serviceLocatorContent = serviceLocatorFile.readAsStringSync();

    // Modify service locator
    var updatedImportContent = await _importContents(
      features: features,
      fileContent: serviceLocatorContent,
      projectName: projectName,
    );

    // after importing all import files
    // next step is to register all features
    var registeredFeaturesContent = await _registeredFeaturesContent(
      features: features,
      fileContent: updatedImportContent,
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
    final importSignature = '// ::IMPORTS::';

    for (var featureName in features) {
      featureName = featureName.trim();
      featureName = featureName.convertToSnakeCase();

      // import datasource and repositories of each feature
      importContent +=
          "\nimport 'package:$projectName/features/$featureName/data/data_sources/${featureName}_datasource.dart';"
          "\nimport 'package:$projectName/features/$featureName/data/repositories/${featureName}_repository_impl.dart';";
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

  static Future<String> _registeredFeaturesContent({
    required List<String> features,
    required String fileContent,
    required String projectName,
  }) async {
    var content = '';
    var updatedContent = '';
    final signature = '// ::REGISTERED_FEATURES::';

    for (var featureName in features) {
      featureName = featureName.trim();
      var variableName = featureName;
      featureName = featureName.capitalize()!;

      // register datasource and repositories of each feature
      content +=
          "\nserviceLocator.registerLazySingleton(() => ${featureName}DataSourceImpl(serviceLocator<DioSettings>().dio()));"
          "\nserviceLocator.registerLazySingleton(() => ${featureName}RepositoryImpl(${variableName}DataSource: serviceLocator<${featureName}DataSource>()));\n";
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
