import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:material_ui/material_ui.dart';

/// A compact tour of what the field can look like, several variants on one
/// screen.
///
/// Every other page in this app explains one feature in depth; this one is
/// here to show the range at a glance.
class ShowcaseDemo extends StatelessWidget {
  const ShowcaseDemo({super.key});

  static const String route = '/showcase';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Showcase'),
        // Every field below is the same IntlPhoneField.
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        children: <Widget>[
          const _Variant(
            label: 'Default',
            code: 'IntlPhoneField(initialCountryCode: \'US\')',
            child: IntlPhoneField(
              initialCountryCode: 'US',
              showExampleAsHint: true,
              decoration: InputDecoration(
                labelText: 'Phone number',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const _Variant(
            label: 'Formatted as you type',
            code: 'formatInput: true',
            child: IntlPhoneField(
              initialCountryCode: 'US',
              initialValue: '2015550123',
              formatInput: true,
              decoration: InputDecoration(
                labelText: 'Mobile',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const _Variant(
            label: 'Circular flag, no arrow',
            code: 'flagShape: FlagShape.circle, showDropdownIcon: false',
            child: IntlPhoneField(
              initialCountryCode: 'FR',
              initialValue: '612345678',
              formatInput: true,
              flagShape: FlagShape.circle,
              flagSize: 26,
              showDropdownIcon: false,
              decoration: InputDecoration(
                labelText: 'Téléphone',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          const _Variant(
            label: 'Flag only',
            code: 'showCountryCode: false',
            child: IntlPhoneField(
              initialCountryCode: 'IN',
              initialValue: '8123456789',
              showCountryCode: false,
              flagShape: FlagShape.rounded,
              decoration: InputDecoration(
                labelText: 'WhatsApp',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          _Variant(
            label: 'Your own selector',
            code: 'countrySelectorBuilder: ...',
            child: IntlPhoneField(
              initialCountryCode: 'BR',
              initialValue: '11961234567',
              formatInput: true,
              decoration: const InputDecoration(
                labelText: 'Celular',
                border: OutlineInputBorder(),
              ),
              countrySelectorBuilder: (context, country, openPicker) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: ActionChip(
                  avatar: CountryFlag(country: country, size: 20),
                  label: Text('+${country.displayCC}'),
                  onPressed: openPicker,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Variant extends StatelessWidget {
  const _Variant({
    required this.label,
    required this.code,
    required this.child,
  });

  final String label;
  final String code;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            code,
            style: theme.textTheme.bodySmall?.copyWith(
              fontFamily: 'monospace',
              color: theme.colorScheme.outline,
            ),
          ),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}
