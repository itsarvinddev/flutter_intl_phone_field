import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';

import '../demo_page.dart';

/// The four ways a number gets rejected.
///
/// 1. The built-in length check, which every field does unless you set
///    `disableLengthCheck: true`.
/// 2. A synchronous [IntlPhoneField.validator], run after the length check.
/// 3. An asynchronous validator: return a `Future<String?>` and the field
///    re-validates itself when the future completes.
/// 4. `strictValidation: true`, which additionally requires the number to fall
///    in a range libphonenumber knows is assigned.
class ValidationDemo extends StatefulWidget {
  const ValidationDemo({super.key});

  static const String route = '/validation';

  @override
  State<ValidationDemo> createState() => _ValidationDemoState();
}

class _ValidationDemoState extends State<ValidationDemo> {
  PhoneNumber? _lengthValue;
  PhoneNumber? _syncValue;
  PhoneNumber? _asyncValue;
  PhoneNumber? _strictValue;

  /// Numbers this fictional backend reports as already registered.
  static const Set<String> _takenNumbers = <String>{
    '+15551234567',
    '+447400123456',
  };

  int _lookups = 0;
  String _lastLookup = 'No lookup yet.';

  /// Answers already fetched, keyed by complete number.
  ///
  /// The field validates more than once per number — on every rebuild while
  /// autovalidating — so a validator that hits the network must remember what
  /// it has already asked, or it will loop.
  final Map<String, bool> _answers = <String, bool>{};

  /// A validator that has to ask a server.
  ///
  /// The field shows the previous answer while the future is in flight and
  /// re-validates itself when it settles. State is only touched after the
  /// await: the synchronous part of a validator runs during build.
  Future<String?> _checkAvailability(PhoneNumber? phone) async {
    if (phone == null || phone.number.isEmpty) return 'Enter a number';
    if (!phone.isValidNumber()) return 'Not a valid number';

    final complete = phone.completeNumber;
    final known = _answers[complete];
    if (known != null) return known ? _takenMessage : null;

    await Future<void>.delayed(const Duration(milliseconds: 600));
    if (!mounted) return null;

    final taken = _takenNumbers.contains(complete);
    _answers[complete] = taken;
    final summary = taken ? '$complete is taken' : '$complete is available';
    if (summary != _lastLookup) {
      setState(() {
        _lookups++;
        _lastLookup = summary;
      });
    }
    return taken ? _takenMessage : null;
  }

  static const String _takenMessage = 'That number is already registered';

  /// A plain synchronous validator. It runs only after the built-in length
  /// check has passed, so it never has to repeat that work.
  String? _mustBeMobileLike(PhoneNumber? phone) {
    if (phone == null || phone.number.isEmpty) return 'Enter a number';
    if (phone.number.startsWith('0')) {
      return 'Drop the national trunk prefix (the leading 0)';
    }
    if (phone.countryISOCode == 'US' && !phone.number.startsWith('5')) {
      return 'US demo numbers must start with 5';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'Validation',
      description: 'Each field below is validated on user interaction '
          '(AutovalidateMode.onUserInteraction, the default).',
      children: <Widget>[
        DemoSection(
          title: '1. Built-in length check',
          caption: 'No validator at all. The field rejects anything outside '
              "the country's minLength..maxLength range.",
          child: Column(
            children: <Widget>[
              IntlPhoneField(
                initialCountryCode: 'US',
                showExampleAsHint: true,
                decoration: phoneDecoration('Length check only'),
                onChanged: (phone) => setState(() => _lengthValue = phone),
              ),
              PhoneValuePanel(value: _lengthValue),
            ],
          ),
        ),
        DemoSection(
          title: '2. Custom synchronous validator',
          caption: 'Runs after the length check. Returns a message, or null '
              'when the number is acceptable.',
          child: Column(
            children: <Widget>[
              IntlPhoneField(
                initialCountryCode: 'US',
                showExampleAsHint: true,
                decoration: phoneDecoration(
                  'Must start with 5 in the US',
                  helper: 'Try 5551234567, then 2125550123.',
                ),
                validator: _mustBeMobileLike,
                onChanged: (phone) => setState(() => _syncValue = phone),
              ),
              PhoneValuePanel(value: _syncValue),
            ],
          ),
        ),
        DemoSection(
          title: '3. Asynchronous validator',
          caption: 'Returns Future<String?>. Simulated with Future.delayed; '
              'in a real app this would be an availability check.',
          child: Column(
            children: <Widget>[
              IntlPhoneField(
                initialCountryCode: 'US',
                showExampleAsHint: true,
                decoration: phoneDecoration(
                  'Checked against a server',
                  helper: '+1 555 123 4567 is already registered.',
                ),
                validator: _checkAvailability,
                onChanged: (phone) => setState(() => _asyncValue = phone),
              ),
              PhoneValuePanel(
                value: _asyncValue,
                extras: <String, String>{
                  'lookups performed': '$_lookups',
                  'last lookup': _lastLookup,
                },
              ),
            ],
          ),
        ),
        DemoSection(
          title: '4. strictValidation',
          caption: 'Requires the number to match a real fixed-line or mobile '
              'range, not merely to be of a plausible length.',
          child: Column(
            children: <Widget>[
              IntlPhoneField(
                initialCountryCode: 'GB',
                showExampleAsHint: true,
                strictValidation: true,
                decoration: phoneDecoration(
                  'Strict',
                  helper: '7400123456 passes; 1111111111 is the right length '
                      'but no such range exists.',
                ),
                onChanged: (phone) => setState(() => _strictValue = phone),
              ),
              PhoneValuePanel(value: _strictValue),
            ],
          ),
        ),
      ],
    );
  }
}
