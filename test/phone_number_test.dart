import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('PhoneNumber.parse', () {
    test('splits a number into country and subscriber parts', () {
      final n = PhoneNumber.parse('+447400123456');
      expect(n.countryISOCode, 'GB');
      expect(n.countryCode, '+44');
      expect(n.number, '7400123456');
      expect(n.completeNumber, '+447400123456');
    });

    test('keeps the area code out of the subscriber number', () {
      final n = PhoneNumber.parse('+12684641234');
      expect(n.countryISOCode, 'AG');
      expect(n.countryCode, '+1268');
      expect(n.number, '4641234');
    });

    test('accepts a 00 international prefix', () {
      expect(PhoneNumber.parse('00447400123456').countryISOCode, 'GB');
    });

    test('accepts formatting punctuation', () {
      final n = PhoneNumber.parse('+1 (201) 555-0123');
      expect(n.countryISOCode, 'US');
      expect(n.number, '2015550123');
    });

    test('rejects letters', () {
      expect(() => PhoneNumber.parse('+44abcdef'),
          throwsA(isA<InvalidCharactersException>()));
      expect(() => PhoneNumber.parse('+44abcdef1'),
          throwsA(isA<InvalidCharactersException>()));
    });

    test('rejects an empty or unmatchable number', () {
      expect(() => PhoneNumber.parse(''),
          throwsA(isA<NumberTooShortException>()));
      expect(() => PhoneNumber.parse('+'),
          throwsA(isA<InvalidCharactersException>()));
      expect(() => PhoneNumber.parse('+9999999999'),
          throwsA(isA<NumberTooShortException>()));
    });
  });

  group('PhoneNumber.fromCompleteNumber', () {
    test('never throws; unparseable input is returned verbatim', () {
      for (final bad in ['', '+', 'abc', '+9999999999', '00']) {
        final n = PhoneNumber.fromCompleteNumber(completeNumber: bad);
        expect(n.countryISOCode, '');
        expect(n.number, bad);
      }
    });

    test('parses a Guernsey mobile, which carries no 1481 prefix', () {
      final n = PhoneNumber.fromCompleteNumber(completeNumber: '+447781123456');
      expect(n.countryISOCode, 'GG');
      expect(n.number, '7781123456');
      expect(n.isValidNumber(), isTrue);
    });

    test('a UK mobile is not mistaken for Guernsey', () {
      final n = PhoneNumber.fromCompleteNumber(completeNumber: '+447400123456');
      expect(n.countryISOCode, 'GB');
      expect(n.isValidNumber(), isTrue);
    });
  });

  group('country attribution for shared calling codes', () {
    const cases = <String, String>{
      '+12015550123': 'US',
      '+15062345678': 'CA',
      '+17872345678': 'PR',
      '+18092345678': 'DO',
      '+18762101234': 'JM',
      '+13453231234': 'KY',
      '+447400123456': 'GB',
      '+441481960194': 'GG',
      '+441624756789': 'IM',
      '+441534888888': 'JE',
      '+79123456789': 'RU',
      '+77710009998': 'KZ',
      '+4791234567': 'NO',
      '+4779123456': 'SJ',
      '+358181234567': 'AX',
      '+358412345678': 'FI',
      '+262639012345': 'YT',
      '+262262161234': 'RE',
    };

    cases.forEach((number, iso) {
      test('$number resolves to $iso', () {
        expect(PhoneNumber.parse(number).countryISOCode, iso);
      });
    });
  });

  group('validation', () {
    test('isValidNumber checks the length range', () {
      const gb = PhoneNumber(
          countryISOCode: 'GB', countryCode: '+44', number: '7400123456');
      expect(gb.isValidNumber(), isTrue);
      expect(gb.copyWith(number: '740012').isValidNumber(), isFalse);
      expect(gb.copyWith(number: '74001234567890').isValidNumber(), isFalse);
    });

    test('validate throws describing the failure', () {
      const gb = PhoneNumber(
          countryISOCode: 'GB', countryCode: '+44', number: '7400123456');
      expect(gb.validate, returnsNormally);
      expect(() => gb.copyWith(number: '7400').validate(),
          throwsA(isA<NumberTooShortException>()));
      expect(() => gb.copyWith(number: '740012345678901').validate(),
          throwsA(isA<NumberTooLongException>()));
      expect(() => gb.copyWith(number: '74001234ab').validate(),
          throwsA(isA<InvalidCharactersException>()));
    });

    test('strict mode rejects an unassigned range of the right length', () {
      const us = PhoneNumber(
          countryISOCode: 'US', countryCode: '+1', number: '1112223333');
      expect(us.isValidNumber(), isTrue, reason: 'ten digits is plausible');
      expect(us.isValidNumber(strict: true), isFalse,
          reason: 'area code 111 is not assigned');
    });

    test('uses the country it was told, not one re-derived from the digits',
        () {
      // 7781123456 is a Guernsey mobile; as a UK number it is still valid.
      const gg = PhoneNumber(
          countryISOCode: 'GG', countryCode: '+44', number: '7781123456');
      expect(gg.country?.code, 'GG');
      expect(gg.isValidNumber(), isTrue);
    });
  });

  group('value semantics', () {
    const a = PhoneNumber(
        countryISOCode: 'GB', countryCode: '+44', number: '7400123456');

    test('equality and hashCode', () {
      const b = PhoneNumber(
          countryISOCode: 'GB', countryCode: '+44', number: '7400123456');
      expect(a, b);
      expect(a.hashCode, b.hashCode);
      expect(a, isNot(a.copyWith(number: '7400123457')));
    });

    test('JSON round-trip', () {
      expect(PhoneNumber.fromJson(a.toJson()), a);
    });

    test('completeNumber tolerates a countryCode given without +', () {
      const noPlus = PhoneNumber(
          countryISOCode: 'GB', countryCode: '44', number: '7400123456');
      expect(noPlus.completeNumber, '+447400123456');
    });
  });

  group('getCountry', () {
    test('falls back to India rather than throwing', () {
      for (final bad in ['', '+', 'abc', '+9999999999', '0501234567']) {
        expect(PhoneNumber.getCountry(bad).code, 'IN', reason: bad);
      }
    });

    test('an ISO hint wins over prefix matching', () {
      expect(PhoneNumber.getCountry('+441481960194', 'GB').code, 'GB');
      expect(PhoneNumber.getCountry('+441481960194').code, 'GG');
    });
  });
}
