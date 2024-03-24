import 'dart:io';

class NavBarEntityGenerator {
  static Future<void> generate({required String projectName}) async {
    var content = """
import 'package:flutter/material.dart';

class NavigationBarModel {
  final int index;
  final String title;
  final IconData selectedIcon;
  final IconData unSelectedIcon;

  NavigationBarModel({
    required this.index,
    required this.title,
    required this.selectedIcon,
    required this.unSelectedIcon,
  });
}

    """;

    File('$projectName/lib/features/navigation/domain/entities/nav_bar_entity.dart')
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(content);
    });
  }
}
