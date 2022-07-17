// TODO: Put public facing types in this file.

import 'package:dart_profanity/languages/de.dart';
import 'package:dart_profanity/languages/en.dart';
import 'package:dart_profanity/languages/languages.dart';
import 'package:dart_profanity/string_helper.dart';

class DartProfanity {
  DartProfanity({this.languageCode}) {
    if (languageCode == null) return;
    if (!Language.codes.contains(languageCode)) {
      throw LanguageNotAvailableException(languageCode!);
    }
  }

  final String? languageCode;

  List<String> get profanityList {
    switch (languageCode) {
      case Language.en:
        return En.list;
      case Language.de:
        return De.list;
      default:
        return [...En.list, ...De.list];
    }
  }

  bool containsProfanity(String word) {
    return profanityList //
        .where((element) => word.contains(element))
        .toList()
        .isNotEmpty;
  }

  String censor({
    required String characters,
    CensorBleepType bleep = CensorBleepType.asterix,
  }) {
    return characters
        .split(' ')
        .asMap()
        .entries
        .map((e) {
          final word = e.value.toLowerCase();
          final list = profanityList.where((element) => word.contains(element)).toList();
          if (list.isNotEmpty) {
            final longestProfanity = list.reduce((a, b) => a.length > b.length ? a : b);
            final notFirstLetter = longestProfanity.substring(1, longestProfanity.length);
            final censored = CensorBleepType.censored(
              bleep: bleep,
              length: longestProfanity.length - 1,
            );
            final result = word.replaceAll(notFirstLetter, censored);
            return result[0].toUpperCase() + result.substring(1, result.length);
          }
          return e.value;
        })
        .toList()
        .join(' ');
  }
}

enum CensorBleepType {
  asterix,
  characters;

  static String censored({
    required dynamic bleep,
    required int length,
  }) {
    if (bleep is String) return bleep.toString() * length;
    if (bleep is CensorBleepType) {
      if (bleep == CensorBleepType.asterix) return '*' * length;
      if (bleep == CensorBleepType.characters) return StringHelper.getRandomCharacters(length);
    }
    return '*' * length;
  }
}
