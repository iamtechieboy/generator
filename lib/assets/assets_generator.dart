import 'dart:io';

class Assets {
  static Future<void> generateAssetsFolder(String projectName) async {
    Directory('$projectName/assets/images').createSync(recursive: true);
    final imagesFolder = File('$projectName/assets/images/.gitkeep');
    imagesFolder.writeAsStringSync("");
    Directory('$projectName/assets/icons').createSync(recursive: true);
    final iconsFolder = File('$projectName/assets/icons/.gitkeep');
    iconsFolder.writeAsStringSync("");
    Directory('$projectName/assets/translations').createSync(recursive: true);
    final jsonFile = File('$projectName/assets/translations/uz.json');
    jsonFile.writeAsStringSync(
      """
{
  "name" : "$projectName",
  "home" : "Home",
  "settings" : "Settings"
}
    """,
    );
  }
}
