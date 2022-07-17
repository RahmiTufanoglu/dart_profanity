import 'package:dart_profanity/src/dart_profanity_base.dart';
import 'package:test/test.dart';

void main() {
  group('de language tests', () {
    final dartProfanity = DartProfanity();
    final dartProfanityDe = DartProfanity(languageCode: 'de');

    setUp(() {
      // Additional setup goes here.
    });

    test('Contains vulgar word', () {
      final result1 = dartProfanity.containsProfanity('DU bist ein AsS!');
      expect(result1, isTrue);
    });

    test('Contains vulgar word de', () {
      final result1 = dartProfanityDe.containsProfanity('Arschloch');
      expect(result1, isTrue);

      final result2 = dartProfanityDe.containsProfanity('DuWichser.');
      expect(result2, isTrue);

      final result3 = dartProfanityDe.containsProfanity('Du bist ein mega Arschloch & DuWichser.');
      expect(result3, isTrue);
    });

    test('Censore vulgar word de', () {
      final result = dartProfanityDe.censor(characters: 'Arschloch');
      expect(result, '*********');
    });

    test('Censor vulgar word with asterix', () {
      final result = dartProfanity.censor(
        characters: 'dU bist ein badAsS!',
        bleepType: CensorBleepType.asterix,
      );
      expect(result, 'dU bist ein bad***!');
    });

    test('Censor vulgar word with random characters de', () {
      final result = dartProfanityDe.censor(
        characters: 'Arschloch',
        bleepType: CensorBleepType.asterix,
      );
      expect(result.substring(1, result.length), '********');
    });

    test('Censor vulgar word with random characters de', () {
      final result = dartProfanityDe.censor(
        characters: 'Arschloch',
        bleepType: CensorBleepType.characters,
      );
      expect(result, isNot('*********'));
    });
  });
}
