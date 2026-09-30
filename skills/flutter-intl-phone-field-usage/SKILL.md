---
name: flutter-intl-phone-field-usage
description: >-
  Write correct flutter_intl_phone_field code. Use whenever building an
  international phone number input in Flutter, or when code mentions
  IntlPhoneField, PhoneNumber, PhoneController, CountryFlag or a country
  picker. Corrects the API remembered from the unrelated intl_phone_field
  package, from this package's own 0.0.x/0.1.x releases, and from
  package:flutter/material.dart (this package is built on package:material_ui).
---

# flutter_intl_phone_field

An international phone number `TextFormField` with a country picker. This skill
describes the **1.x** series, which is built on `package:material_ui`
(Flutter 3.44+), not on the SDK's `package:flutter/material.dart`. Country
data — calling codes, national number lengths, validation patterns, formatting
rules — is generated from Google's libphonenumber, so it covers 251
territories.

## Do not reach for these

These are the mistakes a model makes from memory. The first three compile and
are silently wrong, so they matter most.

| Do not write | Write instead | Why |
| --- | --- | --- |
| `'+${phone.countryCode}${phone.number}'` | `phone.completeNumber` | `countryCode` **already carries the `+`**. Concatenating yields `++919876543210`, which compiles, passes analysis, and corrupts stored numbers. |
| `try { phone.isValidNumber() } on NumberTooShortException { … }` | `if (!phone.isValidNumber()) { … }` | `isValidNumber()` returns `bool` and never throws. The throwing variant is `phone.validate()`. |
| `country.dialCode` to build a number | `country.fullCountryCode` to build, `country.displayCC` to show | For Antigua, `dialCode` is `"1"`, `regionCode` is `"268"`, `fullCountryCode` is `"1268"` and `displayCC` is `"1 268"`. `dialCode` alone is not dialable. |
| `import 'package:intl_phone_field/intl_phone_field.dart'` | `import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart'` | Different package. The names overlap; the APIs do not. |
| `import 'package:flutter/material.dart'` | `import 'package:material_ui/material_ui.dart'` | The package is built on `material_ui`: the SDK's `InputDecoration` is a different type, and an SDK `MaterialApp` gives "No Material widget found". |
| `import 'package:flutter_intl_phone_field/countries.dart'` | the single barrel above | Everything is exported from one file. The old top-level paths were removed in 1.0.0. |
| `invalidNumberMessage:` | `invalidMessage:` | Parameter is named `invalidMessage`. |
| `phone.number = '555'` | `phone.copyWith(number: '555')` | `PhoneNumber` is immutable with a `const` constructor. |
| `CountryPickerDialog(...)` | `showCountryPicker(...)`, or embed `CountryPickerBody` | The widget was replaced by a function. |
| `searchText: 'Search'` | `localizations: IntlPhoneFieldLocalizations(searchHint: 'Search')` | `searchText` was removed in 1.0.0. |

Two more that produce surprising behaviour rather than errors:

* A custom `validator` **does not replace** the built-in length check — both run,
  length first. Pass `disableLengthCheck: true` if you want only your own rule.
* The field edits the **national** part of the number. `phone.number` never
  contains the calling code.

## Minimal example

This compiles as written.

```dart
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:material_ui/material_ui.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  PhoneNumber? _phone;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          IntlPhoneField(
            initialCountryCode: 'US',
            decoration: const InputDecoration(
              labelText: 'Phone number',
              border: OutlineInputBorder(),
            ),
            onChanged: (PhoneNumber phone) => _phone = phone,
            onSaved: (PhoneNumber? phone) => _phone = phone,
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                debugPrint(_phone!.completeNumber); // +12015550123
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
```

## Reading the value

```dart
onChanged: (PhoneNumber phone) {
  phone.countryISOCode;          // 'US'
  phone.countryCode;             // '+1'   (includes the +)
  phone.number;                  // '2015550123'  (national part only)
  phone.completeNumber;          // '+12015550123' — send this to your backend
  phone.isValidNumber();         // bool
  phone.isValidNumber(strict: true); // also requires a real assigned range
  phone.toJson();                // {countryISOCode, countryCode, number}
}
```

Parse a number you already have:

