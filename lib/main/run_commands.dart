import 'dart:io';

class RunCommands {
  static Future<void> run({required String projectName}) async {
    String projectPath = '${Directory.current.path}/$projectName';

    print("⏳ Running 'flutter pub get'...");
    await Process.run('flutter', ['pub', 'get'], workingDirectory: projectPath);
    print('✅ Dependencies installed successfully!');

    print(
        """⏳ Running ' dart run easy_localization:generate -S "assets/translations" -O "lib/generated" & dart run easy_localization:generate -S "assets/translations" -O "lib/generated" -o "locale_keys.g.dart" -f keys""");
    await Process.run(
        'dart',
        [
          'run',
          'easy_localization:generate',
          '-S',
          'assets/translations',
          '-O',
          'lib/generated',
        ],
        workingDirectory: projectPath);
    await Process.run(
        'dart',
        [
          'run',
          'easy_localization:generate',
          '-S',
          'assets/translations',
          '-O',
          'lib/generated',
          '-o',
          'locale_keys.g.dart',
          '-f',
          'keys'
        ],
        workingDirectory: projectPath);
    print('✅ Locale keys generated successfully!');

    print("⏳ Running 'flutter pub run build_runner build --delete-conflicting-outputs'...");
    await Process.run('flutter', ['pub', 'run', 'build_runner', 'build', '--delete-conflicting-outputs'],
        workingDirectory: projectPath);
    print('✅ Build completed successfully!');
  }
}
