import 'package:dart_profanity/src/dart_profanity_base.dart';
import 'package:test/test.dart';

void main() {
  group('de language tests', () {
    final dartProfanity = DartProfanity(languageCode: 'de');

    setUp(() {
      // Additional setup goes here.
    });

    test('Contains vulgar word', () {
      final result = dartProfanity.containsProfanity('Arschloch');
      expect(result, isTrue);
    });

    test('Censore vulgar word', () {
      final result = dartProfanity.censor(characters: 'Arschloch');
      expect(result, 'A********');
    });

    test('Censor vulgar word with random characters', () {
      final result = dartProfanity.censor(
        characters: 'Arschloch',
        bleep: CensorBleepType.asterix,
      );
      expect(result[0], 'A');
      expect(result.substring(1, result.length), '********');
    });

    test('Censor vulgar word with random characters', () {
      final result = dartProfanity.censor(
        characters: 'Arschloch',
        bleep: CensorBleepType.characters,
      );
      expect(result[0], 'A');
    });
  });
}
