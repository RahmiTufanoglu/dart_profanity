import 'package:dart_profanity/dart_profanity.dart';
import 'package:dart_profanity/utils/string_helper.dart';

/// Creates an [CensorBleepType].
/// CensorBleepType asterisk censors the whole String with asterisk symbols.
/// CensorBleepType characters censor the whole String with random characters.
enum CensorBleepType {
  asterisk(CensorType.firstLetter),
  characters(CensorType.firstLetter);

  const CensorBleepType(this.censorType);

  final CensorType censorType;

  static String censored({
    required String word,
    required String profanity,
    required dynamic bleep,
    required CensorType censorType,
  }) {
    late final String censoredWord;
    final profanityLength = profanity.length;
    final firstLetterNotCensored = censorType.notCensoredLength == 1 ? profanity[0] : '';
    final censoredProfanityLength = profanityLength - (censorType.notCensoredLength == 1 ? 1 : 0);
    if (bleep is String) {
      //censoredWord = firstLetterNotCensored + bleep.toString() * profanityLength;
      censoredWord = firstLetterNotCensored + bleep.toString() * censoredProfanityLength;
    } else if (bleep is CensorBleepType) {
      if (bleep == CensorBleepType.asterisk) {
        censoredWord = firstLetterNotCensored + '*' * censoredProfanityLength;
      } else if (bleep == CensorBleepType.characters) {
        censoredWord = firstLetterNotCensored + StringHelper.getRandomCharacters(censoredProfanityLength);
      }
    } else {
      censoredWord = firstLetterNotCensored + '*' * censoredProfanityLength;
    }
    final result = word.replaceAll(profanity, censoredWord);
    return result;
  }

  @override
  String toString() => '$CensorBleepType';
}
