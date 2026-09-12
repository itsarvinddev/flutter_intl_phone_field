import 'package:flutter_intl_phone_field/src/countries.dart';
import 'package:flutter_intl_phone_field/src/country.dart';
import 'package:flutter_intl_phone_field/src/country_lookup.dart';
import 'package:flutter_intl_phone_field/src/phone_number.dart';
import 'package:flutter_test/flutter_test.dart';

import 'libphonenumber_examples.dart';

void main() {
  group('country dataset invariants', () {
    test('ISO codes are unique and well formed', () {
      final seen = <String>{};
      for (final c in countries) {
        expect(c.code, matches(RegExp(r'^[A-Z]{2}$')), reason: c.name);
        expect(seen.add(c.code), isTrue, reason: 'duplicate ISO code ${c.code}');
      }
    });

    test('dial codes and region codes are digits only', () {
      for (final c in countries) {
        expect(c.dialCode, matches(RegExp(r'^\d{1,4}$')), reason: c.name);
        expect(c.regionCode, matches(RegExp(r'^\d*$')), reason: c.name);
      }
    });

    test('length ranges are sane', () {
      for (final c in countries) {
        expect(c.minLength, greaterThan(0), reason: c.name);
        expect(c.minLength, lessThanOrEqualTo(c.maxLength), reason: c.name);
        expect(c.maxLength, lessThanOrEqualTo(15), reason: c.name);
        // E.164 caps the whole number at 15 digits.
        expect(c.fullCountryCode.length + c.maxLength, lessThanOrEqualTo(15),
            reason: c.name);
      }
    });

    test('every country has a flag emoji matching its ISO code', () {
      for (final c in countries) {
        expect(c.flag, isNotEmpty, reason: c.name);
        final expected = c.code
            .split('')
            .map((l) => String.fromCharCode(0x1F1E6 + l.codeUnitAt(0) - 0x41))
            .join();
        expect(c.flag, expected, reason: c.name);
      }
    });

    test('every country has an English name translation', () {
      for (final c in countries) {
        expect(c.nameTranslations['en'], isNotNull, reason: c.name);
      }
    });

    test('example numbers fall inside the declared length range', () {
      for (final c in countries) {
        final ex = c.example;
        if (ex == null) continue;
        expect(ex.length, greaterThanOrEqualTo(c.minLength), reason: c.name);
        expect(ex.length, lessThanOrEqualTo(c.maxLength), reason: c.name);
      }
    });

    test('exactly one main country per shared dial code', () {
      final byDial = <String, List<Country>>{};
      for (final c in countries) {
        (byDial[c.dialCode] ??= []).add(c);
      }
      for (final entry in byDial.entries) {
        if (entry.value.length == 1) continue;
        final mains =
            entry.value.where((c) => c.isMainCountryForDialCode).toList();
        expect(mains, hasLength(1),
            reason: '+${entry.key} has ${mains.length} main countries');
      }
    });
  });

  group('lookup', () {
    test('every libphonenumber example resolves to the right country', () {
      final failures = <String>[];
      for (final (e164, iso) in libphonenumberExamples) {
        final c = CountryResolver.instance.fromInternationalNumber(e164);
        if (c?.code != iso) failures.add('$e164 -> ${c?.code} (want $iso)');
      }
      expect(failures, isEmpty,
          reason: '${failures.length} of ${libphonenumberExamples.length} '
              'examples resolved to the wrong country');
    });

    test('every libphonenumber example validates', () {
      final failures = <String>[];
      for (final (e164, _) in libphonenumberExamples) {
        final n = PhoneNumber.fromCompleteNumber(completeNumber: e164);
        if (!n.isValidNumber()) failures.add('$e164 ($n)');
        if (!n.isValidNumber(strict: true)) failures.add('strict: $e164 ($n)');
      }
      expect(failures, isEmpty, reason: failures.take(20).join('\n'));
    });

    test('example numbers round-trip through parse', () {
      for (final (e164, _) in libphonenumberExamples) {
        expect(PhoneNumber.parse(e164).completeNumber, e164);
      }
    });
  });
}
