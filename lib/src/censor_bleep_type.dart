import 'package:dart_profanity/dart_profanity.dart';
import 'package:dart_profanity/utils/string_helper.dart';

/// Creates an [CensorBleepType].
/// CensorBleepType asterisk censors the whole String with asterisk symbols.
/// CensorBleepType random censor the whole String with random characters.
enum CensorBleepType {
  asterisk(CensorType.firstLetter),
  random(CensorType.firstLetter);

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
      censoredWord = firstLetterNotCensored + bleep.toString() * censoredProfanityLength;
    } else if (bleep is CensorBleepType) {
      if (bleep == CensorBleepType.asterisk) {
        censoredWord = firstLetterNotCensored + '*' * censoredProfanityLength;
      } else if (bleep == CensorBleepType.random) {
        censoredWord = firstLetterNotCensored + StringHelper.getRandomCharacters(censoredProfanityLength);
      }
    } else {
      censoredWord = firstLetterNotCensored + '*' * censoredProfanityLength;
    }
    return word.replaceAll(profanity, censoredWord);
  }

  @override
  String toString() => 'CensorBleepType($censorType)';
}
