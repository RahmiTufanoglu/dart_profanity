import 'package:dart_profanity/src/censor_bleep_type.dart';
import 'package:dart_profanity/src/dart_profanity_base.dart';
import 'package:test/test.dart';

void main() {
  group('de language tests', () {
    final dartProfanity = Profanity();
    final dartProfanityDe = Profanity(languages: ['de']);

    test('Contains profanity', () {
      final result1 = dartProfanityDe.containsProfanity('DU bist ein Arsch!');
      expect(result1, isTrue);

      final result2 = dartProfanityDe.containsProfanity('Arschloch');
      expect(result2, isTrue);

      final result3 = dartProfanityDe.containsProfanity('DuWichser.');
      expect(result3, isTrue);

      final result4 = dartProfanityDe
          .containsProfanity('Du bist ein mega Arschloch & DuWichser.');
      expect(result4, isTrue);
    });

    test('Censors profanity in word', () {
      final result = dartProfanityDe.censor('Arschloch');
      expect(result, '*********');
    });

    test('Censors profanity in word with asterisk', () {
      final result = dartProfanity.censor(
        'dU bist ein badAsS!',
        bleepType: CensorBleepType.asterisk,
      );
      expect(result, 'dU bist ein bad***!');
    });

    test('Censor profanity in word with random characters', () {
      final result = dartProfanityDe.censor(
        'Arschloch',
        bleepType: CensorBleepType.asterisk,
      );
      expect(result.substring(1, result.length), '********');
    });

    test('Censor profanity in word with random characters', () {
      final result1 = dartProfanityDe.censor(
        'Arschloch',
        bleepType: CensorBleepType.random,
      );
      expect(result1, isNot('*********'));

      final result2 = dartProfanityDe.censor(
        'ichficke dICh du ficker fick ick.fickdichik',
        bleepType: CensorBleepType.asterisk,
      );
      expect(result2, 'ich***** dICh du ****** **** ick.****dichik');
    });
  });

  group('en language tests', () {
    final dartProfanity = Profanity();
    final dartProfanityEn = Profanity(languages: ['en']);

    test('Contains profanity', () {
      final result1 = dartProfanity.containsProfanity('You are an asshole!');
      expect(result1, isTrue);

      final result2 = dartProfanityEn.containsProfanity('Asshole');
      expect(result2, isTrue);

      final result3 = dartProfanityEn.containsProfanity('aSshOle.');
      expect(result3, isTrue);

      final result4 =
          dartProfanityEn.containsProfanity('YoU aRe aN aSShole & FuCKer.');
      expect(result4, isTrue);
    });

    test('Censor profanity in word with random characters', () {
      final result1 = dartProfanityEn.censor(
        'Asshole',
        bleepType: CensorBleepType.random,
      );
      expect(result1, isNot('*********'));

      final result2 = dartProfanityEn.censor(
        'FuckYou fuckerAsshole and pUSSy!',
        bleepType: CensorBleepType.asterisk,
      );
      expect(result2, '****You ************* and *****!');
    });

    test('Censor profanity in long texts.', () {
      final text = '''Hello there, how are YOUfucker?'''
          '''Lorem Ipsum assHOLEdude.''';
      /*'''!!! Click this NOW!!! -> https://porn.to'''
          '''fuck, you'''
          '''fUcK uuu'''
          '''you dirty scum''';*/

      final result = dartProfanityEn.censor(text);

      final expectation = '''Hello there, how are YOU******?'''
          '''Lorem Ipsum *******dude.''';
      //'''!!! Click this NOW!!! -> https://****.to'''
      //'''****, you'''
      //'''**** uuu'''
      //'''you dirty s***''';

      expect(result, expectation);
    });
  });
}
