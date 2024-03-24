part of 'core.dart';

/// Generate app theme class

class AppThemeClassGenerator {
  static Future<void> generate(String projectName) async {
    print("🛠️ Generating app theme class...");

    Directory('$projectName/lib/core/config').createSync(recursive: true);
    final appColorsDirectory = File('$projectName/lib/core/config/app_theme.dart');

    appColorsDirectory.writeAsStringSync(
      """
import 'package:flutter/material.dart';
import 'package:$projectName/core/config/app_colors.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    fontFamily: "Inter",
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      foregroundColor: Colors.white,
    ),
    textTheme: const TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelMedium: labelMedium,
    ),
  );

  static const displayLarge = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.dark,
  );
  static const displayMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.dark,
  );
  static const displaySmall = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.dark,
  );
  static const headlineLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.dark,
  );
  static const headlineMedium = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    color: AppColors.dark,
  );
    static const headlineSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.dark,
  );
  static const titleLarge = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.dark,
  );
  static const titleMedium = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.dark,
  );
  static const titleSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: AppColors.dark,
  );
  static const bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.dark,
    letterSpacing: 0
  );
  static const bodyMedium = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.dark,
  );
  static const bodySmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.dark,
    letterSpacing: 0,
  );
  static const labelLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.dark,
    letterSpacing: 0,
  );
  static const labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.dark,
    letterSpacing: 0,
  );
}

    """,
    );

    print("Done ✅");
  }
}
