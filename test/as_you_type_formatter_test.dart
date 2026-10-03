import 'package:flutter/services.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_intl_phone_field/src/number_formats.dart';
import 'package:flutter_test/flutter_test.dart';

Country _byCode(String code) => countries.firstWhere((c) => c.code == code);

String _digitsOf(String s) => s.replaceAll(RegExp(r'\D'), '');

TextEditingValue _value(String text, int offset) => TextEditingValue(
  text: text,
  selection: TextSelection.collapsed(offset: offset),
);

void main() {
  group('AsYouTypeFormatter digit preservation', () {
    test('every bundled example keeps its digits, in order', () {
      final failures = <String>[];
      var checked = 0;
      for (final country in countries) {
        final example = country.example;
        if (example == null || example.isEmpty) continue;
        checked++;
        final formatted = AsYouTypeFormatter.format(country, example);
        if (_digitsOf(formatted) != example) {
          failures.add('${country.code}: $example -> $formatted');
        }
      }
      expect(
        checked,
        greaterThan(200),
        reason: 'the dataset should carry an example for most countries',
      );
      expect(
        failures,
        isEmpty,
        reason: 'formatting must never add, drop or reorder digits',
      );
    });

    test('every example survives being typed one digit at a time', () {
      // Argentina currently fails here: its libphonenumber formats embed the
      // literal domestic mobile prefix "15" (e.g. r'$2 15-$3-$4'), which the
      // mask builder turns into two digits nobody typed. See the Argentine
      // regression test in the PhoneInputFormatter group below.
      final failures = <String>[];
      for (final country in countries) {
        final example = country.example;
        if (example == null || example.isEmpty) continue;
        for (var i = 1; i <= example.length; i++) {
          final prefix = example.substring(0, i);
          final formatted = AsYouTypeFormatter.format(country, prefix);
          if (_digitsOf(formatted) != prefix) {
            failures.add('${country.code}: $prefix -> $formatted');
          }
        }
      }
      expect(failures, isEmpty);
    });

    test('non-digits in the input are stripped, not preserved', () {
      final us = _byCode('US');
      expect(
        AsYouTypeFormatter.format(us, '(201) 555-0123'),
        AsYouTypeFormatter.format(us, '2015550123'),
      );
      expect(AsYouTypeFormatter.format(us, '201 555 0123'), '(201) 555-0123');
    });

    test('an empty input formats to an empty string', () {
      expect(AsYouTypeFormatter.format(_byCode('US'), ''), '');
      expect(AsYouTypeFormatter.format(_byCode('US'), '---'), '');
    });
  });

  group('AsYouTypeFormatter national layouts', () {
    test('United States', () {
      expect(
        AsYouTypeFormatter.format(_byCode('US'), '2015550123'),
        '(201) 555-0123',
      );
    });

    test('France', () {
      expect(
        AsYouTypeFormatter.format(_byCode('FR'), '612345678'),
        '6 12 34 56 78',
      );
    });

    test('Japan', () {
      expect(
        AsYouTypeFormatter.format(_byCode('JP'), '9012345678'),
        '90-1234-5678',
      );
    });

    test('United Kingdom', () {
      expect(
        AsYouTypeFormatter.format(_byCode('GB'), '7400123456'),
        '7400 123456',
      );
    });

    test('the United States example is laid out at every prefix length', () {
      final us = _byCode('US');
      const example = '2015550123';
      expect(us.example, example);
      const expected = <String>[
        '2',
        '20',
        '201',
        '201-5',
        '201-55',
        '201-555',
        '201-5550',
        '(201) 555-01',
        '(201) 555-012',
        '(201) 555-0123',
      ];
      for (var i = 1; i <= example.length; i++) {
        final prefix = example.substring(0, i);
        final formatted = AsYouTypeFormatter.format(us, prefix);
        expect(formatted, expected[i - 1], reason: 'prefix of length $i');
        expect(_digitsOf(formatted), prefix, reason: 'prefix of length $i');
      }
    });
  });

  group('AsYouTypeFormatter without rules', () {
    test('a country with no formatting rules returns the digits unchanged', () {
      final antarctica = _byCode('AQ');
      expect(
        countryNumberFormats[antarctica.code],
        isNull,
        reason:
            'AQ is the fixture for "no rules"; pick another if this '
            'country gains formatting data',
      );
      expect(AsYouTypeFormatter.format(antarctica, '123456'), '123456');
      expect(AsYouTypeFormatter.format(antarctica, '1'), '1');
    });

    test('a number longer than any rule covers is returned unchanged', () {
      expect(
        AsYouTypeFormatter.format(_byCode('US'), '20155501234567'),
        '20155501234567',
      );
    });
  });

  group('PhoneInputFormatter', () {
    test('formats while typing at the end and keeps the caret there', () {
      final formatter = PhoneInputFormatter(country: _byCode('US'));
      final result = formatter.formatEditUpdate(
        _value('(201) 555-012', 13),
        _value('(201) 555-0123', 14),
      );
      expect(result.text, '(201) 555-0123');
      expect(result.selection.baseOffset, 14);
      expect(result.selection.isCollapsed, isTrue);
    });

    test('caret lands after the newly typed digit when separators appear', () {
      final formatter = PhoneInputFormatter(country: _byCode('US'));
      // '2015550' -> typing the 8th digit turns '201-5550' into '(201) 555-01'.
      final result = formatter.formatEditUpdate(
        _value('201-5550', 8),
        _value('201-55501', 9),
      );
      expect(result.text, '(201) 555-01');
      expect(result.selection.baseOffset, result.text.length);
      expect(_digitsOf(result.text), '20155501');
    });

    test('inserting a digit mid-number keeps the caret beside that digit', () {
      final formatter = PhoneInputFormatter(country: _byCode('US'));
      // Caret sits after '555' in '(201) 555-012'; the user types '9'.
      final result = formatter.formatEditUpdate(
        _value('(201) 555-012', 9),
        _value('(201) 5559-012', 10),
      );
      expect(result.text, '(201) 555-9012');
      expect(result.selection.baseOffset, 11);
      // The character just before the caret is the digit that was typed.
      expect(result.text[result.selection.baseOffset - 1], '9');
    });

    test(
      'deleting a digit mid-number keeps the caret beside its neighbour',
      () {
        final formatter = PhoneInputFormatter(country: _byCode('US'));
        // '(201) 555-0123' with the '5' after ') ' deleted.
        final result = formatter.formatEditUpdate(
          _value('(201) 555-0123', 7),
          _value('(201) 55-0123', 6),
        );
        expect(_digitsOf(result.text), '201550123');
        expect(result.text[result.selection.baseOffset - 1], '1');
      },
    );

    test('a caret at the start stays at the start', () {
      final formatter = PhoneInputFormatter(country: _byCode('US'));
      final result = formatter.formatEditUpdate(
        _value('', 0),
        _value('2015550123', 0),
      );
      expect(result.text, '(201) 555-0123');
      expect(result.selection.baseOffset, 0);
    });

    test('with enabled: false it strips non-digits', () {
      final formatter = PhoneInputFormatter(
        country: _byCode('US'),
        enabled: false,
      );
      final result = formatter.formatEditUpdate(
        const TextEditingValue(),
        _value('(201) 555-0123', 14),
      );
      expect(result.text, '2015550123');
      expect(result.selection.baseOffset, 10);
    });

    test('with enabled: false it leaves plain digits alone', () {
      final formatter = PhoneInputFormatter(
        country: _byCode('US'),
        enabled: false,
      );
      final result = formatter.formatEditUpdate(
        _value('201555012', 9),
        _value('2015550123', 10),
      );
      expect(result.text, '2015550123');
      expect(result.selection.baseOffset, 10);
    });

    test('switching country reformats the same digits', () {
      final formatter = PhoneInputFormatter(country: _byCode('US'));
      var result = formatter.formatEditUpdate(
        const TextEditingValue(),
        _value('2015550123', 10),
      );
      expect(result.text, '(201) 555-0123');

      formatter.country = _byCode('JP');
      result = formatter.formatEditUpdate(
        const TextEditingValue(),
        _value('9012345678', 10),
      );
      expect(result.text, '90-1234-5678');
    });

    test('never changes the digits of the value it is given', () {
      final formatter = PhoneInputFormatter(country: _byCode('FR'));
      var text = '';
      for (final digit in '612345678'.split('')) {
        final typed = text + digit;
        final result = formatter.formatEditUpdate(
          _value(text, text.length),
          _value(typed, typed.length),
        );
        text = result.text;
        expect(_digitsOf(text), _digitsOf(typed));
      }
      expect(text, '6 12 34 56 78');
    });

    test('typing an Argentine mobile never injects the domestic 15 prefix', () {
      final argentina = _byCode('AR');
      final formatter = PhoneInputFormatter(country: argentina);
      final example = argentina.example!;

      var text = '';
      for (final digit in example.split('')) {
        final typed = text + digit;
        final result = formatter.formatEditUpdate(
          _value(text, text.length),
          _value(typed, typed.length),
        );
        text = result.text;
        expect(
          _digitsOf(text),
          _digitsOf(typed),
          reason: 'typing "$typed" produced "$text"',
        );
      }
      expect(_digitsOf(text), example);
    });
  });
}
