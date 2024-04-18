import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:generator/swagger_ui/generate_model_entities.dart';

class GenerateMEWithSwaggerUI {
  static Future<void> entryPoint(String projectName) async {
    print('🚩Generating model entities from Swagger UI '
        '\nEnter Swagger UI URL (click ENTER to skip this step): ');
    final swaggerUIURL = stdin.readLineSync(encoding: utf8);

    if(swaggerUIURL == null || swaggerUIURL.isEmpty) {
      print('❌ Swagger UI URL cannot be empty');
      return;
    }
    try {
      print("📥Getting data from Swagger UI...");
      final dio = Dio();
      dio.get(swaggerUIURL).then((response) {
        final definitions = response.data['definitions'] as Map<String, dynamic>;
        GenerateModelEntity.generate(data: definitions, projectName: projectName);
      });
      print('🎉 Swagger UI generated successfully');
    } on Exception catch (e) {
      print('Error while getting response from swagger url: $e');
    }
  }
}
