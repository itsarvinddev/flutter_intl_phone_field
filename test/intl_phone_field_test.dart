import 'dart:async';

import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';

/// The editable text of the phone field itself, never the picker's search box.
Finder get phoneInput => find.descendant(
  of: find.byType(IntlPhoneField),
  matching: find.byType(EditableText),
);

/// The tappable country selector sitting in the field's prefix.
Finder get countrySelector => find.descendant(
  of: find.byType(IntlPhoneField),
  matching: find.byType(InkWell),
);

String fieldText(WidgetTester tester) =>
    tester.widget<EditableText>(phoneInput).controller.text;

/// Matches [text] only inside the field (so the open picker cannot satisfy it).
Finder inField(String text) =>
    find.descendant(of: find.byType(IntlPhoneField), matching: find.text(text));

Country countryOf(String isoCode) =>
    countries.firstWhere((c) => c.code == isoCode);

/// Pumps an [IntlPhoneField] inside `MaterialApp > Scaffold > Form` and
/// returns the form's key, so tests can validate and save it.
Future<GlobalKey<FormState>> pumpField(
  WidgetTester tester, {
  String? initialValue,
  String? initialCountryCode,
  InitialValueFormat initialValueFormat = InitialValueFormat.auto,
  ValueChanged<PhoneNumber>? onChanged,
  ValueChanged<Country>? onCountryChanged,
  FormFieldSetter<PhoneNumber>? onSaved,
  FutureOr<String?> Function(PhoneNumber?)? validator,
  PhoneController? phoneController,
  GlobalKey<FormFieldState>? formFieldKey,
  bool enabled = true,
  bool disableLengthCheck = false,
  bool showCountryFlag = true,
  bool showCountryCode = true,
  bool showDropdownIcon = true,
  bool formatInput = false,
  bool detectCountryOnPaste = true,
  int? maxLength,
  List<String>? onlyCountries,
  Widget Function(BuildContext, Country)? flagBuilder,
  Widget Function(BuildContext, Country)? dialCodeBuilder,
  Widget Function(BuildContext, Country, VoidCallback)? countrySelectorBuilder,
  TextDirection? textDirection,
  InputDecoration decoration = const InputDecoration(),
  InputCounterWidgetBuilder? buildCounter,
}) async {
  final formKey = GlobalKey<FormState>();

  Widget body = Form(
    key: formKey,
    child: IntlPhoneField(
      formFieldKey: formFieldKey,
      initialValue: initialValue,
      initialCountryCode: initialCountryCode,
      initialValueFormat: initialValueFormat,
      onChanged: onChanged,
      onCountryChanged: onCountryChanged,
      onSaved: onSaved,
      validator: validator,
      phoneController: phoneController,
      enabled: enabled,
      disableLengthCheck: disableLengthCheck,
      showCountryFlag: showCountryFlag,
      showCountryCode: showCountryCode,
      showDropdownIcon: showDropdownIcon,
      formatInput: formatInput,
      detectCountryOnPaste: detectCountryOnPaste,
      maxLength: maxLength,
      onlyCountries: onlyCountries,
      flagBuilder: flagBuilder,
      dialCodeBuilder: dialCodeBuilder,
      countrySelectorBuilder: countrySelectorBuilder,
      decoration: decoration,
      buildCounter: buildCounter,
    ),
  );

  if (textDirection != null) {
    body = Directionality(textDirection: textDirection, child: body);
  }

  await tester.pumpWidget(MaterialApp(home: Scaffold(body: body)));
  await tester.pumpAndSettle();
  return formKey;
}

/// Opens the picker, searches for [name] and taps its row.
Future<void> pickCountry(WidgetTester tester, String name) async {
  await tester.tap(countrySelector);
  await tester.pumpAndSettle();
  expect(find.byType(CountryPickerBody), findsOneWidget);

  await tester.enterText(
    find.descendant(
      of: find.byType(CountryPickerBody),
      matching: find.byType(TextField),
    ),
    name,
  );
  await tester.pumpAndSettle();

  await tester.tap(
    find.descendant(of: find.byType(ListTile), matching: find.text(name)),
  );
  await tester.pumpAndSettle();
}

