import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';

import '../demo_page.dart';

/// A [PhoneController] is a `ValueNotifier<PhoneNumber>`, so the field's value
/// can be read, written and listened to from outside the widget.
///
/// Writing to the controller updates the field, and typing in the field
/// updates the controller — the two stay in step.
class ControllerDemo extends StatefulWidget {
  const ControllerDemo({super.key});

  static const String route = '/controller';

  @override
  State<ControllerDemo> createState() => _ControllerDemoState();
}

class _ControllerDemoState extends State<ControllerDemo> {
  /// Starts at a full international number; `fromParts` is the other factory.
  final PhoneController _controller =
      PhoneController.fromCompleteNumber('+14155550123');

  /// The last value captured by the "Read completeNumber" button.
  String? _readBack;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setCountry(String isoCode) {
    final country = CountryResolver.instance.byIsoCode(isoCode);
    if (country == null) return;
    setState(() => _controller.country = country);
  }

  @override
  Widget build(BuildContext context) {
    return DemoScaffold(
      title: 'PhoneController',
      description: 'The buttons below write to the controller; the field '
          'follows. Type in the field and the panel follows.',
      children: <Widget>[
        DemoSection(
          title: 'The field',
          caption: 'IntlPhoneField(phoneController: controller)',
          child: IntlPhoneField(
            phoneController: _controller,
            formatInput: true,
            decoration: phoneDecoration('Phone number'),
          ),
        ),
        DemoSection(
          title: 'Drive it from code',
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              OutlinedButton.icon(
                icon: const Text('FR'),
                label: const Text('Set country'),
                onPressed: () => _setCountry('FR'),
              ),
              OutlinedButton.icon(
                icon: const Text('JP'),
                label: const Text('Set country'),
                onPressed: () => _setCountry('JP'),
              ),
              OutlinedButton(
                onPressed: () =>
                    setState(() => _controller.number = '612345678'),
                child: const Text('Set number 612345678'),
              ),
              OutlinedButton(
                onPressed: () => setState(
                  () => _controller.completeNumber = '+442071838750',
                ),
                child: const Text('Set +44 20 7183 8750'),
              ),
              OutlinedButton(
                onPressed: () => setState(_controller.clear),
                child: const Text('Clear'),
              ),
              FilledButton(
                onPressed: () => setState(
                  () => _readBack = _controller.completeNumber,
                ),
                child: const Text('Read completeNumber'),
              ),
            ],
          ),
        ),
        // The controller is a ValueNotifier, so the panel can simply listen.
        ValueListenableBuilder<PhoneNumber>(
          valueListenable: _controller,
          builder: (context, value, _) => PhoneValuePanel(
            value: value,
            title: 'controller.value',
            extras: <String, String>{
              'controller.isValid': '${_controller.isValid}',
              'last read': _readBack ?? '(button not pressed yet)',
            },
          ),
        ),
      ],
    );
  }
}
