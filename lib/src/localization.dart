/// User-facing strings shown by [IntlPhoneField] and the country picker.
///
/// The package ships English defaults and takes no localization dependency.
/// Override the strings you need, wherever your app already resolves them:
///
/// ```dart
/// IntlPhoneField(
///   localizations: IntlPhoneFieldLocalizations(
///     searchHint: AppLocalizations.of(context).searchCountry,
///     invalidNumber: AppLocalizations.of(context).invalidNumber,
///   ),
/// )
/// ```
class IntlPhoneFieldLocalizations {
  /// Label for the country picker's search field.
  final String searchHint;

  /// Shown when the number's length is outside the country's allowed range.
  final String invalidNumber;

  /// Shown when the field is empty and a number is required.
  final String requiredNumber;

  /// Shown when the field contains characters that are not digits.
  final String invalidCharacters;

  /// Shown in the picker when a search matches no country.
  final String noCountriesFound;

  /// Accessibility label for the country selector button. `{country}` is
  /// replaced with the selected country's localised name.
  final String countrySelectorLabel;

  /// Heading above pinned favourite countries in the picker.
  final String favoritesLabel;

  /// Creates a set of strings; anything omitted keeps its English default.
  const IntlPhoneFieldLocalizations({
    this.searchHint = 'Search country',
    this.invalidNumber = 'Invalid phone number',
    this.requiredNumber = 'Please enter a phone number',
    this.invalidCharacters = 'Please enter digits only',
    this.noCountriesFound = 'No countries found',
    this.countrySelectorLabel = 'Selected country: {country}. Tap to change.',
    this.favoritesLabel = 'Frequently used',
  });

  /// English defaults.
  static const IntlPhoneFieldLocalizations fallback =
      IntlPhoneFieldLocalizations();

  /// [countrySelectorLabel] with `{country}` replaced by [countryName].
  String countrySelectorLabelFor(String countryName) =>
      countrySelectorLabel.replaceAll('{country}', countryName);

  /// A copy of these strings with the given ones replaced.
  IntlPhoneFieldLocalizations copyWith({
    String? searchHint,
    String? invalidNumber,
    String? requiredNumber,
    String? invalidCharacters,
    String? noCountriesFound,
    String? countrySelectorLabel,
    String? favoritesLabel,
  }) =>
      IntlPhoneFieldLocalizations(
        searchHint: searchHint ?? this.searchHint,
        invalidNumber: invalidNumber ?? this.invalidNumber,
        requiredNumber: requiredNumber ?? this.requiredNumber,
        invalidCharacters: invalidCharacters ?? this.invalidCharacters,
        noCountriesFound: noCountriesFound ?? this.noCountriesFound,
        countrySelectorLabel: countrySelectorLabel ?? this.countrySelectorLabel,
        favoritesLabel: favoritesLabel ?? this.favoritesLabel,
      );
}
