part of 'core.dart';

/// Generate enum class
class RepositoryUtilGenerator {
  static Future<void> generate(projectName) async {
    print("🛠️ Generating repository util class...");

    Directory('$projectName/lib/core/util/repository').createSync(recursive: true);
    final repository = File('$projectName/lib/core/util/repository/repository_utils.dart');

    repository.writeAsStringSync(
      """
import 'package:$projectName/core/error/error_handler.dart';
import 'package:$projectName/core/error/failure_handler.dart';
import 'package:$projectName/core/util/either.dart';
import 'package:dio/dio.dart';

typedef CheckException<T> = Future<T> Function();

mixin RepositoryUtil {
  Future<Either<Failure, T>> callSafely<T>(CheckException function) async {
    try {
      final result = await function();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(errorMessage: e.errorMessage, statusCode: e.statusCode));
    } on DioException catch (e) {
      return Left(DioFailure(errorMessage: e.message ?? "Something went wrong"));
    } on ParsingException catch (e) {
      return Left(ParsingFailure(errorMessage: e.errorMessage));
    }
  }
}
    """,
    );
  }
}
