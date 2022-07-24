import 'package:dart_profanity/src/censor_bleep_type.dart';
import 'package:dart_profanity/src/dart_profanity_base.dart';
import 'package:test/test.dart';

void main() {
  group('de language tests', () {
    final dartProfanity = Profanity();
    final dartProfanityDe = Profanity(languages: ['de']);

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
      final result = dartProfanityDe.censor('Arschloch');
      expect(result, '*********');
    });

    test('Censor vulgar word with asterix', () {
      final result = dartProfanity.censor(
        'dU bist ein badAsS!',
        bleepType: CensorBleepType.asterix,
      );
      expect(result, 'dU bist ein bad***!');
    });

    test('Censor vulgar word with random characters de', () {
      final result = dartProfanityDe.censor(
        'Arschloch',
        bleepType: CensorBleepType.asterix,
      );
      expect(result.substring(1, result.length), '********');
    });

    test('Censor vulgar word with random characters de', () {
      final result = dartProfanityDe.censor(
        'Arschloch',
        bleepType: CensorBleepType.characters,
      );
      expect(result, isNot('*********'));
    });

    test('Censor vulgar word with random characters de', () {
      final result = dartProfanityDe.censor(
        'ichficke dich du ficker fick ick.fickdichik',
        bleepType: CensorBleepType.asterix,
      );
      expect(result, 'ich***** dich du ****** **** ick.****dichik');
    });
  });
}
