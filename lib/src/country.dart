/// Describes a country or territory that can be selected in an
/// [IntlPhoneField].
///
/// Instances are `const` and immutable. The bundled [countries] list is
/// generated from Google's libphonenumber metadata; see
/// `tool/generate_countries.dart`.
class Country {
  /// English name of the country, e.g. `"United Kingdom"`.
  final String name;

  /// Localised names keyed by language code, e.g. `{"fr": "Royaume-Uni"}`.
  ///
  /// Resolve one with [localizedName] rather than reading this directly.
  final Map<String, String> nameTranslations;

  /// Regional-indicator emoji for the country, e.g. `"🇬🇧"`.
  ///
  /// Not every platform renders these; see `FlagStyle` for how the widget
  /// falls back to the bundled PNG flags.
  final String flag;

  /// ISO 3166-1 alpha-2 code, e.g. `"GB"`. Unique across [countries].
  final String code;

  /// Country calling code without a leading `+`, e.g. `"44"`.
  ///
  /// This is the true E.164 country code. For territories that share one (for
  /// example the +1 North American Numbering Plan) the distinguishing area
  /// code lives in [regionCode], not here.
  final String dialCode;

  /// Area code that always prefixes the national number for this territory,
  /// e.g. `"268"` for Antigua and Barbuda (+1 268).
  ///
  /// Empty when the territory has no single fixed area code. Users type the
  /// part *after* this prefix, so [minLength]/[maxLength] exclude it.
  final String regionCode;

  /// Fewest digits a user may type, excluding [dialCode] and [regionCode].
  final int minLength;

  /// Most digits a user may type, excluding [dialCode] and [regionCode].
  final int maxLength;

  /// A valid example subscriber number, used for placeholder/hint text.
  final String? example;

  /// National trunk prefix used for domestic dialling, e.g. `"0"`.
  ///
  /// Stripped automatically when a user pastes a number in national format.
  final String? nationalPrefix;

  /// Whether this is the primary territory for [dialCode].
  ///
  /// When a number cannot be attributed to a specific territory sharing the
  /// calling code, the main country is used.
  final bool isMainCountryForDialCode;

  /// National-number prefixes that uniquely identify this territory among
  /// others sharing [dialCode], e.g. `["1481", "7781", "7839"]` for Guernsey.
  final List<String> leadingDigits;

  /// All area codes assigned to this territory, when it has more than one
  /// (e.g. `["787", "939"]` for Puerto Rico).
  final List<String> areaCodes;

  /// Whether a number may be auto-attributed to this territory.
  ///
  /// False for placeholder entries with no assigned numbering (Antarctica,
  /// Bouvet Island, …): they remain selectable but never win a lookup.
  final bool autoDetectable;

  const Country({
    required this.name,
    required this.flag,
    required this.code,
    required this.dialCode,
    required this.nameTranslations,
    required this.minLength,
    required this.maxLength,
    this.regionCode = "",
    this.example,
    this.nationalPrefix,
    this.isMainCountryForDialCode = false,
    this.leadingDigits = const <String>[],
    this.areaCodes = const <String>[],
    this.autoDetectable = true,
  });

  /// Calling code plus fixed area code, e.g. `"1268"`. Used to build E.164.
  String get fullCountryCode => dialCode + regionCode;

  /// Human-readable calling code, e.g. `"1 268"`.
  String get displayCC =>
      regionCode.isEmpty ? dialCode : "$dialCode $regionCode";

  /// [fullCountryCode] with a leading `+`, e.g. `"+1268"`.
  String get displayDialCode => "+$fullCountryCode";

  /// Localised name for [languageCode], falling back to [name].
  ///
  /// Matching is case-insensitive and tolerates `en_US`/`en-US` style tags by
  /// falling back to the base language.
  String localizedName(String languageCode) {
    final exact = nameTranslations[languageCode];
    if (exact != null) return exact;

    final normalized = languageCode.toLowerCase().replaceAll('-', '_');
    for (final entry in nameTranslations.entries) {
      if (entry.key.toLowerCase().replaceAll('-', '_') == normalized) {
        return entry.value;
      }
    }

    final base = normalized.split('_').first;
    if (base != normalized) {
      for (final entry in nameTranslations.entries) {
        if (entry.key.toLowerCase().split(RegExp('[-_]')).first == base) {
          return entry.value;
        }
      }
    }
    return name;
  }

  Country copyWith({
    String? name,
    Map<String, String>? nameTranslations,
    String? flag,
    String? code,
    String? dialCode,
    String? regionCode,
    int? minLength,
    int? maxLength,
    String? example,
    String? nationalPrefix,
    bool? isMainCountryForDialCode,
    List<String>? leadingDigits,
    List<String>? areaCodes,
    bool? autoDetectable,
  }) {
    return Country(
      name: name ?? this.name,
      nameTranslations: nameTranslations ?? this.nameTranslations,
      flag: flag ?? this.flag,
      code: code ?? this.code,
      dialCode: dialCode ?? this.dialCode,
      regionCode: regionCode ?? this.regionCode,
      minLength: minLength ?? this.minLength,
      maxLength: maxLength ?? this.maxLength,
      example: example ?? this.example,
      nationalPrefix: nationalPrefix ?? this.nationalPrefix,
      isMainCountryForDialCode:
          isMainCountryForDialCode ?? this.isMainCountryForDialCode,
      leadingDigits: leadingDigits ?? this.leadingDigits,
      areaCodes: areaCodes ?? this.areaCodes,
      autoDetectable: autoDetectable ?? this.autoDetectable,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Country && other.code == code);

  @override
  int get hashCode => code.hashCode;

  @override
  String toString() => 'Country($code, +$fullCountryCode, $name)';
}
