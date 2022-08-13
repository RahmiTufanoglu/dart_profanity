<!-- 
A profanity filter written in Dart.
⚠️️ Still in progress and not ready to use. ⚠️️
-->

This package censores profanity in String sequences and delivers some censor options for your needs.

## Experimental 🚧
Dart Profanity is an experimental project under development and should not be used in production at this time.

## Features

- Censors profanity in words for the languages english, german and turkish (more incoming)
- You can enable the first letter and censor the rest (more options incoming)
- Simple Api with no overhead
- No Third-Party dependencies
- Open for everyone
- Contributions are welcome :)

## Getting started

Enter in the console:

```
pub get dart_profanity
```

## Usage

```dart

final profanity = Profanity(languages: ['en']); // Shorter Profanity(), as en is the default
final isProfanity = profanity.containsProfanity('YoU aRe aN aSShole & FuCKer.');
print(isProfanity); // Outputs: true

final censoredWithAsterisk = profanity.censor(
  'Asshole',
  bleepType: CensorBleepType.asterisk,
);
print(censoredWithAsterisk); // Outputs: *******
```

## Additional information

GitHub: https://github.com/RahmiTufanoglu/dart_profanity
