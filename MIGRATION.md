# Migrating to 1.0.0

1.0.0 moves the package from the Flutter SDK's built-in Material library
(`package:flutter/material.dart`) to the standalone
[`package:material_ui`](https://pub.dev/packages/material_ui), which Flutter
decoupled from the SDK; the built-in copy is frozen and scheduled for
deprecation. Flutter's
[guidance for package authors](https://docs.flutter.dev/release/breaking-changes/material-ui-and-cupertino-ui#guidance-for-package-authors)
treats this as a major version bump, and so does this release. It also removes
everything 0.1.x deprecated.

Nothing about phone numbers changed: country data, validation, formatting and
`PhoneNumber` behave exactly as in 0.1.2.

## At a glance

| What changed | What to do |
| --- | --- |
| The package is built on `package:material_ui` | Migrate your app to `material_ui` — see below |
| Minimum SDK is Dart 3.12 / Flutter 3.44 | Raise your own constraint, or stay on `^0.1.2` |
| The deprecated import paths are gone | Import `package:flutter_intl_phone_field/flutter_intl_phone_field.dart` |
| `searchText` is gone | Use `localizations.searchHint` |

---

### Your app has to use `package:material_ui`

**Why.** Classes in `material_ui` have the same names as the SDK's, but they
are different types. That breaks an app still on `package:flutter/material.dart`
in two ways:

- **At compile time**, wherever you pass a Material type into the field:
  `decoration` and `PickerDialogStyle.searchFieldInputDecoration` take
  `material_ui`'s `InputDecoration`, and `buildCounter` takes its
  `InputCounterWidgetBuilder`. The SDK's `InputDecoration` is rejected with
  "The argument type 'InputDecoration' can't be assigned to the parameter type
  'InputDecoration'".
- **At runtime**, even if you pass none of them: the field's text field looks
  for `material_ui`'s `Material` ancestor, which an SDK `MaterialApp`/`Scaffold`
  does not provide. It fails with "No Material widget found".
  `MaterialUiCompatibilityBridge` does not help here — it only lets *old*
  widgets run inside a `material_ui` app, not the other way round.

```dart
// Before (0.1.x)
import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
```

```dart
// After (1.0.0)
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:material_ui/material_ui.dart';
```

```yaml
dependencies:
  flutter_intl_phone_field: ^1.0.0
  material_ui: ^1.0.0
```

**Automatable?** On Flutter 3.47 or newer, yes:

```bash
dart fix --apply --code=migrate_design_widgets
```

It rewrites the imports across your project and adds `material_ui: any` to
`pubspec.yaml` — change that to `^1.0.0`. On Flutter
3.44–3.46 that fix does not exist yet ("The diagnostic 'migrate_design_widgets'
is not defined by the analyzer"); replace the import by hand. See Flutter's
[migration guide](https://docs.flutter.dev/release/breaking-changes/material-ui-and-cupertino-ui)
for localization delegates and other app-level details.

---

### Minimum SDK is Dart 3.12 / Flutter 3.44

**Why.** `material_ui` 1.0.0 requires it.

```yaml
# After (1.0.0)
environment:
  sdk: ">=3.12.0 <4.0.0"
  flutter: ">=3.44.0"
```

**Automatable?** Yes — one line in your `pubspec.yaml`. If you cannot raise it,
stay on `^0.1.2`, which keeps working with `package:flutter/material.dart`.

---

### The deprecated import paths are removed

`package:flutter_intl_phone_field/countries.dart`, `phone_number.dart`,
`country_picker_dialog.dart` and `helpers.dart` were deprecated re-export shims
in 0.1.x. They are gone.

```dart
// After (1.0.0) — one import covers all of it
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
```

`helpers.dart` has no replacement: `isNumeric`, `removeDiacritics` and the
list extension were never part of the supported API.

**Automatable?** Yes — delete the extra import lines.

---

### `searchText` is removed

Deprecated since 0.1.0. Move the string to `localizations.searchHint`, or style
the whole search field with `PickerDialogStyle.searchFieldInputDecoration`.

```dart
// Before (0.1.x)
IntlPhoneField(searchText: 'Rechercher un pays');
```

```dart
// After (1.0.0)
IntlPhoneField(
  localizations: const IntlPhoneFieldLocalizations(
    searchHint: 'Rechercher un pays',
  ),
);
```

**Automatable?** Yes — a mechanical rename of the one argument.

---

# Migrating to 0.1.0

> **If you are coming from 0.0.7** — and you are, unless you tracked `main`:
> 0.0.8 was prepared in the repository but never published to pub.dev, so
> 0.1.0 is the first release after 0.0.7. Read "0.0.8" below as "the code
> before this release". Two of the changes described here never reached
> pub.dev at all, so there is nothing for you to migrate in them: the
> synthetic `regionCode` given to Guernsey, Isle of Man and Jersey, and the
> widening of Kenya's length to 9–10. Everything else applies to 0.0.7 exactly
> as written.

0.1.0 replaces the hand-maintained country table with data generated from
Google's libphonenumber metadata, and rewrites the widget on top of it. Country
data, validation lengths, formatting rules and country lookup all changed as a
result.

Most applications need one import line changed and nothing else. The list below
covers every breaking change: if your code is not doing one of these things, it
keeps compiling and behaving as before.

## At a glance

| What changed | What to do |
| --- | --- |
| `Country.dialCode` is now the true calling code — the area code moved out of it for +1 territories | Build numbers with `country.fullCountryCode`, show them with `country.displayCC` |
| Guernsey, Isle of Man and Jersey lost their synthetic `regionCode`; their length is 10, not 6 | Nothing, unless you hard-coded `441481` / `441624` / `441534` |
| 117 territories now accept a different range of numbers | Re-check any hard-coded lengths or golden-file tests |
| Cayman Islands is `+1 345` (was `+345`), Vatican City is `+39` (was `+379`) | Fix stored numbers that begin `+345` or `+379` |
| `PhoneNumber` fields are `final` | Replace field assignment with `copyWith` |
| `PhoneNumber.countryCode` always carries a leading `+` | Drop any `'+' + phone.countryCode` concatenation |
| The built-in length check now runs *alongside* a custom `validator` | Pass `disableLengthCheck: true` if you want only your own rule |
| Async validators now display their message | Make sure your async validator only returns messages you want shown |
| Default `autofillHints` lead with `telephoneNumber` | Nothing, or pass `autofillHints` explicitly to keep the old order |
| Flags render as PNG on Windows, Linux and web | Nothing; for the same look everywhere pass a `flagBuilder` returning `CountryFlag(..., forceImage: true)` |
| Minimum SDK is Dart 3.4 / Flutter 3.22 | Raise your own constraint, or stay on 0.0.7 |
| `searchText` is deprecated | Move the string to `localizations.searchHint` |
| Implementation moved under `lib/src/` behind one barrel | Import `package:flutter_intl_phone_field/flutter_intl_phone_field.dart` |
| `CountryPickerDialog` was replaced by `showCountryPicker` | Call `showCountryPicker(...)`, or embed `CountryPickerBody` |
| 43 countries' English display names changed | Re-check anything that matches on `Country.name` |

---

### `Country.dialCode` no longer contains the area code

**Why.** 0.0.8 stored the area code inside `dialCode` for North American
territories — American Samoa was `"1684"`, Antigua `"1268"` — so `dialCode` was
not a calling code at all, and `+1` matched the first `+1` entry in list order.
The calling code and the area code are now separate fields:
`dialCode` is `"1"`, `regionCode` is `"684"`, and `fullCountryCode` joins them.

Twenty-one +1 territories are affected. Jamaica and Puerto Rico have more than
one area code each (658/876 and 787/939), so they carry no `regionCode` at all:
their national number now includes the area code and is 10 digits long.

```dart
// Before (0.0.8) — American Samoa
country.dialCode; // "1684"
country.regionCode; // ""
final e164 = '+${country.dialCode}$national'; // "+16841234567"
```

```dart
// After (0.1.0) — American Samoa
country.dialCode; // "1"
country.regionCode; // "684"
country.fullCountryCode; // "1684"  -> use this to build a number
country.displayCC; // "1 684"  -> use this to show one
country.displayDialCode; // "+1684"

final e164 = '+${country.fullCountryCode}$national'; // "+16841234567"
```

The widget itself now renders `'+${country.displayCC}'`, so the selector shows
`+1 684` rather than `+1684`.

**Automatable?** Mostly. Replace `.dialCode` with `.fullCountryCode` wherever
you build a number and with `.displayCC` wherever you display one. Reads of
`dialCode` that genuinely mean "the calling code" — grouping by country code,
for instance — are now correct as they stand and should be left alone.

---

### Guernsey, Isle of Man and Jersey are ordinary +44 numbers

**Why.** 0.0.8 gave the Crown Dependencies a synthetic `regionCode`
(`1481`, `1624`, `1534`) and a 6-digit national number. That cannot work: a
Guernsey mobile is `+447781…` and carries no `1481` prefix at all, so those
numbers were unrepresentable, and every real +44 number was matched by list
order instead. All three are now plain `+44` with a 10-digit national number,
told apart from the United Kingdom by the leading digits of the national number
— the same way libphonenumber does it.

```dart
// Before (0.0.8)
country.regionCode; // "1481"
country.minLength; // 6
country.maxLength; // 6

final n = PhoneNumber.fromCompleteNumber(completeNumber: '+441481960194');
n.countryCode; // "441481"
n.number; // "960194"

// A Guernsey mobile was reported as British:
PhoneNumber.fromCompleteNumber(completeNumber: '+447781123456').countryISOCode;
// "GB"
```

```dart
// After (0.1.0)
country.regionCode; // ""
country.minLength; // 10
country.maxLength; // 10
country.leadingDigits; // ["1481", "7781", "7839"]

final n = PhoneNumber.fromCompleteNumber(completeNumber: '+441481960194');
n.countryCode; // "+44"
n.number; // "1481960194"

PhoneNumber.fromCompleteNumber(completeNumber: '+447781123456').countryISOCode;
// "GG"
```

**Automatable?** No, but usually nothing to do: the complete number is
unchanged either way. Act only if you stored the split parts, or if you
hard-coded `441481`, `441624` or `441534`.

---

### 117 territories now accept a different range of numbers

**Why.** The lengths in 0.0.8 were maintained by hand and had drifted. Twelve
territories — Åland Islands, Bouvet Island, Christmas Island, Cocos Islands,
French Guiana, French Southern Territories, Guadeloupe, Heard & McDonald
Islands, Martinique, Norfolk Island, Puerto Rico and South Georgia — sat at a
placeholder `15/15`, so every real number for them was rejected. The new
ranges come from libphonenumber's `possibleLengths` and are correct.

Of the 243 territories that existed in 0.0.8, 120 had their `minLength` or
`maxLength` field changed, and for 117 of those the range of numbers actually
accepted changed too (the other three only moved digits between `regionCode`
and `minLength`). Most ranges widened; 46 became stricter at one end, so a
number that used to validate may now fail.

```dart
// Before (0.0.8)          // After (0.1.0)
// Germany       9–13      // Germany       5–13
// China        11–12      // China          7–11
// Italy         9–10      // Italy          6–12
// Brazil       11–11      // Brazil        10–11
// Kenya         9–10      // Kenya          7–9
// Nigeria      10–11      // Nigeria       10–10
// United Kingdom 10–10    // United Kingdom 9–10
// Argentina    12–12      // Argentina     10–11
// Puerto Rico  15–15      // Puerto Rico   10–10
```

If a plain length range is too loose for you, 0.1.0 adds a pattern check:

```dart
IntlPhoneField(strictValidation: true); // must match an assigned range
phoneNumber.isValidNumber(strict: true);
```

**Automatable?** No. Re-run your own validation fixtures and expect a handful
of expectations to move.

---

### Cayman Islands is `+1 345`, Vatican City is `+39`

**Why.** Both were wrong, and the Cayman Islands entry was unreachable: `+345`
is not an assigned calling code, so no real number could ever match it. The
Cayman Islands are part of the North American Numbering Plan (`+1 345`), and
the Vatican is reached on Italy's `+39`.

```dart
// Before (0.0.8)
PhoneNumber.fromCompleteNumber(completeNumber: '+3453231234').countryISOCode;
// "KY"
PhoneNumber.fromCompleteNumber(completeNumber: '+3791234567').countryISOCode;
// "VA"
```

```dart
// After (0.1.0)
PhoneNumber.fromCompleteNumber(completeNumber: '+13453231234').countryISOCode;
// "KY"

// Vatican numbers are Italian numbers and are reported as such; Vatican City
// remains selectable in the picker.
PhoneNumber.fromCompleteNumber(completeNumber: '+390669812345').countryISOCode;
// "IT"

// The old strings no longer mean what they used to. "+345…" is now read as a
// Spanish number, because "34" is Spain's calling code and "345" is nobody's:
PhoneNumber.fromCompleteNumber(completeNumber: '+3453231234').countryISOCode;
// "ES"

// "+379…" matches no calling code at all:
PhoneNumber.fromCompleteNumber(completeNumber: '+3791234567').countryISOCode;
// ""
```

**Automatable?** Yes for stored data — rewrite `+345…` to `+1345…`. Vatican
numbers stored as `+379…` need the real `+39` number; there is no mechanical
translation, because `379` was never a valid prefix.

---

### `PhoneNumber` is immutable

**Why.** `countryISOCode`, `countryCode` and `number` were mutable, so a value
handed to `onChanged` could be edited underneath the widget. They are `final`
now, and the class has `==`, `hashCode`, `copyWith`, `toJson` and `fromJson`.

```dart
// Before (0.0.8)
void normalise(PhoneNumber phone) {
  phone.number = phone.number.replaceAll(' ', '');
}
```

```dart
// After (0.1.0)
PhoneNumber normalise(PhoneNumber phone) {
  return phone.copyWith(number: phone.number.replaceAll(' ', ''));
}
```

**Automatable?** Mechanical but not a regex: each `phone.field = value` becomes
`phone = phone.copyWith(field: value)`, and the surrounding variable has to be
reassignable. The compiler finds every site for you.

---

### `PhoneNumber.countryCode` always carries a leading `+`

**Why.** 0.0.8 was inconsistent with itself: the widget produced
`countryCode: '+44'`, while `PhoneNumber.fromCompleteNumber` produced `'44'`,
which made `completeNumber` lose its `+`. One form is now used everywhere.

```dart
// Before (0.0.8)
final n = PhoneNumber.fromCompleteNumber(completeNumber: '+447400123456');
n.countryCode; // "44"
n.completeNumber; // "447400123456"
```

```dart
// After (0.1.0)
final n = PhoneNumber.fromCompleteNumber(completeNumber: '+447400123456');
n.countryCode; // "+44"
n.completeNumber; // "+447400123456"
```

A value passed in without the `+` is still accepted and normalised.

**Automatable?** Yes — delete any `'+' + phone.countryCode` or
`'+${phone.countryCode}'` you wrote to work around the old behaviour.

---

### The built-in length check runs even when you supply a validator

**Why.** The documentation said the length check ran unless
`disableLengthCheck` was set, but the code skipped it entirely whenever
`validator` was non-null — so adding "is this number on our blocklist?" quietly
turned off length validation. Both now run: the length check first, then your
validator.

```dart
// Before (0.0.8): only your rule ran; 3-digit numbers were accepted
IntlPhoneField(
  validator: (phone) => blocked.contains(phone?.number) ? 'Blocked' : null,
);
```

```dart
// After (0.1.0): the length check runs first, then your rule
IntlPhoneField(
  validator: (phone) => blocked.contains(phone?.number) ? 'Blocked' : null,
);

// To keep the old behaviour and own validation entirely:
IntlPhoneField(
  disableLengthCheck: true,
  validator: (phone) => blocked.contains(phone?.number) ? 'Blocked' : null,
);
```

**Automatable?** No — decide per field whether you want `disableLengthCheck`.

---

### Async validators now actually display their message

**Why.** An async validator's `Future` was assigned inside a `.then()` that
nobody read, and `null` was returned to the `Form` — so the message never
appeared and the form counted as valid. The result is now stored and the field
re-validated when the future settles.

```dart
// Before (0.0.8): this message was computed and thrown away
IntlPhoneField(
  validator: (phone) async {
    final taken = await api.isTaken(phone!.completeNumber);
    return taken ? 'Already registered' : null;
  },
);
```

```dart
// After (0.1.0): identical code, and the message is shown
IntlPhoneField(
  validator: (phone) async {
    final taken = await api.isTaken(phone!.completeNumber);
    return taken ? 'Already registered' : null;
  },
);
```

**Automatable?** No, and no code change is needed — but errors your app was
silently swallowing will start appearing, so re-read what your async validator
returns.

---

### Default `autofillHints` order changed

**Why.** iOS and macOS QuickType only honour the first hint. Leading with
`telephoneNumberNational` therefore offered the user a national number for a
field that wants the full one, and in practice disabled the suggestion.

```dart
// Before (0.0.8), the default was:
const [
  AutofillHints.telephoneNumberNational,
  AutofillHints.telephoneNumber,
];
```

```dart
// After (0.1.0), the default is:
const [
  AutofillHints.telephoneNumber,
  AutofillHints.telephoneNumberNational,
];

// Pass them yourself to keep the old order:
IntlPhoneField(
  autofillHints: const [
    AutofillHints.telephoneNumberNational,
    AutofillHints.telephoneNumber,
  ],
);
```

**Automatable?** Yes, if you want the old order — one explicit parameter.

---

### Flags render as PNG on Windows, Linux and web

**Why.** 0.0.8 used the bundled PNG on web and a regional-indicator emoji
everywhere else. Windows and Linux have no glyphs for those emoji, so users saw
two letters or tofu. `CountryFlag` now picks the image on any platform that
cannot draw the emoji, and falls back image → emoji → ISO code rather than
letting a missing asset red-screen the app.

```dart
// Before (0.0.8): emoji text on Windows and Linux, PNG on web
```

```dart
// After (0.1.0): PNG on web, Windows, Linux and Fuchsia; emoji on
// Android, iOS and macOS. Force one look everywhere with:
CountryFlag(country: country, forceImage: true);

// Shape and size are configurable on the field itself:
IntlPhoneField(flagShape: FlagShape.circle, flagSize: 28);
```

Two newly added territories, Ascension Island and Tristan da Cunha, ship no
PNG of their own and fall back to the emoji or their ISO code.

**Automatable?** No, and nothing to do unless you were relying on the flag
being selectable text.

---

### Minimum SDK is Dart 3.4 / Flutter 3.22

**Why.** The old `">=2.12.0"` constraint pinned the *package's* language
version to 2.12, which made every Dart 3 feature a compile error inside it,
while the source already used far newer Flutter APIs.

```yaml
# Before (0.0.8)
environment:
  sdk: ">=2.12.0 <4.0.0"
```

```yaml
# After (0.1.0)
environment:
  sdk: ">=3.4.0 <4.0.0"
  flutter: ">=3.22.0"
```

**Automatable?** Yes — one line in your `pubspec.yaml`. If you cannot raise it,
stay on 0.0.8.

---

### `searchText` is deprecated in favour of `localizations.searchHint`

**Why.** Every user-facing string is now in one place,
`IntlPhoneFieldLocalizations`, with no dependency on `intl` or generated
delegates. `searchText` kept working through 0.1.x and was removed in 1.0.0.

```dart
// Before (0.0.8)
IntlPhoneField(searchText: 'Rechercher un pays');
```

```dart
// After (0.1.0)
IntlPhoneField(
  localizations: const IntlPhoneFieldLocalizations(
    searchHint: 'Rechercher un pays',
    invalidNumber: 'Numéro invalide',
    requiredNumber: 'Veuillez saisir un numéro',
    noCountriesFound: 'Aucun pays trouvé',
  ),
);
```

**Automatable?** Yes — a mechanical rename of the one argument.

---

### Import paths moved under `lib/src/` behind a barrel

**Why.** The package exported four top-level files, which made every internal
helper part of its public API. Everything now lives in `lib/src/` behind a
single export. The old paths kept resolving through 0.1.x as deprecated
re-export shims and were removed in 1.0.0.

```dart
// Before (0.0.8)
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_intl_phone_field/countries.dart';
import 'package:flutter_intl_phone_field/phone_number.dart';
import 'package:flutter_intl_phone_field/country_picker_dialog.dart';
```

```dart
// After (0.1.0) — one import covers all of it
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
```

`helpers.dart` is the exception: `isNumeric`, `removeDiacritics` and the
`stringSearch` extension were never meant to be public, and the shim is
deprecated without a replacement.

**Automatable?** Yes — delete the three extra import lines.

---

### `CountryPickerDialog` was replaced by `showCountryPicker`

**Why.** The picker was a widget you had to host and feed a pre-filtered list
to. It is now a function that returns the chosen country, plus
`CountryPickerBody` for embedding the list in your own route.

```dart
// Before (0.0.8)
showDialog(
  context: context,
  builder: (_) => CountryPickerDialog(
    countryList: countries,
    filteredCountries: countries,
    selectedCountry: selected,
    languageCode: 'en',
    searchText: 'Search country',
    onCountryChanged: (c) => setState(() => selected = c),
  ),
);
```

```dart
// After (0.1.0)
final country = await showCountryPicker(
  context: context,
  countries: countries,
  selectedCountry: selected,
  dialogType: DialogType.showModalBottomSheet,
);
if (country != null) setState(() => selected = country);
```

**Automatable?** No — the call shape is different, but it is a single call site
in most apps. Only affects you if you built your own picker UI; using
`IntlPhoneField` alone needs no change.

---

### 43 country display names changed

**Why.** The `name` field disagreed with the English translation that was
actually rendered. Italy was named `"Campione d'Italia"` — an exclave of about
two thousand people — and forty-two more carried mangled ISO long-forms.
`name` now matches the displayed English name, and a test keeps the two in
step.

```dart
// Before (0.0.8)
"Campione d'Italia"                          // IT
"Bolivia, Plurinational State of bolivia"    // BO
"Congo, The Democratic Republic of the Congo" // CD
"Czech Republic"                             // CZ
"Holy See (Vatican City State)"              // VA
```

```dart
// After (0.1.0)
"Italy"            // IT
"Bolivia"          // BO
"Congo - Kinshasa" // CD
"Czechia"          // CZ
"Vatican City"     // VA
```

**Automatable?** No. Match on `Country.code` rather than `Country.name` — the
ISO code is stable and the display name is not.

---

## Nothing to do if…

*For 0.0.x → 0.1.x only. Going on to 1.0.0, also apply
[Migrating to 1.0.0](#migrating-to-100) — it changes `decoration` and the
minimum SDK.*

- You use `IntlPhoneField` with `initialCountryCode`, `onChanged` and
  `validator`, and read `phone.completeNumber`. That path is unchanged, apart
  from the corrected lengths and country lookup behind it.
- You store complete E.164 numbers rather than the split parts. `+447781123456`
  means the same thing in both versions; only the country it is attributed to
  and the way it splits have improved.
- You never read `Country.dialCode`, `Country.regionCode`, `Country.minLength`
  or `Country.maxLength` directly.
- You never assign to a `PhoneNumber` field.
- You already import only
  `package:flutter_intl_phone_field/flutter_intl_phone_field.dart`.
- You already pass your own `autofillHints`, `inputFormatters` or
  `decoration`.
- You are on Dart 3.4 / Flutter 3.22 or newer, which is anything released from
  May 2024 onwards.

Everything else in the 0.1.0 release — as-you-type formatting,
`PhoneController`, flag shapes, favourite/only/exclude country lists, the
draggable-sheet and full-page pickers, example numbers as hints, and country
detection on paste — is opt-in and changes nothing until you ask for it. See
the [CHANGELOG](CHANGELOG.md) for the full list.
