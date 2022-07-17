class Language {
  Language._();

  static const en = 'en';
  static const de = 'de';
  static const tr = 'tr';
  static const br = 'br';
  static const fr = 'fr';

  static const codes = [
    en,
    de,
    tr,
    br,
    fr,
  ];
}

class LanguageNotAvailableException implements Exception {
  LanguageNotAvailableException(this.message);

  final String? message;

  @override
  String toString() => 'Language code $message not available.';
}
