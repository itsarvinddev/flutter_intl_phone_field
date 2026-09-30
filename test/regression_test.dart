import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> pump(WidgetTester tester, Widget child) =>
    tester.pumpWidget(MaterialApp(home: Scaffold(body: child)));

void main() {
  testWidgets(
    '#19: a national number keeping digits that match the dial code',
    (tester) async {
      // The UAE case from the issue: +971, local number starting 971.
      await pump(
        tester,
        const IntlPhoneField(
          initialCountryCode: 'AE',
          initialValue: '971123456',
        ),
      );
      expect(
        find.text('971123456'),
        findsOneWidget,
        reason: 'the old code produced 123456',
      );
    },
  );

  testWidgets('#19: the same shape for Italy and Kazakhstan', (tester) async {
    await pump(
      tester,
      const IntlPhoneField(
        initialCountryCode: 'IT',
        initialValue: '3921234567',
      ),
    );
    expect(find.text('3921234567'), findsOneWidget);

    await pump(
      tester,
      const IntlPhoneField(
        initialCountryCode: 'KZ',
        initialValue: '7011234567',
      ),
    );
    expect(find.text('7011234567'), findsOneWidget);
  });

  testWidgets('an international initialValue still has its code stripped', (
    tester,
  ) async {
    await pump(
      tester,
      const IntlPhoneField(
        initialCountryCode: 'AE',
        initialValue: '+971501234567',
      ),
    );
    expect(find.text('501234567'), findsOneWidget);
  });

  testWidgets('a 00 international prefix is handled', (tester) async {
    await pump(
      tester,
      const IntlPhoneField(
        initialCountryCode: 'AE',
        initialValue: '00971501234567',
      ),
    );
    expect(
      find.text('501234567'),
      findsOneWidget,
      reason: '00 was previously passed through untouched',
    );
  });

  testWidgets('country is detected from an international value alone', (
    tester,
  ) async {
    await pump(tester, const IntlPhoneField(initialValue: '+447400123456'));
    expect(find.text('7400123456'), findsOneWidget);
    expect(find.text('+44'), findsOneWidget);
  });

  testWidgets('InitialValueFormat.national never strips', (tester) async {
    await pump(
      tester,
      const IntlPhoneField(
        initialCountryCode: 'GB',
        initialValue: '447400123456',
        initialValueFormat: InitialValueFormat.national,
      ),
    );
    expect(find.text('447400123456'), findsOneWidget);
  });

  testWidgets('#18: showDropdownIcon false hides the arrow', (tester) async {
    await pump(tester, const IntlPhoneField(initialCountryCode: 'IN'));
    expect(find.byIcon(Icons.arrow_drop_down), findsOneWidget);

    await pump(
      tester,
      const IntlPhoneField(initialCountryCode: 'IN', showDropdownIcon: false),
    );
    expect(find.byIcon(Icons.arrow_drop_down), findsNothing);
  });

  testWidgets('the selector shows the area code for NANP territories', (
    tester,
  ) async {
    await pump(tester, const IntlPhoneField(initialCountryCode: 'AG'));
    expect(find.text('+1 268'), findsOneWidget);
  });

  testWidgets('as-you-type formatting keeps onChanged digits-only', (
    tester,
  ) async {
    PhoneNumber? seen;
    await pump(
      tester,
      IntlPhoneField(
        initialCountryCode: 'US',
        formatInput: true,
        onChanged: (p) => seen = p,
      ),
    );
    await tester.enterText(find.byType(TextField), '2015550123');
    await tester.pump();
    expect(find.text('(201) 555-0123'), findsOneWidget);
    expect(seen?.number, '2015550123');
    expect(seen?.completeNumber, '+12015550123');
  });

  testWidgets('changing country fires onChanged as well as onCountryChanged', (
    tester,
  ) async {
    Country? country;
    PhoneNumber? number;
    await pump(
      tester,
      IntlPhoneField(
        initialCountryCode: 'US',
        onCountryChanged: (c) => country = c,
        onChanged: (p) => number = p,
      ),
    );
    await tester.tap(find.byIcon(Icons.arrow_drop_down));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, 'Kenya');
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kenya').last);
    await tester.pumpAndSettle();
    expect(country?.code, 'KE');
    expect(
      number?.countryISOCode,
      'KE',
      reason: 'onChanged never fired on country change before',
    );
  });

  group('no controller writes during build', () {
    Widget form(Widget field) => MaterialApp(
      home: Scaffold(body: Form(child: field)),
    );

    testWidgets('a new initialCountryCode reformats after the frame', (
      tester,
    ) async {
      final controller = TextEditingController();
      addTearDown(controller.dispose);
      Country? changed;
      PhoneNumber? reported;
      Widget field(String country) => form(
        IntlPhoneField(
          controller: controller,
          initialCountryCode: country,
          formatInput: true,
          onCountryChanged: (c) => changed = c,
          onChanged: (p) => reported = p,
        ),
      );
      await tester.pumpWidget(field('IN'));
      await tester.enterText(find.byType(TextField), '2125550100');
      await tester.pump();

      await tester.pumpWidget(field('US'));
      expect(
        tester.takeException(),
        isNull,
        reason: 'setState() or markNeedsBuild() called during build',
      );
      expect(controller.text, '(212) 555-0100');
      expect(changed?.code, 'US');
      expect(reported?.completeNumber, '+12125550100');
      await tester.pump();
      expect(find.text('(212) 555-0100'), findsOneWidget);
    });

    testWidgets('turning formatInput on reformats after the frame', (
      tester,
    ) async {
      final controller = TextEditingController();
      addTearDown(controller.dispose);
      Widget field({required bool formatInput}) => form(
        IntlPhoneField(
          controller: controller,
          initialCountryCode: 'US',
          formatInput: formatInput,
        ),
      );
      await tester.pumpWidget(field(formatInput: false));
      await tester.enterText(find.byType(TextField), '2125550100');
      await tester.pump();

      await tester.pumpWidget(field(formatInput: true));
      expect(tester.takeException(), isNull);
      expect(controller.text, '(212) 555-0100');
      await tester.pumpWidget(field(formatInput: false));
      expect(tester.takeException(), isNull);
      expect(controller.text, '2125550100');
    });

    testWidgets('mounting on text that is already parsed notifies no one', (
      tester,
    ) async {
      // Two screens sharing one controller, the second mounting while the
      // first is still on screen: the old field must not be told to rebuild
      // in the middle of the new one's build.
      final controller = TextEditingController(text: '2125550100');
      addTearDown(controller.dispose);
      var notified = 0;
      controller.addListener(() => notified++);
      Widget screens({required bool both}) => form(
        Column(
          children: [
            IntlPhoneField(
              key: const ValueKey('a'),
              controller: controller,
              initialCountryCode: 'US',
            ),
            if (both)
              IntlPhoneField(
                key: const ValueKey('b'),
                controller: controller,
                initialCountryCode: 'US',
              ),
          ],
        ),
      );
      await tester.pumpWidget(screens(both: false));
      // Where typing leaves the cursor.
      controller.selection = const TextSelection.collapsed(offset: 10);
      notified = 0;
      await tester.pumpWidget(screens(both: true));
      expect(tester.takeException(), isNull);
      expect(notified, 0);
      expect(controller.text, '2125550100');
    });
  });
}
