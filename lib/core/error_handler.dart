part of 'core.dart';

/// Generate error handling classes
class ErrorHandlerClassGenerator {
  static Future<void> generate(String projectName) async {
    print("🛠️ Generating error handling class...");

    Directory('$projectName/lib/core/error').createSync(recursive: true);
    final errorHandlingDirectory = File('$projectName/lib/core/error/error_handler.dart');

    errorHandlingDirectory.writeAsStringSync(
      """
class ServerException implements Exception {
  final String errorMessage;
  final num statusCode;

  const ServerException({this.statusCode = 400, this.errorMessage = 'error'});

  @override
  String toString() => 'ServerException(statusCode: \$statusCode, errorMessage: \$errorMessage)';
}

class CustomDioException implements Exception {}

class ParsingException implements Exception {
  final String errorMessage;

  const ParsingException({required this.errorMessage});
}

class CacheException implements Exception {
  final String errorMessage;

  const CacheException({required this.errorMessage});
}
      """,
    );
    print("Done ✅");
  }
}
