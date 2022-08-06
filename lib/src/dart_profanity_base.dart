import 'package:dart_profanity/dart_profanity.dart';
import 'package:dart_profanity/languages/index.dart';

/// Creates an [Profanity].
class Profanity {
  Profanity({this.languages = const ['en']}) {
    /// Checks if the given languages are available in languages codes.
    final availableLanguages = languages.where((element) {
      return Language.codes.contains(element);
    }).toList();

    _profanityList = availableLanguages //
        .map((element) => profanityList(element))
        .expand((element) => element)
        .toList();
  }

  final List<String> languages;

  /// The nglish ('En') swear word list is always the default.
  /// You can disable it by using the languages property like:
  /// final profanity = Profanity(languages: ['de']);
  /// This will only use the german ['de'] swear words list.
  var _profanityList = [...En.list];

  /// Sets the profanity list by the language code.
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

  /// Checks if string contains a swear word.
  bool containsProfanity(String word) {
    return _profanityList //
        .where((element) => word.toLowerCase().contains(element))
        .toList()
        .isNotEmpty;
  }

  /// Censors the swear words from a string sequence.
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
            return word.contains(element);
          }).toList()
            ..sort((a, b) => b.length.compareTo(a.length));

          String? longestProfanity;

          if (list.isNotEmpty) {
            longestProfanity = list.first;
          }

          if (longestProfanity != null) {
            String? firstLetter;

            /// Does not censor first letter.
            if (censorType == CensorType.firstLetter) {
              final index = word.lastIndexOf(longestProfanity);
              firstLetter = e.value[index];
            }

            /// Creates an [CensorBleepType].
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
