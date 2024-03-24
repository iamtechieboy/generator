part of 'core.dart';

/// Generate app icon constants class
class AppIconsClassGenerator {
  static
  Future<void> generate(String projectName) async {
    print("🛠️ Generating app images constants class...");

    Directory('$projectName/lib/core/config').createSync(recursive: true);
    final appIconsDirectory = File('$projectName/lib/core/config/app_icons.dart');

    appIconsDirectory.writeAsStringSync(
      """
import 'package:flutter/material.dart';

class AppIcons {
  static const String success = 'assets/icons/ic_success.svg';
  static const String failure = 'assets/icons/ic_failure.svg';
  static const String warning = 'assets/icons/ic_warning.svg';
  static const String close = 'assets/icons/ic_warning.svg';
  // static const home = "assets/icons/close.svg";
  // Define custom icons or frequently used icons here
}
    """,
    );
    print("Done ✅");
  }
}
