import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';

import '../demo_page.dart';

/// [DialogType] decides how the country picker is presented. Pick a type
/// below, then tap the flag.
///
/// The same picker can also be opened directly, without a field, by calling
/// [showCountryPicker] — the button at the bottom of this page does that.
class PickerDemo extends StatefulWidget {
  const PickerDemo({super.key});

  static const String route = '/picker';

  @override
  State<PickerDemo> createState() => _PickerDemoState();
}

class _PickerDemoState extends State<PickerDemo> {
  DialogType _dialogType = DialogType.showDialog;
  PhoneNumber? _value;
  String _standalone = 'Picker not opened yet.';

  static const Map<DialogType, String> _labels = <DialogType, String>{
    DialogType.showDialog: 'Dialog',
    DialogType.showModalBottomSheet: 'Sheet',
    DialogType.showDraggableBottomSheet: 'Draggable',
    DialogType.showFullScreenPage: 'Full page',
    DialogType.adaptive: 'Adaptive',
  };

  static const Map<DialogType, String> _descriptions = <DialogType, String>{
    DialogType.showDialog: 'A centred Dialog. The default.',
    DialogType.showModalBottomSheet:
        'A modal bottom sheet sized by PickerDialogStyle.heightFactor.',
    DialogType.showDraggableBottomSheet:
        'A sheet the user can drag between a third and a full screen.',
    DialogType.showFullScreenPage:
        'A full-screen route, which suits small screens and long lists.',
    DialogType.adaptive:
        'A bottom sheet on iOS and macOS, a dialog everywhere else.',
  };

  Future<void> _openStandalone() async {
    final chosen = await showCountryPicker(
      context: context,
      countries: countries,
      selectedCountry: _value?.country ??
          CountryResolver.instance.byIsoCode('DE') ??
          countries.first,
      dialogType: _dialogType,
      favorites: const <Country>[],
    );
    if (!mounted) return;
    setState(() => _standalone =
        chosen == null ? 'Dismissed without choosing.' : 'Chose $chosen');
  }

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'Picker presentation',
      description: 'dialogType is read when the picker opens, so it can be '
          'changed at runtime.',
      children: <Widget>[
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: SegmentedButton<DialogType>(
            showSelectedIcon: false,
            segments: <ButtonSegment<DialogType>>[
              for (final entry in _labels.entries)
                ButtonSegment<DialogType>(
                  value: entry.key,
                  label: Text(entry.value),
                ),
            ],
            selected: <DialogType>{_dialogType},
            onSelectionChanged: (selection) =>
                setState(() => _dialogType = selection.first),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _descriptions[_dialogType]!,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 24),
        DemoSection(
          title: 'In a field',
          caption: 'Tap the flag to open the picker.',
          child: IntlPhoneField(
            key: ValueKey<DialogType>(_dialogType),
            initialCountryCode: 'DE',
            dialogType: _dialogType,
            favoriteCountries: const <String>['DE', 'FR', 'NL'],
            decoration: phoneDecoration('Phone number'),
            onChanged: (phone) => setState(() => _value = phone),
          ),
        ),
        PhoneValuePanel(value: _value),
        const SizedBox(height: 28),
        DemoSection(
          title: 'Without a field',
          caption: 'showCountryPicker() returns the chosen Country, or null '
              'if the user dismissed it.',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FilledButton.tonal(
                onPressed: _openStandalone,
                child: const Text('Open showCountryPicker()'),
              ),
              const SizedBox(height: 12),
              PhoneValuePanel(
                title: 'Result',
                extras: <String, String>{'returned': _standalone},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
