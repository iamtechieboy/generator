part of 'core.dart';

/// Generate app images constants class
class AppImagesClassGenerator {
  static Future<void> generate(String projectName) async {
    print("🛠️ Generating app images constants class...");

    Directory('$projectName/lib/core/config').createSync(recursive: true);
    final appImagesDirectory = File('$projectName/lib/core/config/app_images.dart');

    appImagesDirectory.writeAsStringSync(
      """
import 'package:flutter/material.dart';

class AppImages {
  // static const home = "assets/images/home.svg";
  // Define custom icons or frequently used icons here
}
    """,
    );
    print("Done ✅");
  }
}
