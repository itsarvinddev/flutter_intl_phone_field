# `tool/`

Developer scripts and notes for maintaining `flutter_intl_phone_field`. Nothing
in this directory ships with the package — it is excluded from the published
archive and is never imported by `lib/`.

## Generated files — do not hand-edit

Four files in this repository are produced from upstream data rather than
written by hand. Each carries a `GENERATED FILE -- DO NOT EDIT BY HAND.` header.

| File | Contents | Entries |
| --- | --- | --- |
| `lib/src/countries.dart` | The `countries` list: name, localised names, flag emoji, ISO code, dial code, area code, national-number length range, example number, national prefix, leading digits | 251 countries |
| `lib/src/country_patterns.dart` | `countryNumberPatterns`: one validation regex per territory, covering fixed-line and mobile ranges | 245 territories |
| `lib/src/number_formats.dart` | `countryNumberFormats`: ordered national formatting rules that drive as-you-type formatting | 201 territories |
| `test/libphonenumber_examples.dart` | `libphonenumberExamples`: every published example number paired with the ISO code the resolver must return | 489 pairs |

Hand-editing any of these is a bug: the next regeneration silently reverts the
change, and the dataset invariants asserted by `test/country_data_test.dart`
exist precisely because the data is expected to round-trip from upstream. If a
country's data is wrong, fix it upstream (or fix the generator's handling of it)
and regenerate.

## Provenance

### Numbering data — Google libphonenumber

Dial codes, national-number length ranges, region (area) codes, example
numbers, national prefixes, leading digits, validation patterns and formatting
rules all come from Google's
[libphonenumber](https://github.com/google/libphonenumber) metadata, primarily
`resources/PhoneNumberMetadata.xml`. libphonenumber is licensed Apache-2.0.

Mapping notes that matter when reading the generated output:

* `Country.dialCode` is the true E.164 calling code. Territories in a shared
  numbering plan (the +1 North American Numbering Plan, +44, +39, …) carry the
  distinguishing area code in `Country.regionCode`, not in `dialCode`.
  `fullCountryCode` and `displayCC` recombine the two.
* `minLength`/`maxLength` are derived from libphonenumber's `possibleLengths`
  for the fixed-line and mobile ranges, and exclude both `dialCode` and
  `regionCode` — they bound what a user actually types.
* `countryNumberPatterns` is the union of each territory's `fixedLine` and
  `mobile` `nationalNumberPattern`.
* `isMainCountryForDialCode` mirrors libphonenumber's main-country-for-code
  designation, and `leadingDigits` is what tells co-tenants of a calling code
  apart (Guernsey/Jersey/Isle of Man from GB, for example).
* Some territories are genuinely indistinguishable from the main country for
  their calling code — Vatican City within +39, the Cocos and Christmas Islands
  within +61, Saint-Barthélemy and Saint-Martin within +590, and others. Their
  example numbers are attributed to the main country in
  `test/libphonenumber_examples.dart` and marked with a trailing comment, which
  is the same behaviour libphonenumber itself has.

### Country names — Unicode CLDR

`Country.name` is the English territory name and `Country.nameTranslations`
holds the localised names, keyed by language code, from the
[Unicode CLDR](https://cldr.unicode.org/) territory-name data. Twenty-two
locales are carried: `ar`, `de`, `en`, `es`, `fa`, `fr`, `it`, `ja`, `nl`,
`no`, `pl`, `pt_BR`, `ro`, `ru`, `se`, `sk`, `sr-Cyrl`, `sr-Latn`, `tr`, `yue`,
`zh`, `zh_TW`. CLDR is distributed under the
[Unicode License](https://www.unicode.org/license.txt).

`Country.name` is set to the English CLDR name, so it always agrees with
`nameTranslations['en']` — an invariant `test/country_data_test.dart` asserts.
The two had drifted apart before: Italy was named "Campione d'Italia".

Flag emoji are derived mechanically from the ISO 3166-1 alpha-2 code by mapping
each letter to its regional-indicator symbol, so they are not sourced from
either dataset.

## Regenerating

`generate_country_data.py` produces all four files. It needs Python 3.10+ and,
on its first run, network access:

```sh
python3 tool/generate_country_data.py            # fetch sources, then write
python3 tool/generate_country_data.py --offline  # reuse tool/.cache
```

It downloads libphonenumber's `PhoneNumberMetadata.xml` and the CLDR
`territories.json` for each locale into `tool/.cache/` (git-ignored), then
rewrites the four generated files in full. `--offline` reuses whatever is
already cached and fails rather than reaching the network, which is what you
want when reproducing a previous run.

After regenerating, always run:

```sh
dart format .
flutter analyze --fatal-infos
flutter test
```

`dart format` matters: the generator does not itself format its output, so
skipping it leaves a diff that fails CI's format gate.

`test/country_data_test.dart` is the real gate. It checks the dataset
invariants (unique ISO codes, sane length ranges, every country resolvable) and
replays all 489 libphonenumber example numbers through the resolver, so a bad
regeneration fails loudly rather than shipping.

## Scripts

### `generate_country_data.py`

The data generator described above. Beyond the straight transcription of
upstream fields it derives two things that are not stated directly in the
metadata:

* **`leadingDigits`** — for every territory that shares a calling code with a
  neighbour and is not the main country for it, the script searches for the
  shortest national-number prefixes that its own validation pattern accepts and
  no co-tenant's does. That search is what lets the resolver tell Guernsey,
  Jersey and the Isle of Man apart from GB within +44. Territories where no
  such prefix exists are the "indistinguishable" ones noted above.
* **`autoDetectable`** — forced to `false` for territories with no assigned
  numbering of their own (`AQ`, `BV`, `TF`, `HM`, `PN`, `GS`). They stay
  selectable in the picker but never win an automatic lookup, where they would
  otherwise shadow the neighbour whose calling code they borrow.

### `check_diacritics.dart`

```sh
dart run tool/check_diacritics.dart
```

Guards the paired diacritic tables in `lib/src/helpers.dart`, which back
accent-insensitive search in the country picker (typing `Aland` should find
`Åland`). It asserts a fixed table of 62 accented/plain character pairs and
prints either `all 62 mappings correct` or one line per broken mapping. Run it
after touching `removeDiacritics`.

## Releasing

When the public API changes, update the shipped agent skills in the same
commit — a stale skill is worse than no skill, because it turns an assistant's
uncertainty into confidence in the wrong answer:

* `skills/flutter-intl-phone-field-usage/SKILL.md` — the "Do not reach for
  these" table is the load-bearing part; it is what overrides a model's prior.
* `skills/flutter-intl-phone-field-usage/references/parameters.md` — regenerate
  from the README's parameter reference.
* `skills/flutter-intl-phone-field-migration/SKILL.md` — add the new breaking
  changes.
* The version each file names.

Verify they still install before publishing:

```sh
cd /tmp && flutter create --project-name skilltest skilltest
cd skilltest && dart pub add 'flutter_intl_phone_field:{"path":"../../path/to/repo"}'
dart run skills@ get --agent claude --all
```

Screenshots (`image-1.png`, `image-2.png`, `image-3.png`) are captured from the
example app's Showcase, Country list curation and Validation pages. Re-shoot
them when the interface changes; they are registered in `pubspec.yaml` and are
what pub.dev displays.
