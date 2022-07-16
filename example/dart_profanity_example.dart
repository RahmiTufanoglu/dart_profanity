import 'package:dart_profanity/dart_profanity.dart';

void main() {
  final dartProfanity = DartProfanity(languageCode: 'de');
  final bad = dartProfanity.isProfanity('Arschloch');

  print('is bad: $bad');
}
