import 'package:flutter_intl_phone_field/src/countries.dart';
import 'package:flutter_intl_phone_field/src/country.dart';
import 'package:flutter_intl_phone_field/src/helpers.dart';
import 'package:flutter_test/flutter_test.dart';

/// The folding table under test, repeated here so a change to the library's
/// copy has to be made deliberately in two places.
const String _accented =
    'ÀÁÂÃÄÅàáâãäåÒÓÔÕÖØòóôõöøÈÉÊËèéêëÇçÐðÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿÝýŽž';
const String _plain =
    'AAAAAAaaaaaaOOOOOOooooooEEEEeeeeCcDdIIIIiiiiUUUUuuuuNnSsYyYyZz';

Country _byCode(String code) => countries.firstWhere((c) => c.code == code);

List<String> _codes(List<Country> list) => [for (final c in list) c.code];

void main() {
  group('removeDiacritics', () {
    test('the folding table is a one-to-one mapping', () {
      expect(_plain.length, _accented.length);
    });

    test('maps every character in the table', () {
      for (var i = 0; i < _accented.length; i++) {
        expect(
          removeDiacritics(_accented[i]),
          _plain[i],
          reason:
              'U+${_accented.codeUnitAt(i).toRadixString(16)} '
              '(${_accented[i]}) should fold to ${_plain[i]}',
        );
      }
    });

    test('folds o with stroke to a plain o', () {
      expect(removeDiacritics('Ø'), 'O');
      expect(removeDiacritics('ø'), 'o');
      expect(removeDiacritics('Nørrebro'), 'Norrebro');
    });

    test('folds accented words', () {
      expect(removeDiacritics('Réunion'), 'Reunion');
      expect(removeDiacritics('Côte d’Ivoire'), 'Cote d’Ivoire');
      expect(removeDiacritics('Åland'), 'Aland');
    });

    test('leaves a string without diacritics unchanged', () {
      expect(removeDiacritics('United Kingdom'), 'United Kingdom');
      expect(removeDiacritics(''), '');
      expect(removeDiacritics('+1 (268) 464-1234'), '+1 (268) 464-1234');
      expect(removeDiacritics('日本'), '日本');
    });
  });

  group('stringSearch', () {
    test('digits match dial codes by prefix, not by substring', () {
      final result = _codes(countries.stringSearch('44'));
      expect(result, contains('GB'));
      // Angola is +244: "44" appears inside its dial code but not at the front.
      expect(result, isNot(contains('AO')));
    });

    test('"+44" finds every territory on the United Kingdom calling code', () {
      expect(
        _codes(countries.stringSearch('+44')),
        unorderedEquals(<String>['GB', 'GG', 'IM', 'JE']),
      );
    });

    test('a bare dial code finds the same set as a prefixed one', () {
      expect(
        _codes(countries.stringSearch('44')),
        unorderedEquals(_codes(countries.stringSearch('+44'))),
      );
    });

    test('a full country code finds the territory that owns it', () {
      expect(_codes(countries.stringSearch('1268')), <String>['AG']);
    });

    test('matches English names', () {
      final result = _codes(countries.stringSearch('united'));
      expect(result, contains('GB'));
      expect(result, contains('US'));
    });

    test('matches translated names', () {
      expect(_codes(countries.stringSearch('allemagne')), <String>['DE']);
    });

    test('folds accents in the country name', () {
      expect(_codes(countries.stringSearch('reunion')), <String>['RE']);
      expect(_codes(countries.stringSearch('Réunion')), <String>['RE']);
    });

    test('matches the ISO code, case-insensitively', () {
      expect(_codes(countries.stringSearch('GB')), <String>['GB']);
      expect(_codes(countries.stringSearch('gb')), <String>['GB']);
    });

    test('a query matching nothing returns an empty list', () {
      expect(countries.stringSearch('zzzzz'), isEmpty);
      expect(countries.stringSearch('+9999'), isEmpty);
    });

    test('an empty query returns everything', () {
      expect(countries.stringSearch('').length, countries.length);
      expect(countries.stringSearch('   ').length, countries.length);
    });

    test('does not mutate the receiver', () {
      final list = <Country>[_byCode('GB'), _byCode('AO')];
      list.stringSearch('44');
      expect(_codes(list), <String>['GB', 'AO']);
    });
  });

  group('sortedByName', () {
    final subset = <Country>[_byCode('FR'), _byCode('DE'), _byCode('ES')];

    test('sorts by English name by default language', () {
      // France, Germany, Spain
      expect(_codes(subset.sortedByName('en')), <String>['FR', 'DE', 'ES']);
    });

    test('respects languageCode', () {
      // Allemagne, Espagne, France
      expect(_codes(subset.sortedByName('fr')), <String>['DE', 'ES', 'FR']);
    });

    test('falls back to the English name for an unknown language', () {
      expect(_codes(subset.sortedByName('zz')), <String>['FR', 'DE', 'ES']);
    });

    test('does not mutate the receiver', () {
      subset.sortedByName('fr');
      expect(_codes(subset), <String>['FR', 'DE', 'ES']);
    });
  });

  group('isNumeric', () {
    test('rejects an empty string', () {
      expect(isNumeric(''), isFalse);
    });

    test('rejects a lone plus', () {
      expect(isNumeric('+'), isFalse);
    });

    test('accepts digits with and without a leading plus', () {
      expect(isNumeric('+44'), isTrue);
      expect(isNumeric('44'), isTrue);
      expect(isNumeric('0'), isTrue);
    });

    test('rejects anything that is not a digit', () {
      expect(isNumeric('4a'), isFalse);
      expect(isNumeric('a4'), isFalse);
      expect(isNumeric('4 4'), isFalse);
      expect(isNumeric('4.4'), isFalse);
      expect(isNumeric('-44'), isFalse);
      expect(isNumeric('44+'), isFalse);
    });

    test('does not overflow on a number longer than an int', () {
      // 25 digits: int.tryParse used to return null here and report the string
      // as non-numeric.
      expect(isNumeric('1234567890123456789012345'), isTrue);
      expect(isNumeric('+1234567890123456789012345'), isTrue);
      expect(isNumeric('1234567890123456789012345a'), isFalse);
    });
  });
}
