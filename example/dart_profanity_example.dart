import 'package:dart_profanity/dart_profanity.dart';

void main() {
  final dartProfanity = DartProfanity(languageCodes: ['de', 'en', 'gg']);
  final censored0 = dartProfanity.censor('Du bist ein mega Arschloch & DuWichser.');
  print('censored0: $censored0');

  final censored1 = dartProfanity.censor('Du bist ein mega Arschloch & DuWichser.');
  print('censored1: $censored1');

  final dartProfanity2 = DartProfanity();
  final censored2 = dartProfanity2.censor('Du bist ein mega arschloch & DuAsS!');
  print('censored2: $censored2');

  final censored3 = dartProfanity2.censor(
    'Du bist ein mega arschloch & DuAsS!',
    censorType: CensorType.firstLetter,
  );
  print('censored3: $censored3');

  final censored4 = dartProfanity2.censor(
    'dU bist ein badAsS!',
    censorType: CensorType.firstLetter,
  );
  print('censored4: $censored4');
  //final censored4 = dartProfanity.censor(
  //  characters: 'Du bist ein mega Arschloch & DuWichser.',
  //  bleepType: CensorBleepType.characters,
  //);
  //print('censored4: $censored4');
  //final censored3 = dartProfanity.censor(
  //  characters: 'Leck mich am Arsch.',
  //  bleep: CensorBleepType.characters,
  //);
  //final censored4 = dartProfanity.censor(
  //  characters: 'Leck mich am Ass.',
  //  bleep: CensorBleepType.characters,
  //);
}
