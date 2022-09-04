import 'package:dart_profanity/dart_profanity.dart';
import 'package:dart_profanity/languages/index.dart';
import 'package:dart_profanity/utils/string_helper.dart';

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

  /// The english ('En') profanity word list is always the default.
  /// You can disable it by using the languages property like:
  /// final profanity = Profanity(languages: ['de']);
  /// This will only use the german ['de'] profanity words list.
  List<String> _profanityList = [...En.list];

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

  /// Checks if string contains a profanity in word.
  bool containsProfanity(String word) {
    return _profanityList //
        .where((element) => word.toLowerCase().contains(element))
        .toList()
        .isNotEmpty;
  }

  /// Censors the profanity from a string sequence.
  String censor(
    String characters, {
    CensorBleepType bleepType = CensorBleepType.asterisk,
    CensorType censorType = CensorType.full,
  }) {
    return characters
        .split(' ')
        .asMap()
        .entries
        .map((e) {
          final word = e.value;

          final lowerCaseWord = word.toLowerCase().normalize;

          final currentProfanityList = _profanityList.where((profanity) {
            return lowerCaseWord.contains(profanity);
          }).toList()
            ..sort((profanity1, profanity2) => profanity2.length.compareTo(profanity1.length));

          if (currentProfanityList.isEmpty) return word;

          String? censoredWord;

          for (var currentProfanity in currentProfanityList) {
            censoredWord = CensorBleepType.censored(
              word: censoredWord ?? lowerCaseWord,
              profanity: currentProfanity,
              bleep: bleepType,
              censorType: censorType,
            );
          }

          final upperCaseIndexes = <int>[];
          final splittedWord = word.split('');
          for (int i = 0; i < splittedWord.length; i++) {
            if (splittedWord[i].toUpperCase() == splittedWord[i]) {
              upperCaseIndexes.add(i);
            }
          }

          final splittedCensoredWord = censoredWord!.split('');
          for (int i = 0; i < splittedCensoredWord.length; i++) {
            if (upperCaseIndexes.contains(i)) {
              splittedCensoredWord[i] = splittedCensoredWord[i].toUpperCase();
            }
          }

          return splittedCensoredWord.join();
        })
        .toList()
        .join(' ');
  }
}
