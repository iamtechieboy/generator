part of 'core.dart';

/// Generate network classes
class EndPointsMixin {
  static Future<void> generate(String projectName) async {
    print("🛠️ Generating api end point mixin class ...");

    Directory('$projectName/lib/core/network').createSync(recursive: true);
    final endPoints = File('$projectName/lib/core/network/api_endpoints.dart');

    endPoints.writeAsStringSync(
      """
mixin ApiEndPoints {

  // DO DELETE THIS COMMENTED CODE
  // ::ENDPOINTS::
  
  String get placeEndPointsHere => 'replace/this/with/your/end_point';
  
}
      """,
    );
    print("Done ✅");
  }
}
