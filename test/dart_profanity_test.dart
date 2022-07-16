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
  });
}
