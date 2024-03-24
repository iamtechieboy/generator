import 'dart:convert';
import 'dart:io';

class PackageNameFinder {
  static Future<String> findPackageName() async {
    // Get the current working directory
    String currentDirectory = Directory.current.path;

    // Start from the current directory and traverse up until a pubspec.yaml file is found
    Directory? currentDir = Directory(currentDirectory);
    while (currentDir != null) {
      File pubspecFile = File('${currentDir.path}/pubspec.yaml');
      if (pubspecFile.existsSync()) {
        // Read the pubspec.yaml file
        String yamlContent = pubspecFile.readAsStringSync();

        // Parse the YAML content
        String? projectName = parsePackageName(yamlContent);

        return projectName ?? '';
      }
      // Move to the parent directory
      currentDir = currentDir.parent;
    }

    // If no pubspec.yaml file is found in any parent directory, return null or handle the case as needed
    return '';
  }

  static String? parsePackageName(String pubspecContent) {
    final lines = LineSplitter.split(pubspecContent);
    for (final line in lines) {
      if (line.startsWith('name:')) {
        return line.split(':')[1].trim();
      }
    }
    return null;
  }
}
