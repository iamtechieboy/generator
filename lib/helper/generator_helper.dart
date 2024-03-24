extension CapitilizeString on String {
  String? capitalize() {
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  String? deCapitalize() {
    return toLowerCase();
  }

  String snakeToCamelUp() {
    if (isEmpty || length == 1) {
      return this;
    }

    final words = split('_');
    final capitalizedWords = words.map((word) {
      final firstLetter = word.substring(0, 1).toUpperCase();
      final remainingLetters = word.substring(1).toLowerCase();
      return '$firstLetter$remainingLetters';
    });

    return capitalizedWords.join();
  }

  String snakeToCamelDown() {
    if (isEmpty || length == 1) {
      return this;
    }
    final vv = replaceAll('-', '_');
    final words = vv.split('_');
    bool isFirst = true;

    final capitalizedWords = words.map((word) {
      if (word.isEmpty) return word;
      String firstLetter = '';
      if (isFirst) {
        try {
          firstLetter = word.substring(0, 1).toLowerCase();
        } catch (e) {
          final lv = this;
          final ff = e;
          final f = 0;
        }
        isFirst = false;
      } else {
        firstLetter = word.substring(0, 1).toUpperCase();
      }
      final remainingLetters = word.substring(1).toLowerCase();
      return '$firstLetter$remainingLetters';
    });
    final v = 0;
    return capitalizedWords.join();
  }

  String convertToSnakeCase() {
    final regex = RegExp(r'(?<=[a-z0-9])[A-Z]');
    final snakeCase = replaceAllMapped(regex, (match) {
      return '_${match.group(0)!.toLowerCase()}';
    }).toLowerCase();

    return snakeCase;
  }
}
