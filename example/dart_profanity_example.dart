import 'package:dart_profanity/dart_profanity.dart';

void main() {
  final profanity = Profanity();
  final result = profanity.censor(
    'FuckYou assfuckerAsshole and pUSSy!',
    bleepType: CensorBleepType.asterix,
    censorType: CensorType.firstLetter,
  );
  print('result: $result');

  //final profanity = Profanity(languages: ['de', 'en', 'gg']);
  //final censored = profanity.censor('Du bist ein mega Arschloch & DuWichser.');
  //print('censored0: $censored');

  //final censored1 = profanity.censor('Du bist ein mega Arschloch & DuWichser.');
  //print('censored1: $censored1');

  //final dartProfanity2 = Profanity();
  //final censored2 = dartProfanity2.censor('Du bist ein mega arschloch & DuAsS!');
  //print('censored2: $censored2');

  //final censored3 = dartProfanity2.censor(
  //  'Du bist ein mega arschloch & DuAsS!',
  //  censorType: CensorType.firstLetter,
  //);
  //print('censored3: $censored3');
}
