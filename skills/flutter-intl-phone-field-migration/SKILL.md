---
name: flutter-intl-phone-field-migration
description: >-
  Migrate Flutter code to flutter_intl_phone_field 0.1.x, either from the
  unrelated intl_phone_field package or from this package's own 0.0.x releases.
  Use when upgrading a phone number input, when a build breaks after bumping
  flutter_intl_phone_field, or when code mixes IntlPhoneField with an older
  API such as invalidNumberMessage, CountryPickerDialog or searchText.
---

# Migrating to flutter_intl_phone_field 0.1.x

Two different starting points. Identify which one the code is coming from by the
import, then apply that table.

```dart
import 'package:intl_phone_field/intl_phone_field.dart';        // -> section A
import 'package:flutter_intl_phone_field/phone_number.dart';    // -> section B
```

Apply section C in both cases: it covers behaviour that changed silently, which
no compiler will point at.

## A. From `intl_phone_field` (a different package)

The class is also called `IntlPhoneField`, so most of the widget tree survives.
Replace the dependency and the import first:

```yaml
dependencies:
  flutter_intl_phone_field: ^0.1.1   # remove intl_phone_field
```

```dart
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
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
constraint to `^0.1.1` is required — it will not upgrade on its own.

| Old | New |
| --- | --- |
| `import '…/countries.dart'`, `'…/phone_number.dart'`, `'…/country_picker_dialog.dart'`, `'…/helpers.dart'` | one barrel: `import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';` (old paths still resolve, deprecated, removed in 1.0.0) |
| `phone.number = x;` | `phone = phone.copyWith(number: x);` — `PhoneNumber` is immutable |
| `CountryPickerDialog(...)` | `showCountryPicker(...)` |
| `searchText:` | `localizations.searchHint` |
| `country.dialCode` (was `"1684"` for American Samoa) | `country.fullCountryCode` to build, `country.displayCC` to display. `dialCode` is now the true calling code, `"1"`. |
| `PhoneNumber.getCountry(n)` throwing `StateError` | it now falls back to India rather than throwing |

The minimum SDK is now Dart 3.4 / Flutter 3.22.

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

## After migrating

Run `flutter analyze`. Deprecation warnings on the old import paths are
expected and tell you exactly which files still need the barrel import.

Full prose guide with before/after for every change:
<https://github.com/itsarvinddev/flutter_intl_phone_field/blob/main/MIGRATION.md>
