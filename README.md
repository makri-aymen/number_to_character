# number_to_character

this plugin is build to convert number to text

## Getting Started

This project is a starting point for a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android and/or iOS.

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


# How to use

First instantiate
```
NumberToCharacterConverter('en')
```
inform the value parameter to choose tha language you want,
```
arabic => ar
frensh => fr
english => en
spanish => es
```

Example:
```
var converter = NumberToCharacterConverter('en');
converter.convertInt(99); // it shows ninety nine
```
 OR
```
var converter = NumberToCharacterConverter('fr');
converter.convertInt(99); // it shows quatre-vingt dix-neuf
```

# WHAT'S NEXT?
add more languages