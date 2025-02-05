import 'dart:convert';
import 'dart:io';

import 'package:generator/feature/data/datasource.dart';
import 'package:generator/feature/data/model.dart';
import 'package:generator/feature/data/repository_impl.dart';
import 'package:generator/feature/domain/entity.dart';
import 'package:generator/feature/domain/repository.dart';
import 'package:generator/feature/domain/usecase.dart';
import 'package:generator/feature/presentation/bloc/create_bloc.dart';
import 'package:generator/feature/presentation/page.dart';
import 'package:generator/feature/presentation/widget.dart';
import 'package:generator/main/route_modfier.dart';
import 'package:generator/main/service_locator_modifier.dart';

class FeatureGenerator {
  static Future<void> generate(String projectName, {bool isAdditional = false}) async {
    print('💾 Enter your features name:');
    print(
        '(‼️ Please enter the features name in camel case pattern .\n For example: user, userProfile, userActions , etc.)');
    final featuresName = stdin.readLineSync(encoding: utf8);
    if (featuresName == null || featuresName.isEmpty) {
      print('❌ Feature name cannot be empty');
      return;
    } else if (featuresName.contains('_')) {
      print('❌ Feature name cannot contain underscore');
      return;
    }
    final List<String> featuresNameList = featuresName.split(',');
    if (featuresNameList.length == 1) {
      print("⏳ Start generating feature...");
    } else {
      print("⏳ Start generating features...");
    }
    for (var featureName in featuresNameList) {
      if (featureName.trim().isEmpty) {
        continue;
      }
      featureName = featureName.replaceAll(' ', '');
      print("📁 Generating data source...");
      await DatasourceGenerator.generate(
          projectName: projectName, featureName: featureName, isAdditional: isAdditional);
      await ModelDirectoryGenerator.generate(
          featureName: featureName, projectName: projectName, isAdditional: isAdditional);
      await RepositoryImplGenerator.generate(
          projectName: projectName, featureName: featureName, isAdditional: isAdditional);
      print("✅ Done");
      print("📁 Generating domain...");
      await EntityDirectoryGenerator.generate(
          featureName: featureName, projectName: projectName, isAdditional: isAdditional);
      await RepositoryGenerator.generate(
          featureName: featureName, projectName: projectName, isAdditional: isAdditional);
      await UseCaseGenerator.generate(projectName: projectName, featureName: featureName, isAdditional: isAdditional);
      print("✅ Done");
      print("📁 Generating presentation...");
      await MainBlocGenerator.generate(projectName: projectName, featureName: featureName, isAdditional: isAdditional);
      await PageGenerator.generate(projectName: projectName, featureName: featureName, isAdditional: isAdditional);
      await WidgetGenerator.generate(projectName: projectName, featureName: featureName, isAdditional: isAdditional);
      print("✅ $featureName feature generated successfully!");
    }

    /// TODO: Modidy service loactor
    await ServiceLocatorModifier.modify(
      projectName: projectName,
      features: featuresNameList,
      isAdditional: isAdditional,
    );

    await RouteModifier.modify(
      projectName: projectName,
      features: featuresNameList,
      isAdditional: isAdditional,
    );
  }
}
