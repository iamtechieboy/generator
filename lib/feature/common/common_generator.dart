import 'package:generator/feature/common/common_widgets.dart';
import 'package:generator/feature/common/generic_pagination.dart';
import 'package:generator/feature/common/list_view_pagination.dart';

class CommonGenerator {
  static Future<void> generate({required String projectName}) async {
    print("Generating common folder...");
    await CommonWidgetsGenerator.generate(projectName: projectName);
    await GenericPaginationModelGenerator.generate(projectName: projectName);
    await ListPaginationGenerator.generate(projectName: projectName);
    print("Done ✅");
  }
}
