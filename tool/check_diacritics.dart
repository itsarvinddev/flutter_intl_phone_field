// Guards the paired diacritic tables in lib/src/helpers.dart.
import 'package:flutter_intl_phone_field/src/helpers.dart';

void main() {
  const pairs = <String, String>{
    'À': 'A', 'Á': 'A', 'Â': 'A', 'Ã': 'A', 'Ä': 'A', 'Å': 'A',
    'à': 'a', 'á': 'a', 'â': 'a', 'ã': 'a', 'ä': 'a', 'å': 'a',
    'Ò': 'O', 'Ó': 'O', 'Ô': 'O', 'Õ': 'O', 'Ö': 'O', 'Ø': 'O',
    'ò': 'o', 'ó': 'o', 'ô': 'o', 'õ': 'o', 'ö': 'o', 'ø': 'o',
    'È': 'E', 'É': 'E', 'Ê': 'E', 'Ë': 'E',
    'è': 'e', 'é': 'e', 'ê': 'e', 'ë': 'e',
    'Ç': 'C', 'ç': 'c', 'Ð': 'D', 'ð': 'd',
    'Ì': 'I', 'Í': 'I', 'Î': 'I', 'Ï': 'I',
    'ì': 'i', 'í': 'i', 'î': 'i', 'ï': 'i',
    'Ù': 'U', 'Ú': 'U', 'Û': 'U', 'Ü': 'U',
    'ù': 'u', 'ú': 'u', 'û': 'u', 'ü': 'u',
    'Ñ': 'N', 'ñ': 'n', 'Š': 'S', 'š': 's',
    'Ÿ': 'Y', 'ÿ': 'y', 'Ý': 'Y', 'ý': 'y',
    'Ž': 'Z', 'ž': 'z',
  };
  var bad = 0;
  pairs.forEach((from, to) {
    final got = removeDiacritics(from);
    if (got != to) {
      bad++;
      print('WRONG: $from -> $got (want $to)');
    }
  });
  print(bad == 0 ? 'all ${pairs.length} mappings correct' : '$bad WRONG');
}
