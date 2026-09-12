# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0] - 2026-09-12

Country data is now generated from Google's libphonenumber metadata, with
localised names from the Unicode CLDR, and the widget, picker and models were
rewritten on top of it. See [MIGRATION.md](MIGRATION.md) for an upgrade guide.

### Breaking

- `Country.dialCode` is the true calling code. Twenty-one +1 territories that
  used to carry an area code inside it — American Samoa was `"1684"`, Antigua
  `"1268"` — now have `dialCode: "1"` with the area code in `regionCode`. Use
  `Country.fullCountryCode` (`"1684"`) to build a number and
  `Country.displayCC` (`"1 684"`) to show one.
- Jamaica and Puerto Rico have several area codes each, so they carry no
  `regionCode`: their national number now includes the area code and is 10
  digits.
- Guernsey, Isle of Man and Jersey no longer use a synthetic `regionCode`
  (`1481` / `1624` / `1534`). They are +44 with a 10-digit national number,
  told apart from the United Kingdom by leading digits. Their `minLength` and
  `maxLength` changed from 6 to 10.
- 120 of the 243 territories present in 0.0.8 had their `minLength` /
  `maxLength` corrected from libphonenumber. For 117 of them the range of
  numbers the field accepts genuinely changed, so numbers that used to
  validate may now fail, and vice versa; for the other three only the split
  between `dialCode` and `minLength` moved.
- Cayman Islands moved from `+345`, which is not an assigned calling code and
  so could never match a real number, to `+1 345`. Vatican City moved from
  `+379` to `+39`; Vatican numbers are reported as Italian, as libphonenumber
  reports them.
- `PhoneNumber` is immutable — its fields are `final`. Use `copyWith` instead
  of assigning to them.
- `PhoneNumber.countryCode` always carries a leading `+`, so
  `PhoneNumber.fromCompleteNumber` now agrees with the widget and
  `completeNumber` keeps its `+`.
- The built-in length check runs even when a custom `validator` is supplied;
  0.0.8 skipped it entirely, contradicting its own documentation. Pass
  `disableLengthCheck: true` to own validation completely.
- Async validators now display their message. Errors an app was previously
  swallowing will start appearing.
- The default `autofillHints` lead with `AutofillHints.telephoneNumber` rather
  than `telephoneNumberNational`, because iOS and macOS QuickType only honour
  the first hint.
- `CountryPickerDialog` was replaced by the `showCountryPicker` function and
  the embeddable `CountryPickerBody`.
- 41 countries' English `name` changed to match the English translation that
  was actually being displayed: Italy was named `"Campione d'Italia"`, and
  forty more carried mangled ISO long-forms such as
  `"Bolivia, Plurinational State of bolivia"`. Match on `Country.code`.
- The minimum SDK is Dart 3.4 / Flutter 3.22. The old `">=2.12.0"` constraint
  pinned the package's language version to 2.12, making every Dart 3 feature a
  compile error inside it.

### Added

- Eight missing territories: Cape Verde, Kosovo, Curaçao, Sint Maarten,
  Western Sahara, Bonaire, Ascension Island and Tristan da Cunha — 251 in all.
- `CountryResolver`, which matches on the calling code and then on the leading
  digits of the national number, the way libphonenumber does. Every fixed-line
  and mobile example number libphonenumber publishes — 489 of them, covering
  all 251 territories — resolves to the right country and validates, asserted
  by a generated test fixture.
- As-you-type national formatting, opt-in via `formatInput`, driven by
  libphonenumber's formatting rules: `2015550123` renders as `(201) 555-0123`.
  Exposed as `AsYouTypeFormatter` and `PhoneInputFormatter`.
- Per-country validation patterns, and `strictValidation` on the field plus
  `isValidNumber(strict: true)` on `PhoneNumber`, to require that a number fall
  in an assigned fixed-line or mobile range rather than merely be the right
  length.
- `PhoneController`, a `ValueNotifier<PhoneNumber>` for reading and driving the
  field from outside the widget, with `fromCompleteNumber` and `fromParts`
  constructors.
- `PhoneNumber.parse`, which throws on failure, alongside the
  non-throwing `fromCompleteNumber`; `validate()`, which throws
  `NumberTooShortException`, `NumberTooLongException` or
  `InvalidCharactersException`; and `copyWith`, `==`, `hashCode`, `toJson` and
  `fromJson`.
