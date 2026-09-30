import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:material_ui/material_ui.dart';

import '../demo_page.dart';

/// Three ways to shape the list the picker offers.
///
/// * [IntlPhoneField.favoriteCountries] pins codes to the top, in the order
///   given, under a "Frequently used" heading. The rest of the list stays.
/// * [IntlPhoneField.onlyCountries] restricts the list to those codes.
/// * [IntlPhoneField.excludeCountries] removes those codes.
///
/// For anything more involved, pass your own list to
/// [IntlPhoneField.countries] — the fourth field does that.
class CountryListDemo extends StatefulWidget {
  const CountryListDemo({super.key});

  static const String route = '/countries';

  @override
  State<CountryListDemo> createState() => _CountryListDemoState();
}

class _CountryListDemoState extends State<CountryListDemo> {
  PhoneNumber? _favorites;
  PhoneNumber? _only;
  PhoneNumber? _exclude;
  PhoneNumber? _custom;

  /// Every country whose calling code is +1, sorted by name. Any
  /// `List<Country>` will do.
  static final List<Country> _northAmerica = countries
      .where((country) => country.dialCode == '1')
      .toList(growable: false);

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'Country list curation',
      description:
          'Open each picker to see how the list differs. Codes are '
          'ISO 3166-1 alpha-2 and are matched case-insensitively.',
      children: <Widget>[
        DemoSection(
          title: 'favoriteCountries',
          caption: "['IN', 'US', 'GB', 'AE'] pinned above the full list.",
          child: Column(
            children: <Widget>[
              IntlPhoneField(
                initialCountryCode: 'IN',
                favoriteCountries: const <String>['IN', 'US', 'GB', 'AE'],
                decoration: phoneDecoration('Favourites pinned on top'),
                onChanged: (phone) => setState(() => _favorites = phone),
              ),
              PhoneValuePanel(value: _favorites),
            ],
          ),
        ),
        DemoSection(
          title: 'onlyCountries',
          caption: "['US', 'CA', 'MX'] — the picker offers nothing else.",
          child: Column(
            children: <Widget>[
              IntlPhoneField(
                initialCountryCode: 'CA',
                onlyCountries: const <String>['US', 'CA', 'MX'],
                decoration: phoneDecoration('North America only'),
                onChanged: (phone) => setState(() => _only = phone),
              ),
              PhoneValuePanel(value: _only),
            ],
          ),
        ),
        DemoSection(
          title: 'excludeCountries',
          caption:
              "['US', 'CA'] removed from the full list; everything else "
              'remains.',
          child: Column(
            children: <Widget>[
              IntlPhoneField(
                initialCountryCode: 'GB',
                excludeCountries: const <String>['US', 'CA'],
                decoration: phoneDecoration('Everywhere but US and Canada'),
                onChanged: (phone) => setState(() => _exclude = phone),
              ),
              PhoneValuePanel(value: _exclude),
            ],
          ),
        ),
        DemoSection(
          title: 'A hand-built list',
          caption:
              'countries: every territory on the +1 calling code '
              '(${_northAmerica.length} of them).',
          child: Column(
            children: <Widget>[
              IntlPhoneField(
                initialCountryCode: 'BS',
                countries: _northAmerica,
                favoriteCountries: const <String>['US'],
                decoration: phoneDecoration(
                  'The +1 numbering plan',
                  helper:
                      'Territories share dialCode "1"; the area code '
                      'lives in Country.regionCode.',
                ),
                onChanged: (phone) => setState(() => _custom = phone),
              ),
              PhoneValuePanel(value: _custom),
            ],
          ),
        ),
      ],
    );
  }
}
