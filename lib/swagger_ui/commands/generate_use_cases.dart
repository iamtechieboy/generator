
import 'package:generator/swagger_ui/data/data_sources/get_data_source.dart';

Future<void> generateUseCases(dynamic response, String projectName) async {
  final paths = (response.data['paths'] as Map<String, dynamic>).entries.toList();

  final i = 0;
  // for (var i = 0; i < paths.length; i++) {
  for (var i = 0; i < 1; i++) {
    final get = paths[i].value['get'];
    final g = paths[i].value['get']['tags'];
    final vd = 0;
    final getTag = (paths[i].value['get']['tags'] as List)[0];
    final post = paths[i].value['post'];
    final patch = paths[i].value['patch'];
    final put = paths[i].value['put'];
    final delete = paths[i].value['delete'];
    if (get != null) {
      final label = (get['operationId'] as String).replaceAll('-', '_');
      await getDataSource(label: label, projectName: projectName);
    }
    // if (post != null) {
    //   final label = (post['operationId'] as String).replaceAll('-', '_');
    //   await postDataSource(label: label, projectName: projectName);
    // }
    // if (patch != null) {
    //   final label = (patch['operationId'] as String).replaceAll('-', '_');
    //   await postDataSource(label: label, projectName: projectName);
    // }
    // if (put != null) {
    //   final label = (put['operationId'] as String).replaceAll('-', '_');
    //   await postDataSource(label: label, projectName: projectName);
    // }
    // if (delete != null) {
    //   final label = (delete['operationId'] as String).replaceAll('-', '_');
    //   await postDataSource(label: label, projectName: projectName);
    // }
    final v = 0;
  }
}
