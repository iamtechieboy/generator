import 'dart:io';

class PubspecYaml {
  static Future<void> modifyPubspecForAssets(projectName) async {
    print("♻️ Modifying pubspec.yaml for assets...");
    // Define the path to the pubspec.yaml file
    String projectPath = '${Directory.current.path}/$projectName';
    final pubspecPath = '$projectPath/pubspec.yaml';

    // Open the pubspec.yaml file
    File pubspecFile = File(pubspecPath);
    if (!pubspecFile.existsSync()) {
      print('pubspec.yaml not found');
      return;
    }

    // Read the current content
    String content = pubspecFile.readAsStringSync();

    // Define new assets and fonts to add
    String newAssets = '''
assets:
    - assets/images/
    - assets/icons/
    - assets/translations/
    - assets/translations/uz.json
    
  ''';

    String newFonts = '''
fonts:
    - family: Inter
      fonts:
        - asset: assets/fonts/Inter-ExtraLight.ttf
          weight: 200
        - asset: assets/fonts/Inter-Light.ttf
          weight: 300
        - asset: assets/fonts/Inter-Regular.ttf
          weight: 400
        - asset: assets/fonts/Inter-Medium.ttf
          weight: 500
        - asset: assets/fonts/Inter-SemiBold.ttf
          weight: 600
        - asset: assets/fonts/Inter-Bold.ttf
          weight: 700
        - asset: assets/fonts/Inter-ExtraBold.ttf
          weight: 800
        - asset: assets/fonts/Inter-Black.ttf
          weight: 900
          
    ''';

    String devDependencies = '''
dev_dependencies:
  build_runner: ^2.4.8
  json_serializable: ^6.7.1
  dart_style: ^2.3.6
    ''';

    content = content.replaceFirst('# assets:', newAssets);

    content = content.replaceFirst('# fonts:', newFonts);

    content = content.replaceFirst('dev_dependencies:', devDependencies);

    // Write the modified content back to pubspec.yaml
    pubspecFile.writeAsStringSync(content);
    print('✅ pubspec.yaml has been updated successfully.\n'
        '🧲 Consider adding your assets and fonts to the respective folders.');

    // Read the file lines
    final lines = pubspecFile.readAsLinesSync();

    // Filter out lines that start with '#'
    final filteredLines = lines.where((line) => !line.trimLeft().startsWith('#')).toList();

    // Write the filtered lines back to pubspec.yaml
    pubspecFile.writeAsStringSync(filteredLines.join('\n'));
    print('✅ Comments have been removed from pubspec.yaml.');
  }
}
