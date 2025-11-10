part of 'core.dart';

/// Generate enum class
class EnumClassGenerator {
  static Future<void> generate(projectName) async {
    print("🛠️ Generating enum class...");

    Directory('$projectName/lib/core/util/enums').createSync(recursive: true);
    final enumsDirectory = File('$projectName/lib/core/util/enums/enums.dart');

    enumsDirectory.writeAsStringSync(
      """
import 'package:flutter/material.dart';
import 'package:$projectName/core/config/app_colors.dart';
import 'package:$projectName/core/config/app_icons.dart';

/// Enum for pop up status
enum PopUpStatus {
  failure(AppIcons.failure, AppColors.failure),
  success(AppIcons.success, AppColors.success),
  warning(AppIcons.warning, AppColors.warning);

  final String icon;
  final Color color;

  const PopUpStatus(this.icon, this.color);

  bool get isFailure => this == PopUpStatus.failure;

  bool get isSuccess => this == PopUpStatus.success;

  bool get isWarning => this == PopUpStatus.warning;
}
    """,
    );
  }
}
