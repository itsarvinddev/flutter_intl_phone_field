import 'countries.dart';
import 'country.dart';
import 'country_patterns.dart';

/// Resolves a phone number to the country it belongs to.
///
/// Lookup is driven by the country calling code, then — when several
/// territories share one (+1, +44, +7, +39, …) — by the leading digits of the
/// national number. This is the same strategy libphonenumber uses, and it is
/// why Guernsey mobiles (`+447781…`) no longer resolve to the United Kingdom.
///
/// The index is built once, lazily, and reused.
class CountryResolver {
  CountryResolver._(List<Country> countries)
      : _byDialCode = _indexByDialCode(countries),
        _dialCodes = _sortedDialCodes(countries),
        _byIsoCode = {for (final c in countries) c.code.toUpperCase(): c};

  final Map<String, List<Country>> _byDialCode;
  final List<String> _dialCodes;
  final Map<String, Country> _byIsoCode;

  static CountryResolver? _default;

  /// Resolver over the bundled [countries] list.
  static CountryResolver get instance =>
      _default ??= CountryResolver._(countries);

  /// Resolver over a caller-supplied country list.
  factory CountryResolver(List<Country> countries) =>
      CountryResolver._(countries);

  static Map<String, List<Country>> _indexByDialCode(List<Country> list) {
    final map = <String, List<Country>>{};
    for (final c in list) {
      (map[c.dialCode] ??= <Country>[]).add(c);
    }
    return map;
  }

  /// Longest calling codes first, so `+1268` is tried before `+1`.
  static List<String> _sortedDialCodes(List<Country> list) {
    final codes = list.map((c) => c.dialCode).toSet().toList();
    codes.sort((a, b) => b.length.compareTo(a.length));
    return codes;
  }

  static final Map<String, RegExp> _patternCache = <String, RegExp>{};

  static RegExp? _patternFor(Country c) {
    final src = countryNumberPatterns[c.code];
    if (src == null) return null;
    return _patternCache[c.code] ??= RegExp('^(?:$src)\$');
  }

  /// Look a country up by ISO 3166-1 alpha-2 code, case-insensitively.
  Country? byIsoCode(String isoCode) => _byIsoCode[isoCode.toUpperCase()];

  /// Look a country up by an international number.
  ///
  /// [number] may be given as `+441481960194`, `441481960194` or
  /// `00441481960194`. Returns `null` when no calling code matches.
  Country? fromInternationalNumber(String number) {
    final digits = _normalize(number);
    if (digits.isEmpty) return null;

    for (final dialCode in _dialCodes) {
      if (!digits.startsWith(dialCode)) continue;
      final candidates = _byDialCode[dialCode]!;
      if (candidates.length == 1) return candidates.first;

      final national = digits.substring(dialCode.length);

      // Prefer the territory claiming the longest matching national prefix.
      Country? best;
      var bestLength = -1;
      for (final c in candidates) {
        if (!c.autoDetectable) continue;
        for (final prefix in c.leadingDigits) {
          if (national.startsWith(prefix) && prefix.length > bestLength) {
            best = c;
            bestLength = prefix.length;
          }
        }
      }
      if (best != null) return best;

      // Otherwise fall back to the main territory for this calling code.
      for (final c in candidates) {
        if (c.isMainCountryForDialCode) return c;
      }
      return candidates.firstWhere((c) => c.autoDetectable,
          orElse: () => candidates.first);
    }
    return null;
  }

  /// Strip `+`, spaces, punctuation and a leading `00` international prefix.
  static String _normalize(String number) {
    final buffer = StringBuffer();
    for (var i = 0; i < number.length; i++) {
      final ch = number.codeUnitAt(i);
      if (ch >= 0x30 && ch <= 0x39) buffer.writeCharCode(ch);
    }
    var digits = buffer.toString();
    if (!number.trimLeft().startsWith('+') && digits.startsWith('00')) {
      digits = digits.substring(2);
    }
    return digits;
  }

  /// Whether [subscriberNumber] — the part the user types, excluding
  /// [Country.dialCode] and [Country.regionCode] — is valid for [country].
  ///
  /// When [strict] is true the number must also match a real fixed-line or
  /// mobile range, not merely fall inside the length range.
  ///
  /// Strict mode accepts a number that matches any territory sharing
  /// [Country.dialCode]. Some territories cannot be told apart from the number
  /// alone — a Vatican number is reported as Italian, a Cocos Islands number as
  /// Australian — and rejecting those would be wrong.
  static bool isValidFor(Country country, String subscriberNumber,
      {bool strict = false}) {
    final digits = subscriberNumber.replaceAll(RegExp(r'\D'), '');
    if (digits.length < country.minLength) return false;
    if (digits.length > country.maxLength) return false;
    if (!strict) return true;
    return instance._matchesAnySharingDialCode(country, digits);
  }

  bool _matchesAnySharingDialCode(Country country, String digits) {
    final national = country.regionCode + digits;
    final own = _patternFor(country);
    if (own == null) return true;
    if (own.hasMatch(national)) return true;
    for (final peer in _byDialCode[country.dialCode] ?? const <Country>[]) {
      if (identical(peer, country)) continue;
      if (peer.regionCode.isNotEmpty && !national.startsWith(peer.regionCode)) {
        continue;
      }
      if (_patternFor(peer)?.hasMatch(national) ?? false) return true;
    }
    return false;
  }
}
