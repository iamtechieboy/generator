import 'dart:io';

import 'package:generator/helper/generator_helper.dart';

class PageGenerator {
  static Future<void> generate({
    required String projectName,
    required String featureName,
    bool isAdditional = false,
  }) async {
    var variableName = featureName;
    var name = featureName.capitalize();
    featureName = featureName.convertToSnakeCase();

    var content = """
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:$projectName/core/service_locator.dart';
import 'package:$projectName/features/$featureName/presentation/blocs/$featureName/${featureName}_bloc.dart';
import 'package:$projectName/features/$featureName/domain/use_cases/${featureName}_usecase.dart';

class ${name}Screen extends StatefulWidget {
  const ${name}Screen({super.key});

  @override
  State<${name}Screen> createState() => _${name}ScreenState();
}

class _${name}ScreenState extends State<${name}Screen> {
  late ${name}Bloc ${variableName}Bloc;

  @override
  void initState() {
    super.initState();
    ${variableName}Bloc = ${name}Bloc(${variableName}UseCase: serviceLocator.get<${name}UseCase>());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: ${variableName}Bloc,
      child: BlocBuilder<${name}Bloc, ${name}State>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('${featureName}Screen'),
            ),
            body: const Center(
              child: Text('${featureName}Screen'),
            ),
          );
        },
      ),
    );
  }
}
    """;

    var path = '$projectName/lib/features/$featureName/presentation/pages/${featureName}_screen.dart';
    if (isAdditional) {
      path = 'lib/features/$featureName/presentation/pages/${featureName}_screen.dart';
    }

    File(path).create(recursive: true).then((File file) async {
      await file.writeAsString(content);
    });
  }
}