- `Country.fullCountryCode`, `displayCC`, `displayDialCode`, `localizedName`,
  `example`, `nationalPrefix`, `leadingDigits`, `areaCodes`,
  `isMainCountryForDialCode`, `autoDetectable`, `copyWith` and `==`.
- `CountryFlag` widget with `FlagShape.rectangle`, `rounded`, `square` and
  `circle`, a `forceImage` escape hatch, and `flagShape` / `flagSize` on both
  the field and `PickerDialogStyle`.
  ([#17](https://github.com/itsarvinddev/flutter_intl_phone_field/issues/17))
- `flagBuilder`, `dialCodeBuilder` and `countrySelectorBuilder` on
  `IntlPhoneField`, so the flag, the dial code or the whole selector — dropdown
  arrow included — can be replaced outright.
  ([#17](https://github.com/itsarvinddev/flutter_intl_phone_field/issues/17),
  [#18](https://github.com/itsarvinddev/flutter_intl_phone_field/issues/18))
- `onlyCountries`, `excludeCountries` and `favoriteCountries` for controlling
  and pinning entries in the picker.
- `IntlPhoneFieldLocalizations`: every built-in string in one place, with no
  dependency on `intl` or generated delegates.
- `DialogType.showDraggableBottomSheet`, `showFullScreenPage` and `adaptive`
  join `showDialog` and `showModalBottomSheet`.
- `PickerDialogStyle.autofocusSearchField`, `showSearchClearButton` and
  `selectedTileColor`.
- `showExampleAsHint`, which uses the country's real example number as the
  field's hint text.
- `detectCountryOnPaste`, which switches country when a full international
  number is pasted into the field.
- `InitialValueFormat` (`auto`, `national`, `international`), which says
  outright how `initialValue` should be read.
- `restorationId`, forwarded to the underlying `TextFormField`.
- `MIGRATION.md`, and a `.pubignore` so the published archive carries neither
  the example app's platform folders nor the `test/` and `tool/` directories.

### Fixed

- A national `initialValue` whose leading digits matched the dial code had
  those digits silently stripped — a UAE `971123456` became `123456`. The
  country code is now removed only when the value is unambiguously
  international.
  ([#19](https://github.com/itsarvinddev/flutter_intl_phone_field/issues/19))
- `PhoneNumber.getCountry()` threw `StateError` on an unknown code, because it
  scanned with `firstWhere` and no `orElse`. It now falls back to India, as its
  documentation always claimed.
- The first-match scan made roughly thirty countries unreachable: the United
  States resolved to Canada, Russia to Kazakhstan, Norway to Bouvet Island.
- Twelve territories sat at a placeholder length of 15/15 — Åland Islands,
  Bouvet Island, Christmas Island, Cocos Islands, French Guiana, French
  Southern Territories, Guadeloupe, Heard & McDonald Islands, Martinique,
  Norfolk Island, Puerto Rico and South Georgia — so every real number for
  them was rejected.
- `initState` cast `(value as Future)` and threw when a validator returned
  `null`.
- `didUpdateWidget` was absent, so `initialValue`, `initialCountryCode` and
  `countries` were dead after the first frame.
- Changing country never fired `onChanged`, leaving the parent with a stale
  country code, and could leave more digits in the field than the new country
  allows.
- `disableLengthCheck` still capped typing at the country maximum.
- `initialCountryCode` accepted a dial code per its documentation but matched
  only ISO codes, silently falling back to the first country.
- Flag emoji were used everywhere except web; Windows and Linux have no glyphs
  for them and showed two letters or tofu. `CountryFlag` now picks the bundled
  PNG on those platforms and falls back image → emoji → ISO code, so a missing
  asset cannot red-screen the app.
- Seven flag PNGs matched no country and were removed: `an` (Netherlands
  Antilles, dissolved in 2010), `eu`, `um` and the four Great Britain
  subdivisions.
- Dial codes rendered as `971+` in RTL layouts.
- The picker searched dial codes with `contains`, so `44` matched Angola, and a
  leading `+` matched nothing at all. The diacritics table was misaligned and
  folded `o` to `ö`.
- `debugPrint` logged the user's full phone number in release builds.
- The bottom sheet nested a `Dialog` inside itself and ignored
  `PickerDialogStyle.heightFactor`.

### Changed

- The implementation moved to `lib/src/` behind a single barrel export,
  `package:flutter_intl_phone_field/flutter_intl_phone_field.dart`. Every old
  top-level import path still resolves as a deprecated re-export shim.
- The selector shows `+1 684` rather than `+1684`, using `Country.displayCC`.
- The country-lookup rewrite was inspired by
  [JustifiedTech's PR #20](https://github.com/itsarvinddev/flutter_intl_phone_field/pull/20),
  which first identified that a first-match scan over a shared calling code
  cannot attribute a number correctly.

### Deprecated

- `IntlPhoneField.searchText`. Use `localizations.searchHint`, or
  `PickerDialogStyle.searchFieldInputDecoration`. Removed in 1.0.0.
- The top-level import paths `countries.dart`, `phone_number.dart`,
  `country_picker_dialog.dart` and `helpers.dart`. Removed in 1.0.0;
  `helpers.dart` has no replacement, as those utilities were never meant to be
  public.

## [0.0.8] - 2026-09-12

### Added

- `showCountryCode`, to hide the dial code while keeping the flag visible.
  ([#6](https://github.com/itsarvinddev/flutter_intl_phone_field/issues/6))
- `PickerDialogStyle.searchFieldStyle`, for the text style — colour, size and
  the rest — of the picker's search field.
  ([#3](https://github.com/itsarvinddev/flutter_intl_phone_field/issues/3))
- `onTapOutside`, to unfocus the field or run custom logic when the user taps
  away, plus `PickerDialogStyle.heightFactor` and
  `scrollViewKeyboardDismissBehavior` for the bottom sheet. Thanks to
  [@bibek-saha-boon](https://github.com/bibek-saha-boon) of Boon Infomate
  Private Limited (#13).
- Russian country-name translations. Thanks to
  [@orozDev](https://github.com/orozDev) (#7).
- Tests for the Kenya, United Kingdom and Crown Dependency number lengths and
  for `searchFieldStyle`.

### Fixed

- United Kingdom +44 numbers were validated as Guernsey numbers, because
  Guernsey came first in the list and both carried a bare `44`. Region codes
  were added for the Crown Dependencies — Guernsey `1481`, Isle of Man `1624`,
  Jersey `1534` — and the widget was made to use `fullCountryCode` consistently
  when building a `PhoneNumber`. (Superseded in 0.1.0 by leading-digit
  matching, which also handles Guernsey mobiles.)
  ([#4](https://github.com/itsarvinddev/flutter_intl_phone_field/issues/4))
- Kenyan mobile numbers were rejected: the length was 9, which excluded the
  local format carrying the trunk prefix. Widened to 9–10. Thanks to
  [@NOVACOAX](https://github.com/NOVACOAX) (#8). (Corrected again in 0.1.0 to
  libphonenumber's 7–9.)
  ([#5](https://github.com/itsarvinddev/flutter_intl_phone_field/issues/5))
- The Syrian flag was updated to the post-Assad independence flag. Thanks to
  [@Nidal-Bakir](https://github.com/Nidal-Bakir) (#15).
  ([#14](https://github.com/itsarvinddev/flutter_intl_phone_field/issues/14))

## [0.0.7] - 2025-03-14

### Changed

- `initState` uses `Future.microtask` to initialise the country list and phone
  number.

## [0.0.6] - 2025-03-14

### Fixed

- [#1](https://github.com/itsarvinddev/flutter_intl_phone_field/issues/1):
  language code handling.
- [#2](https://github.com/itsarvinddev/flutter_intl_phone_field/issues/2):
  validation messages.

## [0.0.5] - 2025-03-14

### Fixed

- `Future.microtask()` added to `initState()` to avoid a
  `setState() or markNeedsBuild() called during build` error.

## [0.0.4] - 2024-03-30

### Changed

- Dependencies updated.

## [0.0.3] - 2024-03-30

### Fixed

- Error exception handled.

## [0.0.2] - 2024-03-30

### Changed

- `README.md` updated.

## [0.0.1] - 2024-03-30

### Added

- A custom phone input `TextFormField`.
