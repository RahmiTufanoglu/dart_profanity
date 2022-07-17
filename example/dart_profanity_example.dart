import 'package:dart_profanity/dart_profanity.dart';

void main() {
  //final dartProfanity = DartProfanity(languageCode: 'de');
  final dartProfanity = DartProfanity();
  final censored1 = dartProfanity.censor(characters: 'Du bist ein mega Arschloch & DuWichser.');
  final censored2 = dartProfanity.censor(
    characters: 'Du bist ein mega Arschloch & DuWichser.',
    bleep: CensorBleepType.characters,
  );
  final censored3 = dartProfanity.censor(
    characters: 'Leck mich am Arsch.',
    bleep: CensorBleepType.characters,
  );
  final censored4 = dartProfanity.censor(
    characters: 'Leck mich am Ass.',
    bleep: CensorBleepType.characters,
  );

  print('censored1: $censored1');
  print('censored2: $censored2');
  print('censored2: $censored3');
  print('censored2: $censored4');
}
