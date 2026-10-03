---
name: flutter-intl-phone-field-migration
description: >-
  Migrate Flutter code to flutter_intl_phone_field 1.x, either from the
  unrelated intl_phone_field package or from this package's own 0.0.x and
  0.1.x releases. Use when upgrading a phone number input, when a build breaks
  after bumping flutter_intl_phone_field, when code mixes IntlPhoneField with
  an older API such as invalidNumberMessage, CountryPickerDialog or searchText,
  or on an InputDecoration type mismatch or "No Material widget found" around
  IntlPhoneField.
---

# Migrating to flutter_intl_phone_field 1.x

Three different starting points. Identify which one the code is coming from by
the dependency in `pubspec.yaml`, then apply those sections.

```yaml
intl_phone_field: …                    # -> sections A, C, D
flutter_intl_phone_field: ^0.0.x       # -> sections B, C, D
flutter_intl_phone_field: ^0.1.x       # -> section D only
```

Apply section C when coming from A or B: it covers behaviour that changed
silently, which no compiler will point at. Section D (material_ui) applies to
every starting point.

## A. From `intl_phone_field` (a different package)

The class is also called `IntlPhoneField`, so most of the widget tree survives.
Replace the dependency and the import first:

```yaml
dependencies:
  flutter_intl_phone_field: ^1.0.0   # remove intl_phone_field
  material_ui: ^1.0.0
```

```dart
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:material_ui/material_ui.dart';
```

| Old | New |
| --- | --- |
| `invalidNumberMessage:` | `invalidMessage:` |
| `searchText:` | `localizations: IntlPhoneFieldLocalizations(searchHint: …)` |
| `CountryPickerDialog(...)` | `showCountryPicker(...)` or `CountryPickerBody` |
| `dropdownIcon`, `dropdownTextStyle`, `showCountryFlag`, `disableLengthCheck`, `flagsButtonPadding` | unchanged |
| `phone.completeNumber` | unchanged, and still the right thing to store |

## B. From flutter_intl_phone_field 0.0.x

0.0.8 was never published; if the pubspec says `^0.0.7`, that is the real
starting point. Note `^0.0.7` resolves to `>=0.0.7 <0.0.8`, so bumping the
constraint to `^1.0.0` is required — it will not upgrade on its own.

| Old | New |
| --- | --- |
| `import '…/countries.dart'`, `'…/phone_number.dart'`, `'…/country_picker_dialog.dart'`, `'…/helpers.dart'` | one barrel: `import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';` (the old paths were removed in 1.0.0) |
| `phone.number = x;` | `phone = phone.copyWith(number: x);` — `PhoneNumber` is immutable |
| `CountryPickerDialog(...)` | `showCountryPicker(...)` |
| `searchText:` | `localizations.searchHint` |
| `country.dialCode` (was `"1684"` for American Samoa) | `country.fullCountryCode` to build, `country.displayCC` to display. `dialCode` is now the true calling code, `"1"`. |
| `PhoneNumber.getCountry(n)` throwing `StateError` | it now falls back to India rather than throwing |

The minimum SDK is now Dart 3.12 / Flutter 3.44 (see section D).

## C. Behaviour that changed without a compile error

Check each of these by hand. They are the ones that ship bugs.

**1. `countryCode` carries a leading `+`.**
In 0.0.x, `PhoneNumber.fromCompleteNumber` produced `countryCode` *without*
the `+` while the widget produced it *with* one. It is now always `'+44'`.
Any string built as `'+' + phone.countryCode` now yields `++44`.

```dart
// Before — worked by accident on one code path, broken on the other
final e164 = '+${phone.countryCode}${phone.number}';
// After
final e164 = phone.completeNumber;
```

**2. `isValidNumber()` returns `bool` and never throws.**

```dart
// Before
try {
  phone.isValidNumber();
} on NumberTooShortException {
  return 'Too short';
}
// After
if (!phone.isValidNumber()) return 'Invalid';
// or, if you want the reason:
try {
  phone.validate();
} on NumberTooShortException {
  return 'Too short';
}
```

**3. A custom `validator` no longer suppresses the length check.**
Both run, length first. If your validator was the only rule, keep it that way
explicitly:

```dart
IntlPhoneField(validator: myRule, disableLengthCheck: true)
```

**4. Async validators now display their message.**
An app that returned a message from an async validator was previously having it
silently discarded. Those errors will start appearing. Check the messages are
ones you want shown.

**5. Number lengths changed for 117 territories.**
They are now generated from libphonenumber. Numbers that used to validate may
now fail and vice versa — this is a correction, not a regression. Guernsey,
Isle of Man and Jersey went from 6 digits to 10 and lost their synthetic
`regionCode`. Cayman Islands moved from `+345` (not a dialable code) to
`+1 345`; Vatican City from `+379` to `+39`. Re-check hard-coded lengths and
golden tests.

**6. Flags render as images on Windows, Linux and web.**
Those platforms have no glyphs for regional-indicator emoji. Apple and Android
still use emoji. For one look everywhere:

```dart
flagBuilder: (context, country) =>
    CountryFlag(country: country, forceImage: true),
```

**7. `autofillHints` now lead with `AutofillHints.telephoneNumber`.**
Pass the list explicitly if you depended on the old order.

## D. To 1.0.0: `package:material_ui`

1.0.0 is built on `package:material_ui`, not `package:flutter/material.dart`.
The class names are the same but the types are not, so **the app must migrate
too** — a package-only upgrade is not possible:

* Compile error wherever a Material type is passed in: `decoration`,
  `buildCounter`, `PickerDialogStyle.searchFieldInputDecoration` —
  "The argument type 'InputDecoration' can't be assigned to the parameter type
  'InputDecoration'".
* Runtime error inside an SDK `MaterialApp`/`Scaffold`, even with no Material
  argument: "No Material widget found". `MaterialUiCompatibilityBridge` does not
  fix this; it only bridges the other way.

Steps:

1. Flutter 3.44 or newer; `environment: sdk: ">=3.12.0 <4.0.0"`. If that is not
   possible, stay on `flutter_intl_phone_field: ^0.1.2`.
2. Flutter 3.47+: `dart fix --apply --code=migrate_design_widgets` (adds
   `material_ui: any` — set it to `^1.0.0` — and rewrites imports). Flutter 3.44–3.46: that fix does not exist;
   add `material_ui: ^1.0.0` and replace every
   `import 'package:flutter/material.dart';` with
   `import 'package:material_ui/material_ui.dart';` by hand.
3. Replace the removed shims (`countries.dart`, `phone_number.dart`,
   `country_picker_dialog.dart`, `helpers.dart`) with the barrel import.
4. Replace `searchText:` with
   `localizations: IntlPhoneFieldLocalizations(searchHint: …)`.

## After migrating

Run `flutter analyze`. Any remaining `package:flutter/material.dart` import,
removed shim import or `searchText` argument shows up as an error there.

Full prose guide with before/after for every change:
<https://github.com/itsarvinddev/flutter_intl_phone_field/blob/main/MIGRATION.md>