void main() {
  group('initialValue parsing', () {
    testWidgets('international value picks its own country', (tester) async {
      await pumpField(tester, initialValue: '+447400123456');

      expect(inField('+44'), findsOneWidget);
      expect(fieldText(tester), '7400123456');
    });

    testWidgets('keeps a national number that looks like a dial code', (
      tester,
    ) async {
      // Issue #19: '971123456' is a UAE national number, not '+971 123456'.
      await pumpField(
        tester,
        initialValue: '971123456',
        initialCountryCode: 'AE',
      );

      expect(inField('+971'), findsOneWidget);
      expect(fieldText(tester), '971123456');
    });

    testWidgets('keeps an Italian number starting with its dial code', (
      tester,
    ) async {
      await pumpField(
        tester,
        initialValue: '3921234567',
        initialCountryCode: 'IT',
      );

      expect(inField('+39'), findsOneWidget);
      expect(fieldText(tester), '3921234567');
    });

    testWidgets('keeps a Kazakh number starting with its dial code', (
      tester,
    ) async {
      await pumpField(
        tester,
        initialValue: '7011234567',
        initialCountryCode: 'KZ',
      );

      expect(inField('+7'), findsOneWidget);
      expect(fieldText(tester), '7011234567');
    });

    testWidgets('strips the country code from a + value', (tester) async {
      await pumpField(
        tester,
        initialValue: '+971501234567',
        initialCountryCode: 'AE',
      );

      expect(inField('+971'), findsOneWidget);
      expect(fieldText(tester), '501234567');
    });

    testWidgets('InitialValueFormat.national never strips', (tester) async {
      await pumpField(
        tester,
        initialValue: '+447400123456',
        initialCountryCode: 'GB',
        initialValueFormat: InitialValueFormat.national,
      );

      expect(fieldText(tester), '447400123456');
    });

    testWidgets('InitialValueFormat.international always strips', (
      tester,
    ) async {
      await pumpField(
        tester,
        initialValue: '447400123456',
        initialCountryCode: 'GB',
        initialValueFormat: InitialValueFormat.international,
      );

      expect(fieldText(tester), '7400123456');
    });

    testWidgets('the same value is kept verbatim in auto mode', (tester) async {
      await pumpField(
        tester,
        initialValue: '447400123456',
        initialCountryCode: 'GB',
      );

      expect(fieldText(tester), '447400123456');
    });

    testWidgets('initialCountryCode accepts a dial code', (tester) async {
      PhoneNumber? changed;
      await pumpField(
        tester,
        initialCountryCode: '+225',
        onChanged: (p) => changed = p,
      );

      expect(inField('+225'), findsOneWidget);

      await tester.enterText(phoneInput, '0123456789');
      await tester.pump();

      expect(changed?.countryISOCode, 'CI');
      expect(changed?.completeNumber, '+2250123456789');
    });
  });

  group('onChanged', () {
    testWidgets('reports the number as it is typed', (tester) async {
      final seen = <PhoneNumber>[];
      await pumpField(tester, initialCountryCode: 'GB', onChanged: seen.add);

      await tester.enterText(phoneInput, '740012');
      await tester.pump();
      await tester.enterText(phoneInput, '7400123456');
      await tester.pump();

      expect(seen, hasLength(2));
      expect(seen.first.number, '740012');
      expect(seen.last.number, '7400123456');
      expect(seen.last.countryISOCode, 'GB');
      expect(seen.last.countryCode, '+44');
      expect(seen.last.completeNumber, '+447400123456');
    });
  });

  group('country picker', () {
    testWidgets('picking a country notifies and updates the dial code', (
      tester,
    ) async {
      Country? picked;
      final changes = <PhoneNumber>[];
      await pumpField(
        tester,
        initialCountryCode: 'US',
        onCountryChanged: (c) => picked = c,
        onChanged: changes.add,
      );

      await tester.enterText(phoneInput, '2015550123');
      await tester.pump();
      changes.clear();

      await pickCountry(tester, 'Germany');

      expect(picked?.code, 'DE');
      expect(changes, hasLength(1));
      expect(changes.single.countryISOCode, 'DE');
      expect(changes.single.countryCode, '+49');
      expect(inField('+49'), findsOneWidget);
      expect(inField('+1'), findsNothing);
    });

    testWidgets('switching to a shorter country truncates the number', (
      tester,
    ) async {
      await pumpField(tester, initialCountryCode: 'US');

      await tester.enterText(phoneInput, '2015550123');
      await tester.pump();
      expect(fieldText(tester), '2015550123');

      // The UAE allows 9 digits, the United States 10.
      await pickCountry(tester, 'United Arab Emirates');

      expect(inField('+971'), findsOneWidget);
      expect(fieldText(tester), '201555012');
    });
  });

  group('selector contents', () {
    testWidgets('shows flag, dial code and arrow by default', (tester) async {
      await pumpField(tester, initialCountryCode: 'US');

      expect(find.byType(CountryFlag), findsOneWidget);
      expect(inField('+1'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_drop_down), findsOneWidget);
    });

    testWidgets('hides the flag', (tester) async {
      await pumpField(tester, initialCountryCode: 'US', showCountryFlag: false);

      expect(find.byType(CountryFlag), findsNothing);
      expect(inField('+1'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_drop_down), findsOneWidget);
    });

    testWidgets('hides the dial code', (tester) async {
      await pumpField(tester, initialCountryCode: 'US', showCountryCode: false);

      expect(find.byType(CountryFlag), findsOneWidget);
      expect(inField('+1'), findsNothing);
      expect(find.byIcon(Icons.arrow_drop_down), findsOneWidget);
    });

    testWidgets('hides the arrow', (tester) async {
      await pumpField(
        tester,
        initialCountryCode: 'US',
        showDropdownIcon: false,
      );

      expect(find.byType(CountryFlag), findsOneWidget);
      expect(inField('+1'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_drop_down), findsNothing);
    });

    testWidgets('hides everything at once', (tester) async {
      await pumpField(
        tester,
        initialCountryCode: 'US',
        showCountryFlag: false,
        showCountryCode: false,
        showDropdownIcon: false,
      );

      expect(find.byType(CountryFlag), findsNothing);
      expect(inField('+1'), findsNothing);
      expect(find.byIcon(Icons.arrow_drop_down), findsNothing);
      // The selector is still there and still opens the picker.
      expect(countrySelector, findsOneWidget);
    });
  });

  group('length', () {
    testWidgets('stops at the country maximum', (tester) async {
      await pumpField(tester, initialCountryCode: 'US');

      await tester.enterText(phoneInput, '2015550123');
      await tester.pump();
      expect(fieldText(tester), '2015550123');

      // An eleventh digit is refused; the ten already typed survive.
      await tester.enterText(phoneInput, '20155501234');
      await tester.pump();
      expect(fieldText(tester), '2015550123');
    });

    testWidgets('disableLengthCheck allows typing past the maximum', (
      tester,
    ) async {
      await pumpField(
        tester,
        initialCountryCode: 'US',
        disableLengthCheck: true,
      );

      await tester.enterText(phoneInput, '20155501239999');
      await tester.pump();

      expect(fieldText(tester), '20155501239999');
    });
  });

  group('validation', () {
    testWidgets('a too-short number is reported', (tester) async {
      final form = await pumpField(tester, initialCountryCode: 'US');

      await tester.enterText(phoneInput, '201');
      await tester.pump();

      expect(form.currentState!.validate(), isFalse);
      await tester.pump();
      expect(find.text('Invalid phone number'), findsOneWidget);
    });

    testWidgets('a valid number reports nothing', (tester) async {
      final form = await pumpField(tester, initialCountryCode: 'US');

      await tester.enterText(phoneInput, '2015550123');
      await tester.pump();

      expect(form.currentState!.validate(), isTrue);
      await tester.pump();
      expect(find.text('Invalid phone number'), findsNothing);
    });

    testWidgets('a custom validator runs after the length check', (
      tester,
    ) async {
      final form = await pumpField(
        tester,
        initialCountryCode: 'US',
        validator: (_) => 'custom rejection',
      );

      await tester.enterText(phoneInput, '201');
      await tester.pump();
      expect(form.currentState!.validate(), isFalse);
      await tester.pump();

      // The built-in length check wins while the number is the wrong length.
      expect(find.text('Invalid phone number'), findsOneWidget);
      expect(find.text('custom rejection'), findsNothing);

      await tester.enterText(phoneInput, '2015550123');
      await tester.pump();
      expect(form.currentState!.validate(), isFalse);
      await tester.pump();

      expect(find.text('custom rejection'), findsOneWidget);
      expect(find.text('Invalid phone number'), findsNothing);
    });

    testWidgets('an async validator eventually shows its message', (
      tester,
    ) async {
      final completer = Completer<String?>();
      final fieldKey = GlobalKey<FormFieldState>();
      final form = await pumpField(
        tester,
        initialCountryCode: 'US',
        formFieldKey: fieldKey,
        validator: (_) => completer.future,
      );

      await tester.enterText(phoneInput, '2015550123');
      await tester.pump();
      expect(form.currentState!.validate(), isTrue);
      await tester.pump();
      expect(find.text('taken already'), findsNothing);

      completer.complete('taken already');
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('taken already'), findsOneWidget);
      expect(fieldKey.currentState!.hasError, isTrue);
    });
  });

  group('form integration', () {
    testWidgets('onSaved delivers the number', (tester) async {
      PhoneNumber? saved;
      final form = await pumpField(
        tester,
        initialCountryCode: 'GB',
        onSaved: (p) => saved = p,
      );

      await tester.enterText(phoneInput, '7400123456');
      await tester.pump();

      form.currentState!.save();

      expect(saved, isNotNull);
      expect(saved!.countryISOCode, 'GB');
      expect(saved!.countryCode, '+44');
      expect(saved!.number, '7400123456');
      expect(saved!.completeNumber, '+447400123456');
    });
  });

  group('enabled: false', () {
    testWidgets('hides the arrow and never opens the picker', (tester) async {
      await pumpField(tester, initialCountryCode: 'US', enabled: false);

      expect(find.byIcon(Icons.arrow_drop_down), findsNothing);

      await tester.tap(inField('+1'), warnIfMissed: false);
      await tester.pumpAndSettle();

      expect(find.byType(CountryPickerBody), findsNothing);
    });
  });

  group('PhoneController', () {
    testWidgets('drives and follows the field', (tester) async {
      final controller = PhoneController.fromParts(isoCode: 'US');
      addTearDown(controller.dispose);

      final changes = <PhoneNumber>[];
      await pumpField(
        tester,
        phoneController: controller,
        onChanged: changes.add,
      );

      expect(inField('+1'), findsOneWidget);

      controller.country = countryOf('DE');
      await tester.pump();
      expect(inField('+49'), findsOneWidget);
      expect(inField('+1'), findsNothing);

      controller.number = '15123456789';
      await tester.pump();
      expect(fieldText(tester), '15123456789');

      await tester.enterText(phoneInput, '17612345678');
      await tester.pump();

      expect(controller.value.number, '17612345678');
      expect(controller.value.countryISOCode, 'DE');
      expect(controller.completeNumber, '+4917612345678');
      expect(changes.last, controller.value);
    });
  });

  group('formatInput', () {
    testWidgets('formats as you type but reports digits only', (tester) async {
      PhoneNumber? changed;
      await pumpField(
        tester,
        initialCountryCode: 'US',
        formatInput: true,
        onChanged: (p) => changed = p,
      );

      await tester.enterText(phoneInput, '2015550123');
      await tester.pump();

      expect(fieldText(tester), '(201) 555-0123');
      expect(changed?.number, '2015550123');
      expect(changed?.completeNumber, '+12015550123');
    });

    // The formatting itself is right; only the character cap above breaks it.
    testWidgets('formats without the length cap in the way', (tester) async {
      PhoneNumber? changed;
      await pumpField(
        tester,
        initialCountryCode: 'US',
        formatInput: true,
        disableLengthCheck: true,
        onChanged: (p) => changed = p,
      );

      await tester.enterText(phoneInput, '2015550123');
      await tester.pump();

      expect(fieldText(tester), '(201) 555-0123');
      expect(changed?.number, '2015550123');
      expect(changed?.completeNumber, '+12015550123');
    });
  });

  group('detectCountryOnPaste', () {
    testWidgets('an international number switches the country', (tester) async {
      Country? picked;
      await pumpField(
        tester,
        initialCountryCode: 'US',
        onCountryChanged: (c) => picked = c,
      );

      await tester.enterText(phoneInput, '+447400123456');
      await tester.pump();

      expect(picked?.code, 'GB');
      expect(inField('+44'), findsOneWidget);
      expect(fieldText(tester), '7400123456');
    });
  });

  group('builders', () {
    testWidgets('flagBuilder replaces the flag', (tester) async {
      await pumpField(
        tester,
        initialCountryCode: 'US',
        flagBuilder: (context, country) => Text('flag:${country.code}'),
      );

      expect(find.byType(CountryFlag), findsNothing);
      expect(find.text('flag:US'), findsOneWidget);
      expect(inField('+1'), findsOneWidget);
    });

    testWidgets('dialCodeBuilder replaces the dial code', (tester) async {
      await pumpField(
        tester,
        initialCountryCode: 'US',
        dialCodeBuilder: (context, country) => Text('cc:${country.dialCode}'),
      );

      expect(find.byType(CountryFlag), findsOneWidget);
      expect(find.text('cc:1'), findsOneWidget);
      expect(inField('+1'), findsNothing);
    });

    testWidgets('countrySelectorBuilder replaces the whole selector', (
      tester,
    ) async {
      await pumpField(
        tester,
        initialCountryCode: 'US',
        countrySelectorBuilder: (context, country, openPicker) => TextButton(
          onPressed: openPicker,
          child: Text('pick ${country.code}'),
        ),
      );

      expect(find.byType(CountryFlag), findsNothing);
      expect(inField('+1'), findsNothing);
      expect(find.text('pick US'), findsOneWidget);

      await tester.tap(find.text('pick US'));
      await tester.pumpAndSettle();
      expect(find.byType(CountryPickerBody), findsOneWidget);
    });
  });

  group('material_ui types', () {
    // The public API takes material_ui's InputDecoration and
    // InputCounterWidgetBuilder, not the SDK's same-named types.
    testWidgets('decoration and buildCounter are applied', (tester) async {
      await pumpField(
        tester,
        initialCountryCode: 'US',
        decoration: const InputDecoration(labelText: 'Phone'),
        buildCounter:
            (
              context, {
              required currentLength,
              required isFocused,
              required maxLength,
            }) => Text('counter:$currentLength'),
      );

      expect(find.text('Phone'), findsOneWidget);
      expect(find.text('counter:0'), findsOneWidget);
    });
  });

  group('right-to-left', () {
    testWidgets('builds and keeps the dial code left-to-right', (tester) async {
      await pumpField(
        tester,
        initialCountryCode: 'AE',
        textDirection: TextDirection.rtl,
      );

      expect(find.byType(IntlPhoneField), findsOneWidget);
      expect(tester.takeException(), isNull);

      final dialCode = tester.widget<Text>(inField('+971'));
      expect(dialCode.textDirection, TextDirection.ltr);
    });
  });
}
