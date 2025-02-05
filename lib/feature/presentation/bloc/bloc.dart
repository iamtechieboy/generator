import 'dart:io';
import 'package:generator/helper/generator_helper.dart';

class BlocGenerator {
  static Future<void> generate({
    required String featureName,
    required String projectName,
    bool isAdditional = false,
  }) async {
    var variableName = featureName;
    var name = featureName.capitalize();
    featureName = featureName.convertToSnakeCase();

    var content = """ 
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart'; 
import 'package:$projectName/core/service_locator.dart';
import 'package:$projectName/features/$featureName/data/repositories/${featureName}_repository_impl.dart';
import 'package:$projectName/features/$featureName/domain/entities/${featureName}_entity.dart';
import 'package:$projectName/features/$featureName/domain/use_cases/${featureName}_usecase.dart';

part '${featureName}_event.dart';
part '${featureName}_state.dart';

class ${name}Bloc extends Bloc<${name}Event, ${name}State> {
  final ${name}UseCase ${variableName}UseCase;
        
  ${name}Bloc({required this.${variableName}UseCase}) : super(const ${name}State()) {
    on<${name}GetEvent>((event, emit) async {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
      final result = await ${variableName}UseCase('');
      if (result.isRight) {
        emit(state.copyWith(
          status: FormzSubmissionStatus.success,
          $variableName: result.right,
        ));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });
  }
}
    """;

    var path = '$projectName/lib/features/$featureName/presentation/blocs/$featureName/${featureName}_bloc.dart';
    if(isAdditional) {
      path = 'lib/features/$featureName/presentation/blocs/$featureName/${featureName}_bloc.dart';
    }

    File(path)
        .create(recursive: true)
        .then((File file) async {
      await file.writeAsString(content);
    });
  }
}
