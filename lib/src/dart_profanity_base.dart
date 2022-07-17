// TODO: Put public facing types in this file.

import 'package:dart_profanity/languages/de.dart';
import 'package:dart_profanity/languages/en.dart';
import 'package:dart_profanity/languages/languages.dart';
import 'package:dart_profanity/string_helper.dart';

class DartProfanity {
  DartProfanity({required this.languageCode}) {
    if (!Language.codes.contains(languageCode)) {
      throw LanguageNotAvailableException(languageCode);
    }
  }

  final String languageCode;

  List<String> get profanityList {
    switch (languageCode) {
      case Language.en:
        return En.list;
      case Language.de:
        return De.list;
      default:
        return [];
    }
  }

  //List<String> getProfanity(String word) {
  //  final splitted = word.split(' ');
  //  return splitted.where((element) => profanityList.contains(element)).toList();
  //}

  bool containsProfanity(String word) {
    //final result = word.replaceAll(RegExp(r'[^\w\s]+'), '');
    //return profanityList.contains(word);
    return profanityList //
        .where((element) => word.contains(element))
        .toList()
        .isNotEmpty;
  }

  int profanityPosition(String word) {
    return profanityList.indexWhere((element) => word.contains(element));
  }

  String censor({
    required String characters,
    CensorBleepType bleep = CensorBleepType.asterix,
  }) {
    final arr = characters.split(' ');

    characters.split(' ').asMap().entries.map((e) {
      final item = e.value.toLowerCase();
      final vulgarList = profanityList.where((element) => item.contains(element)).toList();
      //final xx = arr.indexWhere((element) => e.value.toLowerCase().contains(element));
      if (vulgarList.isNotEmpty) {
        /*final codeUnits = element.codeUnits.where((element) {
          return (element >= 48 && element <= 57) ||
              (element >= 65 && element <= 90) ||
              (element >= 65 && element <= 90) ||
              (element >= 97 && element <= 122);
        }).toList();*/

        final longestWord = vulgarList.reduce((a, b) {
          return a.length > b.length ? a : b;
        });

        print('===============> ${item} ${longestWord}');

        final notFirst = longestWord.substring(1, longestWord.length);

        final censored = CensorBleepType.censored(
          bleep: bleep,
          length: item.length - 1,
        );
        final result = item.replaceAll(notFirst, censored);

        print('===============|A|===============> ${result}');
        //final firstLetter = item.substring(0, 1);
        /*final censored = CensorBleepType.censored(
          bleep: bleep,
          length: item.length - 1,
        );*/
        //arr[e.key] = firstLetter + censored;
        arr[e.key] = result;
      }
      return item;
    }).toList();

    return arr.join(' ');
    //return characters //
    //    .toLowerCase()
    //    .split(' ')
    //    .asMap()
    //    .entries
    //    .map((element) {
    //      if (containsProfanity(element.value)) {
    //        final vulgarExpression = element.value.replaceAll(
    //          element.value,
    //          profanityList[profanityPosition(element.value)],
    //        );
    //        final firstLetter = vulgarExpression.substring(0, 1);
    //        final censored = CensorBleepType.censored(
    //          bleep: bleep,
    //          length: vulgarExpression.length - 1,
    //        );
    //        return firstLetter + censored;
    //      }
    //      return element;
    //    })
    //    .toList()
    //    .join(' ');
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
