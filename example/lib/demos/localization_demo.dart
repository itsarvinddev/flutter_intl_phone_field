import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';

import '../demo_page.dart';

/// The package ships English strings and takes no localization dependency.
///
/// Two separate things are localised:
///
/// * [IntlPhoneField.localizations] — the strings the widget itself shows
///   (search hint, error messages, the empty-search message). Feed these from
///   wherever your app already resolves strings.
/// * [IntlPhoneField.languageCode] — the language the *country names* are
///   shown in. Names come from the Unicode CLDR and are bundled with the
///   package, so no setup is needed.
class LocalizationDemo extends StatefulWidget {
  const LocalizationDemo({super.key});

  static const String route = '/localization';

  @override
  State<LocalizationDemo> createState() => _LocalizationDemoState();
}

class _LocalizationDemoState extends State<LocalizationDemo> {
  PhoneNumber? _value;
  bool _french = true;

  static const IntlPhoneFieldLocalizations _fr = IntlPhoneFieldLocalizations(
    searchHint: 'Rechercher un pays',
    invalidNumber: 'Numéro de téléphone invalide',
    requiredNumber: 'Veuillez saisir un numéro de téléphone',
    invalidCharacters: 'Veuillez saisir uniquement des chiffres',
    noCountriesFound: 'Aucun pays trouvé',
    countrySelectorLabel: 'Pays sélectionné : {country}. Appuyez pour changer.',
    favoritesLabel: 'Fréquemment utilisés',
  );

  @override
  Widget build(BuildContext context) {
    final languageCode = _french ? 'fr' : 'en';
    final localizations = _french ? _fr : IntlPhoneFieldLocalizations.fallback;
    final country = _value?.country;

    return DemoScaffold(
      title: 'Localization',
      description:
          'Open the picker and search: the hint, the country names '
          'and the error messages all follow the switch below.',
      children: <Widget>[
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Français'),
          subtitle: Text(
            _french
                ? "languageCode: 'fr' with French localizations"
                : "languageCode: 'en' with the shipped English defaults",
          ),
          value: _french,
          onChanged: (on) => setState(() => _french = on),
        ),
        const SizedBox(height: 16),
        DemoSection(
          title: 'The field',
          caption:
              'Clear the field and leave it to see the localised '
              '"required" message.',
          child: IntlPhoneField(
            key: ValueKey<String>(languageCode),
            initialCountryCode: 'FR',
            languageCode: languageCode,
            localizations: localizations,
            favoriteCountries: const <String>['FR', 'BE', 'CH', 'CA'],
            formatInput: true,
            showExampleAsHint: true,
            decoration: phoneDecoration(
              _french ? 'Numéro de téléphone' : 'Phone number',
            ),
            onChanged: (phone) => setState(() => _value = phone),
          ),
        ),
        PhoneValuePanel(
          value: _value,
          extras: <String, String>{
            'searchHint': localizations.searchHint,
            'invalidNumber': localizations.invalidNumber,
            if (country != null) ...<String, String>{
              'Country.name': country.name,
              'localizedName($languageCode)': country.localizedName(
                languageCode,
              ),
            },
          },
        ),
      ],
    );
  }
}
