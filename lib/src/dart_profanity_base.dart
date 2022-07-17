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
    //final word = characters.toLowerCase().split(' ');
    //print('word $word');

    return characters
        .split(' ')
        .asMap()
        .entries
        .map((e) {
          final list = profanityList.where((element) {
            return e.value.toLowerCase().contains(element);
          }).toList();

          final strList = list..sort((a, b) => b.length.compareTo(a.length));
          String? longestProfanity;
          if (strList.isNotEmpty) {
            longestProfanity = strList.first;
          }

          if (longestProfanity != null) {
            final censored = CensorBleepType.censored(
              bleep: bleepType,
              length: longestProfanity.length - censorType.lengthDisplayed,
            );

            final result = e.value.toLowerCase().replaceAll(longestProfanity, censored);
            return result;
          }

          return e.value;
        })
        .toList()
        .join(' ');

    //final foo = profanityList.where((element) {
    //  return word
    //      .where((el) {
    //        //final list = profanityList.where((element) => word.contains(element)).toList();
    //        //final longestProfanity = list.reduce((a, b) => a.length > b.length ? a : b);
    //        print(el);
    //        return el.contains(element);
    //      })
    //      .toList()
    //      .isNotEmpty;
    //}).toList();
//
    //print('foo $foo');

    return '';
    //return characters
    //    .split(' ')
    //    .asMap()
    //    .entries
    //    .map((e) {
    //      final word = e.value.toLowerCase();
    //      print('word: $word');
    //      final splitted = word.split(' ');
    //      print('===============|A|===============> $splitted');
    //      final test = splitted.indexWhere((element) => profanityList.contains(element));
    //      print('test $test');
//
    //      // final a = e.value.split('').indexWhere((element) => longestProfanity.contains(element));
    //      //       final word = e.value.toLowerCase();
    //      //       final list = profanityList.where((element) => word.contains(element)).toList();
    //      //       if (list.isNotEmpty) {
    //      //         final longestProfanity = list.reduce((a, b) => a.length > b.length ? a : b);
    //      //         final notFirstLetter = longestProfanity.substring(1, longestProfanity.length);
    //      //         final censored = CensorBleepType.censored(
    //      //           bleep: bleep,
    //      //           length: longestProfanity.length - 1,
    //      //         );
////
    //      //         print('===============|B|===============> ${longestProfanity}');
    //      //         final res = word.split(longestProfanity);
////
    //      //         final empty = res.first.isEmpty;
    //      //         print('empty $empty');
////
    //      //         final index = empty ? 0 : 1;
////
    //      //         print('index $index');
    //      //         print('===============|C|===============> ${res}');
////
    //      //         return word.substring(index, index + 1);
//
    //      // //badAss23232 split 2 => pos 1
    //      // //badsdasd221Ass split 1 =>
////
    //      // print('===============|A|===============> ${word}');
    //      // final b = word.split(longestProfanity);
    //      // print('===============|C|===============> ${b}');
////
    //      // // badAss! [bad, !] = 2   =>
    //      // // bad!Ass [bad!] = 1     =>
////
    //      // final test = word.split(b.first);
    //      // print(test.last);
////
    //      // //print(e.value);
    //      // //print(notFirstLetter);
    //      // ///
    //      // final index = b.first.isEmpty ? 0 : (word.length - test.length) - 2;
    //      // print('index: $index');
    //      // final result = word.replaceAll(notFirstLetter, censored);
    //      // //return result;
    //      // //final firstLetter = result[0].toUpperCase();
    //      // //print('===============|X|===============> ${e.value}');
    //      // //print('===============|A|===============> ${word.substring(index, word.length)}');
    //      // //final foo = word.substring(index, word.length);
    //      // //final firstLetter = e.value.split('')[index];
    //      // final firstLetter = e.value.split('')[index];
    //      // print('firstLetter $firstLetter');
    //      // //final xx = result.split('')[index] = firstLetter;
    //      // //print('xx $xx');
////
    //      // return result.replaceRange(index, index + 1, firstLetter);
    //      // //print('|===============> ${boo}');
    //      // //print('result|===============> ${result}');
    //      // //final b = e.value.split('').indexWhere((element) => foo.contains(element));
    //      // //print('===============|B|===============> ${b}');
    //      // //return result.substring(index - 1, word.length);
    //      //}
    //      return e.value;
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

enum CensorType {
  full(0),
  firstLetter(1);

  const CensorType(this.notCensoredLength);

  final int notCensoredLength;

  int get lengthDisplayed => notCensoredLength;
}
