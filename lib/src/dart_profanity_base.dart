// TODO: Put public facing types in this file.

import 'package:dart_profanity/languages/de.dart';
import 'package:dart_profanity/languages/en.dart';
import 'package:dart_profanity/languages/languages.dart';
import 'package:dart_profanity/languages/tr.dart';
import 'package:dart_profanity/string_helper.dart';

class DartProfanity {
  DartProfanity({this.languageCodes = const ['en']}) {
    final availableLanguages = languageCodes.where((element) {
      return Language.codes.contains(element);
    }).toList();

    _profanityList = availableLanguages //
        .map((element) => profanityList(element))
        .expand((element) => element)
        .toList();

    //if (availableLanguages.isEmpty) {
    //  throw LanguageNotAvailableException('ALL');
    //}

    //if (languageCode == null) return;
    //if (!Language.codes.contains(languageCode)) {
    //  throw LanguageNotAvailableException(languageCode!);
    //}
  }

  final List<String> languageCodes;

  var _profanityList = [...En.list];

  List<String> profanityList(String languageCode) {
    switch (languageCode) {
      case Language.en:
        return En.list;
      case Language.de:
        return De.list;
      default:
        return [...En.list, ...De.list, ...Tr.list];
    }
  }

  bool containsProfanity(String word) {
    //return languageCodes //
    return _profanityList //
        .where((element) => word.toLowerCase().contains(element))
        .toList()
        .isNotEmpty;
  }

  String censor(
    String characters, {
    CensorBleepType bleepType = CensorBleepType.asterix,
    CensorType censorType = CensorType.full,
  }) {
    return characters
        .split(' ')
        .asMap()
        .entries
        .map((e) {
          final word = e.value.toLowerCase();
          final list = _profanityList.where((element) {
            //final list = languageCodes.where((element) {
            return word.contains(element);
          }).toList()
            ..sort((a, b) => b.length.compareTo(a.length));

          String? longestProfanity;
          if (list.isNotEmpty) {
            longestProfanity = list.first;
          }

          if (longestProfanity != null) {
            String? firstLetter;
            if (censorType == CensorType.firstLetter) {
              final index = word.lastIndexOf(longestProfanity);
              firstLetter = e.value[index];
            }
            final censored = CensorBleepType.censored(
              bleep: bleepType,
              length: longestProfanity.length - censorType.lengthDisplayed,
            );
            return e //
                .value
                .toLowerCase()
                .replaceAll(
                  longestProfanity,
                  firstLetter != null ? firstLetter + censored : censored,
                );
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
