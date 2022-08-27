import 'dart:math';

class StringHelper {
  StringHelper._();

  /// Outputs random characters.
  static String getRandomCharacters(int length) {
    final random = Random.secure();
    final values = List<int>.generate(length, (i) => random.nextInt(33) + 89);
    return String.fromCharCodes(values);
  }
}

extension StringExt on String {
  String get normalize {
    return replaceAll('ı', 'i') //
        .replaceAll('ș', 's')
        .replaceAll('ç', 'c');
  }
}
