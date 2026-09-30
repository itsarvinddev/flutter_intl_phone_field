import 'countries.dart';
import 'country.dart';
import 'country_lookup.dart';

/// Thrown when a number has more digits than the country allows.
class NumberTooLongException implements Exception {
  /// Creates the exception, optionally with a custom [message].
  const NumberTooLongException([this.message = 'The number is too long.']);

  /// Human-readable description of the failure.
  final String message;
  @override
  String toString() => 'NumberTooLongException: $message';
}

/// Thrown when a number has fewer digits than the country requires.
class NumberTooShortException implements Exception {
  /// Creates the exception, optionally with a custom [message].
  const NumberTooShortException([this.message = 'The number is too short.']);

  /// Human-readable description of the failure.
  final String message;
  @override
  String toString() => 'NumberTooShortException: $message';
}

/// Thrown when a number contains characters that cannot be part of a phone
/// number.
class InvalidCharactersException implements Exception {
  /// Creates the exception, optionally with a custom [message].
  const InvalidCharactersException([
    this.message = 'The number contains invalid characters.',
  ]);

  /// Human-readable description of the failure.
  final String message;
  @override
  String toString() => 'InvalidCharactersException: $message';
}

/// An international phone number, split into its country and subscriber parts.
///
/// [number] is the part the user types: it excludes both the calling code and
/// any fixed area code carried by [Country.regionCode].
class PhoneNumber {
  /// ISO 3166-1 alpha-2 code of the country, e.g. `"GB"`.
  final String countryISOCode;

  /// Calling code including any fixed area code and a leading `+`,
  /// e.g. `"+44"` or `"+1268"`.
  ///
  /// A value without the `+` is accepted and normalised.
  final String countryCode;

  /// The subscriber number as typed, digits only.
  final String number;

  /// Creates a phone number from its parts.
  const PhoneNumber({
    required this.countryISOCode,
    required this.countryCode,
    required this.number,
  });

  /// Parse a full international number, e.g. `"+441481960194"`.
  ///
  /// Never throws: an unparseable value comes back with empty country fields
  /// and the original text in [number]. Use [PhoneNumber.parse] when you want
  /// the failure reported.
  factory PhoneNumber.fromCompleteNumber({required String completeNumber}) {
    try {
      return PhoneNumber.parse(completeNumber);
    } on Exception {
      return PhoneNumber(
        countryISOCode: '',
        countryCode: '',
        number: completeNumber,
      );
    }
  }

  /// Parse a full international number, throwing on failure.
  ///
  /// Throws [InvalidCharactersException] when [completeNumber] holds anything
  /// other than digits and formatting punctuation, and [NumberTooShortException]
  /// when no country calling code can be matched.
  factory PhoneNumber.parse(String completeNumber, {List<Country>? countries}) {
    final trimmed = completeNumber.trim();
    if (trimmed.isEmpty) {
      throw const NumberTooShortException('The number is empty.');
    }
    if (!RegExp(r'^\+?[0-9\s\-().]+$').hasMatch(trimmed)) {
      throw const InvalidCharactersException();
    }

    final resolver = countries == null
        ? CountryResolver.instance
        : CountryResolver(countries);
    final country = resolver.fromInternationalNumber(trimmed);
    if (country == null) {
      throw const NumberTooShortException(
        'No country calling code matches this number.',
      );
    }

    var digits = trimmed.replaceAll(RegExp(r'\D'), '');
    if (!trimmed.startsWith('+') && digits.startsWith('00')) {
      digits = digits.substring(2);
    }
    var rest = digits.substring(country.dialCode.length);
    if (country.regionCode.isNotEmpty && rest.startsWith(country.regionCode)) {
      rest = rest.substring(country.regionCode.length);
    }

    return PhoneNumber(
      countryISOCode: country.code,
      countryCode: '+${country.fullCountryCode}',
      number: rest,
    );
  }

  /// The [Country] this number belongs to, or `null` if unknown.
  Country? get country {
    if (countryISOCode.isNotEmpty) {
      final byIso = CountryResolver.instance.byIsoCode(countryISOCode);
      if (byIso != null) return byIso;
    }
    return CountryResolver.instance.fromInternationalNumber(completeNumber);
  }

  /// Whether the number is valid for its country.
  ///
  /// By default only the digit count is checked, against the country's
  /// permitted range. Pass `strict: true` to also require that the number
  /// matches a real fixed-line or mobile range for the territory.
  ///
  /// Returns `false` rather than throwing; see [validate] for the throwing
  /// variant.
  bool isValidNumber({bool strict = false}) {
    final c = country;
    if (c == null) return false;
    return CountryResolver.isValidFor(c, number, strict: strict);
  }

  /// Like [isValidNumber], but throws describing why the number is invalid.
  ///
  /// Throws [NumberTooShortException], [NumberTooLongException] or
  /// [InvalidCharactersException].
  void validate({bool strict = false}) {
    final c = country;
    if (c == null) {
      throw const InvalidCharactersException('Unknown country.');
    }
    final digits = number.replaceAll(RegExp(r'\D'), '');
    if (digits.length != number.length) {
      throw const InvalidCharactersException();
    }
    if (digits.length < c.minLength) throw const NumberTooShortException();
    if (digits.length > c.maxLength) throw const NumberTooLongException();
    if (strict && !CountryResolver.isValidFor(c, digits, strict: true)) {
      throw const InvalidCharactersException(
        'The number is not in an assigned range for this country.',
      );
    }
  }

  /// The full number in E.164 form, e.g. `"+441481960194"`.
  String get completeNumber {
    if (countryCode.isEmpty) return number;
    final cc = countryCode.startsWith('+') ? countryCode : '+$countryCode';
    return '$cc$number';
  }

  /// The subscriber number as typed.
  String get getOriginalValue => number;

  /// A copy of this number with the given fields replaced.
  PhoneNumber copyWith({
    String? countryISOCode,
    String? countryCode,
    String? number,
  }) => PhoneNumber(
    countryISOCode: countryISOCode ?? this.countryISOCode,
    countryCode: countryCode ?? this.countryCode,
    number: number ?? this.number,
  );

  /// A JSON map of [countryISOCode], [countryCode] and [number].
  Map<String, dynamic> toJson() => <String, dynamic>{
    'countryISOCode': countryISOCode,
    'countryCode': countryCode,
    'number': number,
  };

  /// Rebuilds a number from the map produced by [toJson].
  factory PhoneNumber.fromJson(Map<String, dynamic> json) => PhoneNumber(
    countryISOCode: json['countryISOCode'] as String? ?? '',
    countryCode: json['countryCode'] as String? ?? '',
    number: json['number'] as String? ?? '',
  );

  /// Resolve the country for an arbitrary international number.
  ///
  /// Falls back to India (`IN`) when nothing matches, preserving the behaviour
  /// of earlier releases.
  static Country getCountry(String phoneNumber, [String? isoCode]) {
    if (isoCode != null && isoCode.isNotEmpty) {
      final byIso = CountryResolver.instance.byIsoCode(isoCode);
      if (byIso != null) return byIso;
    }
    return CountryResolver.instance.fromInternationalNumber(phoneNumber) ??
        countries.firstWhere((c) => c.code == 'IN');
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhoneNumber &&
          other.countryISOCode == countryISOCode &&
          other.countryCode == countryCode &&
          other.number == number);

  @override
  int get hashCode => Object.hash(countryISOCode, countryCode, number);

  @override
  String toString() =>
      'PhoneNumber(countryISOCode: $countryISOCode, countryCode: $countryCode, number: $number)';
}
