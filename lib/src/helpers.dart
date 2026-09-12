import 'country.dart';

/// Whether [s] consists only of digits (a leading `+` is allowed).
bool isNumeric(String s) {
  final body = s.startsWith('+') ? s.substring(1) : s;
  if (body.isEmpty) return false;
  for (var i = 0; i < body.length; i++) {
    final c = body.codeUnitAt(i);
    if (c < 0x30 || c > 0x39) return false;
  }
  return true;
}

const String _withDiacritics =
    'ÀÁÂÃÄÅàáâãäåÒÓÔÕÖØòóôõöøÈÉÊËèéêëÇçÐðÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿÝýŽž';
const String _withoutDiacritics =
    'AAAAAAaaaaaaOOOOOOooooooEEEEeeeeCcDdIIIIiiiiUUUUuuuuNnSsYyYyZz';

/// Replace common accented Latin characters with their unaccented form, so
/// searching for "reunion" finds "Réunion".
String removeDiacritics(String str) {
  final buffer = StringBuffer();
  for (final rune in str.runes) {
    final ch = String.fromCharCode(rune);
    final i = _withDiacritics.indexOf(ch);
    buffer.write(i >= 0 ? _withoutDiacritics[i] : ch);
  }
  return buffer.toString();
}

/// Search helpers for country lists.
extension CountryExtensions on List<Country> {
  /// Filter by name, translated name or dial code.
  ///
  /// A query of digits (with or without a leading `+`) matches dial codes by
  /// prefix, so "44" finds the United Kingdom but not Angola (+244). Anything
  /// else matches country names, accent- and case-insensitively, in English
  /// and in every bundled translation.
  List<Country> stringSearch(String search, {String? languageCode}) {
    final query = removeDiacritics(search.toLowerCase()).trim();
    if (query.isEmpty) return List<Country>.of(this);

    final digits = query.startsWith('+') ? query.substring(1).trim() : query;
    if (digits.isNotEmpty && isNumeric(digits)) {
      final byDial = where((c) =>
          c.fullCountryCode.startsWith(digits) ||
          c.dialCode.startsWith(digits)).toList();
      // A bare number is almost always a dial code, but fall through to names
      // so searching "1" in a list without +1 still shows something useful.
      if (byDial.isNotEmpty || query.startsWith('+')) return byDial;
    }

    return where((country) {
      if (removeDiacritics(country.name.toLowerCase()).contains(query)) {
        return true;
      }
      if (country.code.toLowerCase() == query) return true;
      return country.nameTranslations.values
          .any((name) => removeDiacritics(name.toLowerCase()).contains(query));
    }).toList();
  }

  /// Sort by localised name for [languageCode].
  List<Country> sortedByName(String languageCode) {
    final copy = List<Country>.of(this);
    copy.sort((a, b) =>
        a.localizedName(languageCode).compareTo(b.localizedName(languageCode)));
    return copy;
  }
}
