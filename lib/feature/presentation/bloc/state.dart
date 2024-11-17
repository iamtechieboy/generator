import 'dart:io';

import 'package:generator/helper/generator_helper.dart';

class StateGenerator {
  static Future<void> generate({
    required String featureName,
    required String projectName,
    bool isAdditional = false,
  }) async {
    var variableName = featureName;
    var name = featureName.capitalize();
    featureName = featureName.convertToSnakeCase();

    var content = """
part of '${featureName}_bloc.dart';

class ${name}State extends Equatable {
  final FormzSubmissionStatus status;
  final ${name}Entity $variableName;
  const ${name}State({
    this.status = FormzSubmissionStatus.initial,
    this.$variableName = const ${name}Entity(),
    
  });
  @override
  List<Object?> get props => [status, $variableName];

  ${name}State copyWith({
    FormzSubmissionStatus? status,
    ${name}Entity? $variableName,
  }) {
    return ${name}State(
      status: status ?? this.status,
      $variableName: $variableName ?? this.$variableName,
    );
  }
}

    """;

    var path = '$projectName/lib/features/$featureName/presentation/blocs/$featureName/${featureName}_state.dart';
    if (isAdditional) {
      path = 'lib/features/$featureName/presentation/blocs/$featureName/${featureName}_state.dart';
    }

    File(path).create(recursive: true).then((File file) async {
      await file.writeAsString(content);
    });
  }
}
