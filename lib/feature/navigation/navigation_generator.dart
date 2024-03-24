import 'package:generator/feature/navigation/nav_bar_entity.dart';
import 'package:generator/feature/navigation/nav_bar_item.dart';
import 'package:generator/feature/navigation/navigation_screen.dart';

class NavigationGenerator {
  static Future<void> generate({required String projectName}) async {
    print("Generating navigation directory...");
    await NavigationScreenGenerator.generate(projectName: projectName);
    await NavBarItemGenerator.generate(projectName: projectName);
    await NavBarEntityGenerator.generate(projectName: projectName);
    print("Done ✅");
  }
}
