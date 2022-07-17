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
        .where((element) => word.toLowerCase().contains(element))
        .toList()
        .isNotEmpty;
  }

  String censor({
    required String characters,
    CensorBleepType bleepType = CensorBleepType.asterix,
    CensorType censorType = CensorType.full,
  }) {
    return characters
        .split(' ')
        .asMap()
        .entries
        .map((e) {
          final list = profanityList.where((element) {
            return e.value.toLowerCase().contains(element);
          }).toList()
            ..sort((a, b) => b.length.compareTo(a.length));

          String? longestProfanity;
          if (list.isNotEmpty) {
            longestProfanity = list.first;
          }

          if (longestProfanity != null) {
            final censored = CensorBleepType.censored(
              bleep: bleepType,
              length: longestProfanity.length - censorType.lengthDisplayed,
            );
            return e.value.toLowerCase().replaceAll(longestProfanity, censored);
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

enum CensorType {
  full(0),
  firstLetter(1);

  const CensorType(this.notCensoredLength);

  final int notCensoredLength;

  int get lengthDisplayed => notCensoredLength;
}
