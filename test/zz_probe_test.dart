import 'package:flutter_intl_phone_field/src/as_you_type_formatter.dart';
import 'package:flutter_intl_phone_field/src/countries.dart';
import 'package:flutter_intl_phone_field/src/country.dart';
import 'package:flutter_intl_phone_field/src/helpers.dart';
import 'package:flutter_test/flutter_test.dart';

Country byCode(String c) => countries.firstWhere((e) => e.code == c);

void main() {
  test('probe', () {
    // ignore: avoid_print
    void p(Object? o) => print('PROBE $o');

    p('search 44 -> ${countries.stringSearch('44').map((c) => c.code).toList()}');
    p('search +44 -> ${countries.stringSearch('+44').map((c) => c.code).toList()}');
    p('search united -> ${countries.stringSearch('united').map((c) => c.code).toList()}');
    p('search allemagne -> ${countries.stringSearch('allemagne').map((c) => c.code).toList()}');
    p('search reunion -> ${countries.stringSearch('reunion').map((c) => c.code).toList()}');
    p('search GB -> ${countries.stringSearch('GB').map((c) => c.code).toList()}');
    p('search zzzzz -> ${countries.stringSearch('zzzzz').length}');
    p('search empty -> ${countries.stringSearch('').length} of ${countries.length}');
    p('search 1268 -> ${countries.stringSearch('1268').map((c) => c.code).toList()}');

    p('isNumeric 25 -> ${isNumeric('1234567890123456789012345')}');
    p('diacritics count ${'ÀÁÂÃÄÅàáâãäåÒÓÔÕÖØòóôõöøÈÉÊËèéêëÇçÐðÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿÝýŽž'.length} ${'AAAAAAaaaaaaOOOOOOooooooEEEEeeeeCcDdIIIIiiiiUUUUuuuuNnSsYyYyZz'.length}');
    p('stroke ${removeDiacritics('Øø')}');

    p('US ${AsYouTypeFormatter.format(byCode('US'), '2015550123')}');
    p('FR ${AsYouTypeFormatter.format(byCode('FR'), '612345678')}');
    p('JP ${AsYouTypeFormatter.format(byCode('JP'), '9012345678')}');
    p('AG ${AsYouTypeFormatter.format(byCode('AG'), '4641234')}');
    p('GB ${AsYouTypeFormatter.format(byCode('GB'), '7400123456')}');

    for (var i = 1; i <= 10; i++) {
      p('US prefix $i -> "${AsYouTypeFormatter.format(byCode('US'), '2015550123'.substring(0, i))}"');
    }

    // countries with no formatting rules
    final noRules = <String>[];
    for (final c in countries) {
      if (AsYouTypeFormatter.format(c, '123456789') == '123456789') {
        noRules.add(c.code);
      }
    }
    p('no-rule-ish count ${noRules.length}: ${noRules.take(20).toList()}');

    // digit preservation over all examples
    final bad = <String>[];
    var withExample = 0;
    for (final c in countries) {
      final ex = c.example;
      if (ex == null || ex.isEmpty) continue;
      withExample++;
      final out = AsYouTypeFormatter.format(c, ex);
      if (out.replaceAll(RegExp(r'\D'), '') != ex) {
        bad.add('${c.code} $ex -> $out');
      }
    }
    p('examples=$withExample bad=${bad.length}');
    for (final b in bad.take(30)) {
      p('BAD $b');
    }
  });
}
