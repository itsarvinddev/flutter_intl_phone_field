import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:material_ui/material_ui.dart';

import '../demo_page.dart';

/// The situations that break phone fields.
///
/// * Right-to-left layouts, where a naive implementation renders `+971` as
///   `971+`. The dial code is pinned to LTR, so it reads correctly either way.
/// * Large text scales, where a fixed-height selector clips the flag.
/// * Disabled and read-only fields, which must not open the picker.
/// * A pre-filled national number whose leading digits happen to match the
///   country's calling code (issue #19). `971234567` is a real UAE national
///   number, not `+971 234567`, and must be left exactly as given.
class EdgeCasesDemo extends StatefulWidget {
  const EdgeCasesDemo({super.key});

  static const String route = '/edge-cases';

  @override
  State<EdgeCasesDemo> createState() => _EdgeCasesDemoState();
}

class _EdgeCasesDemoState extends State<EdgeCasesDemo> {
  PhoneNumber? _rtl;
  PhoneNumber? _scaled;
  PhoneNumber? _national;
  PhoneNumber? _international;
  PhoneNumber? _forcedNational;

  double _textScale = 1.8;

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'Edge cases',
      description:
          'Layout and parsing situations that are easy to get wrong. '
          'Each one is shown with its live value so the behaviour is visible.',
      children: <Widget>[
        DemoSection(
          title: 'Right-to-left',
          caption:
              'Wrapped in Directionality(textDirection: TextDirection.rtl). '
              'The dial code still reads "+971", never "971+".',
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              children: <Widget>[
                IntlPhoneField(
                  initialCountryCode: 'AE',
                  languageCode: 'ar',
                  showExampleAsHint: true,
                  decoration: phoneDecoration('رقم الهاتف'),
                  onChanged: (phone) => setState(() => _rtl = phone),
                ),
                Directionality(
                  textDirection: TextDirection.ltr,
                  child: PhoneValuePanel(value: _rtl),
                ),
              ],
            ),
          ),
        ),
        DemoSection(
          title: 'Large text scale',
          caption: 'The selector grows with the text instead of clipping.',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Slider(
                min: 1,
                max: 2.5,
                divisions: 6,
                value: _textScale,
                label: 'x${_textScale.toStringAsFixed(1)}',
                onChanged: (value) => setState(() => _textScale = value),
              ),
              MediaQuery.withClampedTextScaling(
                minScaleFactor: _textScale,
                maxScaleFactor: _textScale,
                child: IntlPhoneField(
                  initialCountryCode: 'IN',
                  showExampleAsHint: true,
                  decoration: phoneDecoration('Phone number'),
                  onChanged: (phone) => setState(() => _scaled = phone),
                ),
              ),
              const SizedBox(height: 12),
              PhoneValuePanel(value: _scaled),
            ],
          ),
        ),
        DemoSection(
          title: 'Disabled and read-only',
          caption:
              'enabled: false greys the field out and blocks the picker. '
              'readOnly: true keeps it legible and selectable, but not '
              'editable — the picker still opens.',
          child: Column(
            children: const <Widget>[
              IntlPhoneField(
                initialCountryCode: 'IT',
                initialValue: '3123456789',
                enabled: false,
                decoration: InputDecoration(
                  labelText: 'Disabled',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              IntlPhoneField(
                initialCountryCode: 'IT',
                initialValue: '3123456789',
                readOnly: true,
                formatInput: true,
                decoration: InputDecoration(
                  labelText: 'Read-only',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'Pre-filled national number (issue #19)',
          caption:
              "initialValue: '971234567' with initialCountryCode: 'AE'. "
              'The value is national, so the leading 971 is subscriber '
              'digits — not the calling code — and is kept.',
          child: Column(
            children: <Widget>[
              IntlPhoneField(
                initialCountryCode: 'AE',
                initialValue: '971234567',
                decoration: phoneDecoration('UAE, national value'),
                onChanged: (phone) => setState(() => _national = phone),
              ),
              PhoneValuePanel(
                value: _national,
                extras: const <String, String>{'expected number': '971234567'},
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'Pre-filled international number',
          caption:
              "initialValue: '+971501234567'. It starts with '+', so the "
              'calling code is stripped and the country is detected.',
          child: Column(
            children: <Widget>[
              IntlPhoneField(
                initialValue: '+971501234567',
                decoration: phoneDecoration('Detected from the value'),
                onChanged: (phone) => setState(() => _international = phone),
              ),
              PhoneValuePanel(
                value: _international,
                extras: const <String, String>{'expected number': '501234567'},
              ),
            ],
          ),
        ),
        DemoSection(
          title: 'InitialValueFormat.national',
          caption:
              'Forces the national reading even for a value that looks '
              'international. Use it when you know your stored numbers never '
              'carry a calling code.',
          child: Column(
            children: <Widget>[
              IntlPhoneField(
                initialCountryCode: 'AE',
                initialValue: '00971501',
                initialValueFormat: InitialValueFormat.national,
                disableLengthCheck: true,
                decoration: phoneDecoration('Never stripped'),
                onChanged: (phone) => setState(() => _forcedNational = phone),
              ),
              PhoneValuePanel(
                value: _forcedNational,
                extras: const <String, String>{'expected number': '00971501'},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
