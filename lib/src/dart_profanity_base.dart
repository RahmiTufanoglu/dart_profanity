// TODO: Put public facing types in this file.

import 'package:dart_profanity/de.dart';
import 'package:dart_profanity/en.dart';
import 'package:dart_profanity/src/languages.dart';

class DartProfanity {
  DartProfanity({required this.languageCode}) {
    if (!Language.codes.contains(languageCode)) {
      throw LanguageNotAvailableException(languageCode);
    }
  }

  final String languageCode;

  List<String> get badWordList {
    switch (languageCode) {
      case Language.en:
        return En.list;
      case Language.de:
        return De.list;
      default:
        return [];
    }
  }

  bool isProfanity(String word) {
    return De.list.contains(word);
  }
}
