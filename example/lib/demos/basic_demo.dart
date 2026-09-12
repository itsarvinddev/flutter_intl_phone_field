import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';

import '../demo_page.dart';

/// The smallest useful setup: one [IntlPhoneField] inside a [Form].
///
/// The field is a `TextFormField`, so it takes part in form validation and
/// saving exactly like any other field: `_formKey.currentState!.validate()`
/// runs its validator, and `save()` delivers the [PhoneNumber] to [onSaved].
class BasicDemo extends StatefulWidget {
  const BasicDemo({super.key});

  static const String route = '/basic';

  @override
  State<BasicDemo> createState() => _BasicDemoState();
}

class _BasicDemoState extends State<BasicDemo> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// The value reported by `onChanged` on every keystroke.
  PhoneNumber? _live;

  /// The value captured by `onSaved` when the form was last submitted.
  PhoneNumber? _submitted;

  String _status = 'Not submitted yet.';

  void _submit() {
    final form = _formKey.currentState!;
    if (!form.validate()) {
      setState(() => _status = 'The form is not valid.');
      return;
    }
    form.save();
    setState(() => _status = 'Submitted.');
  }

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'Basic usage & forms',
      description: 'The field edits the national part of the number and hands '
          'you a PhoneNumber. Submit runs the form validator, then save() '
          'delivers the value to onSaved.',
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              DemoSection(
                title: 'IntlPhoneField',
                caption: 'initialCountryCode: US, with the country example '
                    'number as the hint.',
                child: IntlPhoneField(
                  initialCountryCode: 'US',
                  showExampleAsHint: true,
                  decoration: phoneDecoration('Phone number'),
                  onChanged: (phone) => setState(() => _live = phone),
                  onSaved: (phone) => setState(() => _submitted = phone),
                  onCountryChanged: (country) => setState(
                    () => _status = 'Country changed to ${country.name}.',
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  FilledButton(
                    onPressed: _submit,
                    child: const Text('Submit'),
                  ),
                  const SizedBox(width: 12),
                  OutlinedButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                      setState(() {
                        _live = null;
                        _submitted = null;
                        _status = 'Form reset.';
                      });
                    },
                    child: const Text('Reset'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        PhoneValuePanel(
          value: _live,
          title: 'onChanged',
          extras: <String, String>{'status': _status},
        ),
        const SizedBox(height: 16),
        PhoneValuePanel(value: _submitted, title: 'onSaved'),
      ],
    );
  }
}
