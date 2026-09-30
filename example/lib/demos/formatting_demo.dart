import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:material_ui/material_ui.dart';

import '../demo_page.dart';

/// `formatInput: true` lays the national number out the way it is written
/// locally, as it is typed: `2015550123` shows as `(201) 555-0123` in the US
/// and `612345678` as `6 12 34 56 78` in France.
///
/// The value delivered on `onChanged` is always digits only, whatever is
/// displayed — the panel below proves it.
class FormattingDemo extends StatefulWidget {
  const FormattingDemo({super.key});

  static const String route = '/formatting';

  @override
  State<FormattingDemo> createState() => _FormattingDemoState();
}

class _FormattingDemoState extends State<FormattingDemo> {
  bool _formatInput = true;
  PhoneNumber? _value;

  @override
  Widget build(BuildContext context) {
    final value = _value;
    final country = value?.country;

    return DemoScaffold(
      title: 'As-you-type formatting',
      description:
          'Toggle formatInput and watch the field. The reported '
          'PhoneNumber.number never changes: formatting is presentation only.',
      children: <Widget>[
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('formatInput'),
          subtitle: Text(
            _formatInput
                ? 'On: separators are inserted while you type.'
                : 'Off: the raw digits are shown.',
          ),
          value: _formatInput,
          onChanged: (on) => setState(() => _formatInput = on),
        ),
        const SizedBox(height: 16),
        DemoSection(
          title: 'The field',
          caption:
              'Changing formatInput re-lays the digits already in the '
              'field; nothing is added or lost.',
          child: IntlPhoneField(
            initialCountryCode: 'US',
            initialValue: '2015550123',
            formatInput: _formatInput,
            showExampleAsHint: true,
            decoration: phoneDecoration(
              'Phone number',
              helper: 'Switch the country to FR or GB to see other layouts.',
            ),
            onChanged: (phone) => setState(() => _value = phone),
          ),
        ),
        PhoneValuePanel(
          value: value,
          title: 'Raw value vs formatted',
          extras: <String, String>{
            if (country != null)
              'AsYouTypeFormatter.format()': AsYouTypeFormatter.format(
                country,
                value!.number,
              ),
            if (country?.example != null)
              'country example': AsYouTypeFormatter.format(
                country!,
                country.example!,
              ),
          },
        ),
      ],
    );
  }
}
