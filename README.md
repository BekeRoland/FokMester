# FokMester

![FokMester application](https://github.com/user-attachments/assets/62736a27-9383-485b-a260-e868aa451478)

FokMester is a multilingual Flutter application for alcohol-strength
temperature correction, dilution calculations, and liquid mixing.

The project was built as a portfolio application with a focus on calculation
accuracy, input validation, localization, accessibility, persistent local
data, and automated testing.

## Features

- Alcohol-strength correction to 20 °C using two-dimensional interpolation
- Validation for the supported 10–98% and 5–30 °C measurement range
- Dilution calculation for an existing spirit
- Required spirit and water calculation for a desired final volume
- Mixing calculation for two liquids with different alcohol strengths
- Liter, deciliter, and milliliter support
- Hungarian (default), English, and Romanian localization
- Light, dark, and system themes
- Locally persisted calculation history
- Responsive Material 3 interface with accessibility semantics
- Unit and widget tests

## Technology

- Flutter and Dart
- Material 3
- `flutter_localizations`
- `shared_preferences`
- Flutter unit and widget testing

## Getting started

### Requirements

- Flutter SDK compatible with Dart `^3.11.1`
- A configured Windows, Android, iOS, macOS, Linux, or web target

### Install and run

```shell
flutter pub get
flutter run
```

To run a specific desktop or web target:

```shell
flutter run -d windows
flutter run -d chrome
```

## Quality checks

```shell
flutter analyze
flutter test
```

The current automated suite covers exact table values, interpolation,
out-of-range measurements, incomplete source data, dilution, final-volume
preparation, liquid mixing, and switching between all three languages.

## Project structure

```text
lib/
├── l10n/       # Hungarian, English and Romanian application text
├── models/     # Calculation history model
├── screens/    # Main application screens
├── services/   # Correction, dilution and mixing calculations
├── utils/      # Localized number parsing
└── widgets/    # Reusable UI components
test/          # Unit and widget tests
```

## Calculation limits

- The correction table supports measured strengths from 10% to 98% and
  temperatures from 5 °C to 30 °C.
- Above 96% and below 9 °C, the source table is incomplete. The application
  reports this instead of returning an invented value.
- Traditional alcoholmeter correction is not reliable for sweetened drinks,
  liqueurs, or liquids containing significant dissolved substances.
- Dilution and mixing calculations assume ideal volume addition. Real-world
  volume contraction can make the result approximate.

## License

This project is source-available under the
[PolyForm Noncommercial License 1.0.0](LICENSE.md).

Commercial use is prohibited without prior written permission and a separate
commercial license.

See the [NOTICE](NOTICE) file for copyright information.
