import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';

import '../demo_page.dart';

/// Three levels of customisation, from cheapest to most thorough:
///
/// * [PickerDialogStyle] restyles the picker without replacing it.
/// * [IntlPhoneField.flagShape] and [IntlPhoneField.flagSize] (plus
///   [IntlPhoneField.dropdownIcon], [IntlPhoneField.dropdownDecoration] and
///   friends) restyle the selector button.
/// * [IntlPhoneField.countrySelectorBuilder] replaces the selector entirely.
///   It receives a callback that opens the picker, so your widget can still
///   trigger it.
class StylingDemo extends StatefulWidget {
  const StylingDemo({super.key});

  static const String route = '/styling';

  @override
  State<StylingDemo> createState() => _StylingDemoState();
}

class _StylingDemoState extends State<StylingDemo> {
  PhoneNumber? _dark;
  PhoneNumber? _flags;
  PhoneNumber? _custom;

  /// A picker that stays dark whatever the app theme is doing.
  static const PickerDialogStyle _darkPicker = PickerDialogStyle(
    backgroundColor: Color(0xFF1B2430),
    countryNameStyle: TextStyle(color: Colors.white),
    countryCodeStyle: TextStyle(color: Color(0xFF8FD3FF)),
    searchFieldStyle: TextStyle(color: Colors.white),
    searchFieldCursorColor: Colors.white,
    searchFieldInputDecoration: InputDecoration(
      labelText: 'Search country',
      labelStyle: TextStyle(color: Colors.white70),
      prefixIcon: Icon(Icons.search, color: Colors.white70),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white24),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    ),
    listTileDivider: Divider(color: Colors.white12, height: 1),
    listTilePadding: EdgeInsets.symmetric(horizontal: 12),
    selectedTileColor: Color(0xFF2A3A4D),
    padding: EdgeInsets.all(16),
    heightFactor: 0.85,
    flagShape: FlagShape.rounded,
    flagSize: 30,
    autofocusSearchField: true,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DemoScaffold(
      title: 'Styling',
      description:
          'Open each picker to see the difference. None of these '
          'fields changes behaviour — only presentation.',
      children: <Widget>[
        DemoSection(
          title: 'PickerDialogStyle',
          caption:
              'A dark picker, with a rounded flag, a focused search '
              'field and a custom divider.',
          child: Column(
            children: <Widget>[
              IntlPhoneField(
                initialCountryCode: 'SE',
                pickerDialogStyle: _darkPicker,
                dialogType: DialogType.showModalBottomSheet,
                decoration: phoneDecoration('Dark picker'),
                onChanged: (phone) => setState(() => _dark = phone),
              ),
              PhoneValuePanel(value: _dark),
            ],
          ),
        ),
        DemoSection(
          title: 'flagShape, flagSize and the dropdown icon',
          caption:
              'A circular 26px flag, the arrow moved to the trailing '
              'edge, and a tinted selector background.',
          child: Column(
            children: <Widget>[
              IntlPhoneField(
                initialCountryCode: 'BR',
                flagShape: FlagShape.circle,
                flagSize: 26,
                dropdownIconPosition: IconPosition.trailing,
                dropdownIcon: Icon(
                  Icons.expand_more,
                  color: theme.colorScheme.primary,
                ),
                dropdownTextStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: theme.colorScheme.primary,
                ),
                dropdownDecoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                flagsButtonMargin: const EdgeInsets.all(6),
                flagsButtonPadding: const EdgeInsets.symmetric(horizontal: 4),
                decoration: phoneDecoration('Restyled selector'),
                onChanged: (phone) => setState(() => _flags = phone),
              ),
              PhoneValuePanel(value: _flags),
            ],
          ),
        ),
        DemoSection(
          title: 'countrySelectorBuilder',
          caption:
              'The selector is replaced by a chip of our own. The '
              'openPicker callback still opens the picker.',
          child: Column(
            children: <Widget>[
              IntlPhoneField(
                initialCountryCode: 'ZA',
                decoration: phoneDecoration('Custom selector'),
                countrySelectorBuilder: (context, country, openPicker) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    child: ActionChip(
                      avatar: CountryFlag(
                        country: country,
                        shape: FlagShape.circle,
                        size: 22,
                      ),
                      label: Text(
                        '${country.code} +${country.displayCC}',
                        textDirection: TextDirection.ltr,
                      ),
                      onPressed: openPicker,
                    ),
                  );
                },
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
