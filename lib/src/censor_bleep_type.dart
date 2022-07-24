import 'package:dart_profanity/utils/string_helper.dart';

/// Creates an [CensorBleepType].
/// CensorBleepType asterix censors the whole String with asterix symbols.
/// CensorBleepType characters censor the whole String with random characters.
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

  @override
  String toString() => '$CensorBleepType';
}