```dart
// Never throws; unparseable input comes back with empty country fields.
final a = PhoneNumber.fromCompleteNumber(completeNumber: '+447400123456');

// Throws InvalidCharactersException / NumberTooShortException on failure.
final b = PhoneNumber.parse('+447400123456');
```

## Validation

```dart
IntlPhoneField(
  initialCountryCode: 'GB',
  // Runs AFTER the built-in length check, which you get for free.
  validator: (PhoneNumber? phone) {
    if (phone == null || phone.number.isEmpty) return 'Required';
    if (!phone.isValidNumber(strict: true)) return 'Not a real number';
    return null;
  },
  invalidMessage: 'That is not a valid number',
)
```

Async validators are supported and their message is displayed when the future
completes:

```dart
validator: (PhoneNumber? phone) async {
  if (phone == null || !phone.isValidNumber()) return null;
  return await api.isTaken(phone.completeNumber) ? 'Already registered' : null;
},
```

## Pre-filling a value

`initialValue` holds the **national** number. A value starting with `+` or `00`
is treated as international and its country code is stripped.

```dart
IntlPhoneField(initialCountryCode: 'AE', initialValue: '501234567'),
IntlPhoneField(initialValue: '+971501234567'), // country detected from the number
```

If a national number's leading digits happen to match the dial code — a UAE
number starting `971` — say so outright rather than relying on the heuristic:

```dart
IntlPhoneField(
  initialCountryCode: 'AE',
  initialValue: '971123456',
  initialValueFormat: InitialValueFormat.national, // never strip
)
```

## Controlling the field from outside

```dart
final controller = PhoneController.fromCompleteNumber('+447400123456');
// ...
IntlPhoneField(phoneController: controller)
// ...
controller.country = someCountry;   // switch country, keep the number
controller.number = '7911123456';   // replace the number
controller.completeNumber;          // read it back
controller.isValid;
controller.clear();
controller.dispose();               // it is a ValueNotifier
```

## As-you-type formatting

Opt in. What is displayed is formatted; what `onChanged` reports is always
digits only.

```dart
IntlPhoneField(initialCountryCode: 'US', formatInput: true)
// displays (201) 555-0123, reports number: '2015550123'
```

## Curating the country list

```dart
IntlPhoneField(
  favoriteCountries: <String>['IN', 'US', 'GB'], // pinned on top
  onlyCountries: <String>['US', 'CA', 'MX'],     // whitelist
  excludeCountries: <String>['RU'],              // blacklist
)
```

## Picker presentation

```dart
IntlPhoneField(dialogType: DialogType.showModalBottomSheet)
```

`DialogType` is one of `showDialog` (default), `showModalBottomSheet`,
`showDraggableBottomSheet`, `showFullScreenPage`, `adaptive`.

Style it with `PickerDialogStyle`, which also controls the search field,
favourites and flag shape in the list.

## Customising the selector

```dart
IntlPhoneField(
  showCountryFlag: true,      // independent
  showCountryCode: false,     // independent
  showDropdownIcon: false,    // hides the arrow
  flagShape: FlagShape.circle, // rectangle, rounded, square, circle
  flagSize: 26,
)
```

Replace a part, or the whole selector:

```dart
IntlPhoneField(
  flagBuilder: (context, country) => CountryFlag(country: country, size: 24),
  dialCodeBuilder: (context, country) => Text('+${country.displayCC}'),
  countrySelectorBuilder: (context, country, openPicker) => TextButton(
    onPressed: openPicker,                     // call this to open the picker
    child: Text('+${country.displayCC}'),
  ),
)
```

## Localization

No generated delegates needed. Country names come from CLDR via
`languageCode`; the package's own strings come from `localizations`.

```dart
IntlPhoneField(
  languageCode: 'fr',
  localizations: const IntlPhoneFieldLocalizations(
    searchHint: 'Rechercher un pays',
    invalidNumber: 'Numéro invalide',
    requiredNumber: 'Numéro requis',
  ),
)
```

## Reference

* Every constructor parameter: `references/parameters.md` next to this file.
* Canonical, always-current symbol index:
  <https://pub.dev/documentation/flutter_intl_phone_field/latest/index.json>
* Upgrading existing code: see the `flutter-intl-phone-field-migration` skill.
