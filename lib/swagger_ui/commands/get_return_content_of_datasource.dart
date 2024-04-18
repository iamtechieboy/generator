import '../my_functions/is_generic_pagination.dart';

String getReturnContentOfDataSource(Map<String, dynamic> src) {
  String fields = '';
  String constructors = '';
  String props = '';
  String superFields = '';

  final get = src['get'];
  final put = src['put'];
  final patch = src['patch'];
  final post = src['post'];
  final v = 0;
  String responseClass = '';
  if (get != null) {
    bool isPagination = false;
    bool isArray = false;
    try {
      isPagination = isGenericPagination(get['responses']['200']['schema']['properties']);
    } catch (e) {
      final ggg = get;
      final v = 0;
    }

    final operationId = get['operationId'];
    final fd = get['responses'];
    final fsd = 9;
    if (isPagination) {
      responseClass =
          (get['responses']['200']['schema']['properties']['results']['items']['\$ref'] as String).split('/').last;
    } else {
      String v = '';
      String type = '';
      try {
        type = get['responses']['200']['schema']['type'];
        isArray = type == 'array';
      } catch (e) {
        final ggg = get;
        final vv = 0;
      }
      if (isArray) {
        try {
          v = (get['responses']['200']['schema']['items']['\$ref'] as String).split('/').last;
        } catch (e) {
          final ggg = get;
          v = 'if array exception: ${e.toString()}';
        }
      } else {
        try {
          v = (get['responses']['200']['schema']['\$ref'] as String).split('/').last;
        } catch (e) {
          final ggg = get;
          v = '';
        }
      }
      responseClass = v;
      final vvv = v;
      final vv = 0;
    }
    final f = isPagination;
    final isArr = isArray;
    final rc = responseClass;
    final parameters = src['parameters'];
    final b  = 0;
    if (responseClass.contains('.')) {
      return '';
    } else if (isPagination) {
      return 'GenericPagination.fromJson(response.data, (p0) => ${responseClass}Model.fromJson(p0 as Map<String, dynamic>));';
    } else if (responseClass.isNotEmpty) {
      return 'YearsModel.fromJson(response.data);';
    } else {
      return '';
    }
  }
  return 'bla-bla';
}
