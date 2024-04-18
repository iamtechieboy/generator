bool isGenericPagination(Map<String, dynamic>? src) {
  if ((src?.isEmpty ?? true) || src == null) return false;
  return src.containsKey('count') &&
      src.containsKey('results') &&
      src.containsKey('next') &&
      src.containsKey('previous');
}
