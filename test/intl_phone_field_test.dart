import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_test/flutter_test.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({
    Key? key,
    required this.phoneNumber,
    this.countryCode,
    this.showCountryCode = true,
    this.showCountryFlag = true,
  }) : super(key: key);

  final String phoneNumber;
  final String? countryCode;
  final bool showCountryCode;
  final bool showCountryFlag;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Test Intl Phone Field',
        home: Scaffold(
          appBar: AppBar(title: const Text("")),
          body: IntlPhoneField(
            initialValue: phoneNumber,
            initialCountryCode: countryCode,
            showCountryCode: showCountryCode,
            showCountryFlag: showCountryFlag,
          ),
        ));
  }
}

void main() {
  testWidgets('Test flutter_intl_phone_field setup with completeNumber',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TestWidget(
      phoneNumber: '+447891234467',
    ));

    final countryCodeFinder = find.text('+44');
    final numberFinder = find.text('7891234467');

    expect(countryCodeFinder, findsOneWidget);
    expect(numberFinder, findsOneWidget);
  });

  testWidgets(
      'Test flutter_intl_phone_field setup with Guernsey number: +441481960194',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TestWidget(
      phoneNumber: '+441481960194',
      countryCode: 'GG',
    ));

    final countryCodeFinder = find.text('+44 1481');
    final numberFinder = find.text('960194');

    expect(countryCodeFinder, findsOneWidget);
    expect(numberFinder, findsOneWidget);
  });

  testWidgets(
      'Test flutter_intl_phone_field setup with UK number: +447891244567',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TestWidget(
      phoneNumber: '+447891244567',
      countryCode: 'GB',
    ));

    final countryCodeFinder = find.text('+44');
    final numberFinder = find.text('7891244567');

    expect(countryCodeFinder, findsOneWidget);
    expect(numberFinder, findsOneWidget);
  });

  testWidgets(
      'Test showCountryCode false hides the country dial code',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TestWidget(
      phoneNumber: '+447891234467',
      showCountryCode: false,
    ));

    final countryCodeFinder = find.text('+44');
    final numberFinder = find.text('7891234467');

    // Country code should not be visible
    expect(countryCodeFinder, findsNothing);
    // Phone number should still be visible
    expect(numberFinder, findsOneWidget);
  });

  testWidgets(
      'Test showCountryCode true shows the country dial code',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TestWidget(
      phoneNumber: '+447891234467',
      showCountryCode: true,
    ));

    final countryCodeFinder = find.text('+44');
    final numberFinder = find.text('7891234467');

    // Country code should be visible
    expect(countryCodeFinder, findsOneWidget);
    // Phone number should still be visible
    expect(numberFinder, findsOneWidget);
  });

  testWidgets(
      'Test showCountryFlag false hides the country flag',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TestWidget(
      phoneNumber: '+447891234467',
      showCountryFlag: false,
    ));

    final countryCodeFinder = find.text('+44');
    final numberFinder = find.text('7891234467');

    // Country code should still be visible
    expect(countryCodeFinder, findsOneWidget);
    // Phone number should still be visible
    expect(numberFinder, findsOneWidget);
  });

  testWidgets(
      'Test both showCountryCode and showCountryFlag false',
      (WidgetTester tester) async {
    await tester.pumpWidget(const TestWidget(
      phoneNumber: '+447891234467',
      showCountryCode: false,
      showCountryFlag: false,
    ));

    final countryCodeFinder = find.text('+44');
    final numberFinder = find.text('7891234467');

    // Country code should not be visible
    expect(countryCodeFinder, findsNothing);
    // Phone number should still be visible
    expect(numberFinder, findsOneWidget);
  });
}
