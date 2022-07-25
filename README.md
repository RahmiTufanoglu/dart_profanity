<!-- 
A Profanity filter written in Dart.
-->

This package censores swear words from your text and delivers some censor options for your needs.

## Features

- Censors swear words for the languages english, german and turkish (more incoming)
- You can enable the first letter and censor the rest (more options incoming)
- Simple Api with no overhead
- Active maintained package
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
final profanity = Profanity();
final censored1 = profanity.censor('You asshole! You pUssy!');
print('censored1: $censored1');

final profanity = Profanity(languages: ['de']);
final censored2 = profanity.censor('Du bist ein mega Arschloch & DuWichser.');
print('censored2: $censored2');
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to 
contribute to the package, how to file issues, what response they can expect 
from the package authors, and more.
