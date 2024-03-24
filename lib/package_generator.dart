import 'dart:convert';
import 'dart:io';

import 'package:generator/dependencies/dependencies.dart';
import 'package:generator/dependencies/pubspace_modifier.dart';
import 'package:generator/feature/common/common_generator.dart';
import 'package:generator/feature/feature_generator.dart';
import 'package:generator/feature/navigation/navigation_generator.dart';
import 'package:generator/main/main_modifier.dart';
import 'package:generator/main/readme_modifier.dart';
import 'package:generator/main/run_commands.dart';
import 'assets/assets_generator.dart';
import 'core/core.dart';

class PackageGenerator {
  String? projectName;
  bool isValidName = false;

  Future<void> consoleInteraction() async {
    while (!isValidName) {
      print('💾 Enter your Flutter project name:');
      projectName = stdin.readLineSync(encoding: utf8);

      if (projectName == null || projectName!.isEmpty) {
        print('🫤 Project name cannot be empty.');
        continue; // Prompt the user again
      }

      // Using RegExp to ensure the project name is valid
      // https://dart.dev/tools/linter-rules/package_names for package naming conventions
      if (!RegExp(r'^[a-z_][a-z0-9_]*$').hasMatch(projectName!)) {
        print('😕 Invalid project name. Please follow Dart package naming conventions:'
            'https://dart.dev/tools/linter-rules/package_names');
        continue; // Prompt the user again
      }
      isValidName = true; // Exit the loop if name is valid
    }

    // Ask for platform preferences
    print('💾 Do you want to include support for Windows? (y/n)');
    bool includeWindows = stdin.readLineSync()?.trim().toLowerCase() == 'y';

    print('🐼 Do you want to include support for Linux? (y/n)');
    bool includeLinux = stdin.readLineSync()?.trim().toLowerCase() == 'y';

    print('🍏 Do you want to include support for MacOS? (y/n)');
    bool includeMacOs = stdin.readLineSync()?.trim().toLowerCase() == 'y';

    print('🕸️ Do you want to include support for Web? (y/n)');
    bool includeWeb = stdin.readLineSync()?.trim().toLowerCase() == 'y';

    /// Generate the project
    await generateFlutterProject(
      projectName!,
      includeWindows: includeWindows,
      includeLinux: includeLinux,
      includeWeb: includeWeb,
      includeMacOS: includeMacOs,
    );

    print('👊 Your Flutter project "$projectName" is ready!\n'
        '🛠️ Do you want to include the core structure? (y/n)');

    /// Ask the user if they want to include the core structure
    bool includeCoreStructure = stdin.readLineSync()?.trim().toLowerCase() == 'y';
    if (includeCoreStructure) {
      print('🕒 Wait for seconds until the core structure is created...');
      await Core.generateCoreStructure(projectName!);
      print('🎉 Core structure created successfully');
      await Dependencies.addDependencies(projectName!);
      print('🎉 Dependencies added successfully');
      await Assets.generateAssetsFolder(projectName!);
      print('🎉 Assets folder created successfully');
      await PubspecYaml.modifyPubspecForAssets(projectName);
      print('🎉 pubspec.yaml modified successfully');
      await MainModifier.modifyMain(projectName);
      print('🎉 Main modified successfully');
      await CommonGenerator.generate(projectName: projectName!);
      print('🎉 Common folder created successfully');
      await NavigationGenerator.generate(projectName: projectName!);
      print('🎉 Navigation folder created successfully');
      await FeatureGenerator.generate(projectName!);
      print('🎉 Feature folder created successfully');
      await RunCommands.run(projectName: projectName!);
      print('🎉 Commands run successfully');
      await ReadMeModifier.modify(projectName: projectName!);
      print('🎉 Readme modified successfully');
    }
  }

  Future<void> generateFlutterProject(
    String projectName, {
    bool includeWindows = false,
    bool includeLinux = false,
    bool includeWeb = false,
    bool includeMacOS = false,
  }) async {
    /// Default platform flags with Android and iOS
    String platformFlags = '--platforms=android,ios';

    List<String> args = ['create'];

    // Add platform-specific flags based on user input
    if (includeWindows) platformFlags += ',windows';
    if (includeLinux) platformFlags += ',linux';
    if (includeWeb) platformFlags += ',web';
    if (includeMacOS) platformFlags += ',macos';

    // Add the platform flags to the arguments list
    args.add(platformFlags);

    // Add the project name at the end of the arguments list
    args.add(projectName);

    print('🕒 Wait for seconds until the project is generated...');
    var result = await Process.run('flutter', args);

    if (result.exitCode == 0) {
      print('🎉 Flutter project "$projectName" generated successfully');
    } else {
      print('🥺 Failed to generate Flutter project. Error:\n${result.stderr}');
    }
  }
}
