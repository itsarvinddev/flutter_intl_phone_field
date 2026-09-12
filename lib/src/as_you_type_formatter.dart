import 'country.dart';
import 'number_formats.dart';
import 'phone_number_format.dart';

/// Formats a national number the way it is written locally, as it is typed.
///
/// Formatting rules come from Google's libphonenumber metadata, so
/// `2015550123` renders as `(201) 555-0123` for the United States and
/// `612345678` as `6 12 34 56 78` for France.
///
/// The formatter never adds or drops digits: stripping non-digits from the
/// result always returns the input.
class AsYouTypeFormatter {
  const AsYouTypeFormatter._();

  static final Map<String, RegExp> _regexCache = <String, RegExp>{};
  static final Map<String, List<_Template>> _templateCache =
      <String, List<_Template>>{};

  static RegExp _cached(String source) =>
      _regexCache[source] ??= RegExp(source);

  /// Format [digits] — a national number with no calling code — for [country].
  ///
  /// Returns [digits] unchanged when no rule applies, when the number is
  /// longer than any rule covers, or when the country has no formatting data.
  static String format(Country country, String digits) {
    final clean = digits.replaceAll(RegExp(r'\D'), '');
    if (clean.isEmpty) return '';

    final national = country.regionCode + clean;
    final templates = _templatesFor(country.code);
    if (templates.isEmpty) return clean;

    _Template? best;
    for (final t in templates) {
      if (t.leadingDigits != null &&
          !_cached('^(?:${t.leadingDigits})').hasMatch(national)) {
        continue;
      }
      if (national.length > t.capacity) continue;
      if (best == null || t.capacity < best.capacity) best = t;
    }
    if (best == null) return clean;

    // Lay the national number into the template, then drop the part of the
    // template that belongs to the fixed area code the user does not type.
    final laid = _apply(best.mask, national);
    if (country.regionCode.isEmpty) return laid;
    return _dropLeadingDigits(laid, country.regionCode.length);
  }

  static List<_Template> _templatesFor(String isoCode) {
    final cached = _templateCache[isoCode];
    if (cached != null) return cached;
    final rules = countryNumberFormats[isoCode] ?? const <PhoneNumberFormat>[];
    final out = <_Template>[];
    for (final r in rules) {
      final mask = _buildMask(r.pattern, r.format);
      if (mask != null) {
        out.add(_Template(mask, r.leadingDigits, _count(mask)));
      }
    }
    return _templateCache[isoCode] = out;
  }

  /// `r'(\d{3})(\d{4})'` + `r'$1-$2'` -> `'###-####'`
  ///
  /// Returns null for a rule this formatter cannot honour safely.
  static String? _buildMask(String pattern, String format) {
    final groups = RegExp(r'\((?:\?:)?([^()]*)\)').allMatches(pattern);
    if (groups.isEmpty) return null;
    var mask = format;
    var index = 0;
    var totalWidth = 0;
    for (final g in groups) {
      index++;
      final body = g.group(1)!;
      final m = RegExp(r'^\\d\{(\d+)(?:,(\d+))?\}$').firstMatch(body);
      final int width;
      if (m != null) {
        width = int.parse(m.group(2) ?? m.group(1)!);
      } else if (body == r'\d') {
        width = 1;
      } else {
        return null;
      }
      totalWidth += width;
      mask = mask.replaceAll('\$$index', '#' * width);
    }
    if (!mask.contains('#') || mask.contains(r'$')) return null;

    // Reject a rule that would change the digits. Argentina's domestic mobile
    // format is `$2 15-$3-$4`: it injects a literal 15 that belongs to
    // in-country dialling, and drops group 1 entirely. Neither is right for a
    // number we are about to render in international form.
    if (RegExp(r'\d').hasMatch(mask)) return null;
    if (_count(mask) != totalWidth) return null;

    return mask;
  }

  static int _count(String mask) => '#'.allMatches(mask).length;

  static String _apply(String mask, String digits) {
    final out = StringBuffer();
    var i = 0;
    for (var j = 0; j < mask.length; j++) {
      if (mask[j] == '#') {
        if (i >= digits.length) break;
        out.write(digits[i++]);
      } else {
        if (i >= digits.length) break;
        out.write(mask[j]);
      }
    }
    return out.toString();
  }

  /// Remove the first [count] digits and any separators that precede them.
  static String _dropLeadingDigits(String formatted, int count) {
    var seen = 0;
    var i = 0;
    for (; i < formatted.length && seen < count; i++) {
      if (_isDigit(formatted.codeUnitAt(i))) seen++;
    }
    var rest = formatted.substring(i);
    while (rest.isNotEmpty && !_isDigit(rest.codeUnitAt(0))) {
      rest = rest.substring(1);
    }
    return rest;
  }

  static bool _isDigit(int c) => c >= 0x30 && c <= 0x39;
}

class _Template {
  const _Template(this.mask, this.leadingDigits, this.capacity);
  final String mask;
  final String? leadingDigits;
  final int capacity;
}
