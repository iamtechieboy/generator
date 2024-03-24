part of 'core.dart';

/// Generate app constants class
class AppConstantsClassGenerator {
  static Future<void> generate(String projectName) async {
    print("🛠️ Generating app constants class...");

    Directory('$projectName/lib/core/config').createSync(recursive: true);
    final appConstantsDirectory = File('$projectName/lib/core/config/app_constants.dart');

    appConstantsDirectory.writeAsStringSync(
      """
class AppConstants {
  static const String baseUrl = 'https://api.example.com/';
  static const String language = 'language';
  static const String token = 'token';
  static const String refreshToken = 'refreshToken';
  // Add other constants here
}
    """,
    );

    print("Done ✅");
  }
}
