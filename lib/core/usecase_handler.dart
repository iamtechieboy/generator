part of 'core.dart';

class UseCaseClassGenerator {
  static Future<void> generate(projectName) async {
    print("🛠️ Generating base usecase classes...");

    /// Generate base usecase
    Directory('$projectName/lib/core/usecases').createSync(recursive: true);
    final usecaseDirectory = File('$projectName/lib/core/usecases/base_usecase.dart');

    usecaseDirectory.writeAsStringSync(
      """
import 'package:equatable/equatable.dart';
import 'package:$projectName/core/util/either.dart';
import 'package:$projectName/core/error/failure_handler.dart';

    
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
        
abstract class StreamUseCase<Type, Params> {
  Stream<Type> call(Params params);
}
        
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
      """,
    );
    print("Done ✅");
  }
}
