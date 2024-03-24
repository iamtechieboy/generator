import 'dart:io';

class Dependencies {
  static Map<String, String> dependencies = {
    'equatable': '^2.0.5',
    'shared_preferences': '^2.2.2',
    'dio': '^5.4.1',
    'get_it': '^7.6.7',
    'flutter_svg': '^2.0.10+1',
    'top_snackbar_flutter': '^3.1.0',
    'mask_text_input_formatter': '^2.9.0',
    'flutter_bloc': '^8.1.4',
    'bloc': '^8.1.3',
    'formz': '^0.7.0',
    'go_router': '^13.2.0',
    'gap': '^3.0.1',
    'path_provider': '^2.0.5',
    'easy_localization': '^3.0.5',
    'json_annotation': '^4.8.1',
    'cached_network_image': '^3.3.1',
    'shimmer': '^3.0.0',
  };

  static Future<void> addDependencies(String projectName) async {
    print("⏳ Adding important dependencies to pubspec.yaml...");
    String projectPath = '${Directory.current.path}/$projectName';
    final pubspecPath = '$projectPath/pubspec.yaml';
    final pubspecFile = File(pubspecPath);
    String content = await pubspecFile.readAsString();
    // Find the line where dependencies start
    final dependenciesIndex = content.indexOf('dependencies:');
    if (dependenciesIndex != -1) {
      // Construct the new dependencies string to insert
      String newDependencies =
          dependencies.entries.fold('', (prev, element) => '$prev\n  ${element.key}: ${element.value}');
      // Insert the new dependencies into the content
      content = content.replaceFirst('dependencies:', 'dependencies:$newDependencies');
      // Write the modified content back to the pubspec.yaml file
      await pubspecFile.writeAsString(content);
      print('🔋 Dependencies added successfully!\n'
          '📎 Packages below are added to your pubspec.yaml file:'
          '\n${dependencies.entries.map((e) => '✔ ${e.key}: ${e.value}').join('\n')}');
    } else {
      print('⛔️ Dependencies section not found in pubspec.yaml');
    }
  }
}
