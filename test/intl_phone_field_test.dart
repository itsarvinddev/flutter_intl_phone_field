import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/country_picker_dialog.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_test/flutter_test.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({Key? key, required this.phoneNumber, this.countryCode, this.pickerDialogStyle}) : super(key: key);

  final String phoneNumber;
  final String? countryCode;
  final PickerDialogStyle? pickerDialogStyle;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Intl Phone Field',
      home: Scaffold(
        appBar: AppBar(title: const Text("")),
        body: IntlPhoneField(
          initialValue: phoneNumber,
          initialCountryCode: countryCode,
          pickerDialogStyle: pickerDialogStyle,
        ),
      ),
    );
  }
}

void main() {
  testWidgets('Test flutter_intl_phone_field setup with completeNumber', (WidgetTester tester) async {
    await tester.pumpWidget(const TestWidget(phoneNumber: '+447891234467'));

    final countryCodeFinder = find.text('+44');
    final numberFinder = find.text('7891234467');

    expect(countryCodeFinder, findsOneWidget);
    expect(numberFinder, findsOneWidget);
  });

  testWidgets('Test flutter_intl_phone_field setup with Guernsey number: +441481960194', (WidgetTester tester) async {
    await tester.pumpWidget(const TestWidget(phoneNumber: '+441481960194', countryCode: 'GG'));

    final countryCodeFinder = find.text('+44 1481');
    final numberFinder = find.text('960194');

    expect(countryCodeFinder, findsOneWidget);
    expect(numberFinder, findsOneWidget);
  });

  testWidgets('Test flutter_intl_phone_field setup with UK number: +447891244567', (WidgetTester tester) async {
    await tester.pumpWidget(const TestWidget(phoneNumber: '+447891244567', countryCode: 'GB'));

    final countryCodeFinder = find.text('+44');
    final numberFinder = find.text('7891244567');

    expect(countryCodeFinder, findsOneWidget);
    expect(numberFinder, findsOneWidget);
  });

  testWidgets('Test flutter_intl_phone_field with custom searchFieldStyle', (WidgetTester tester) async {
    const customTextStyle = TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);

    await tester.pumpWidget(
      TestWidget(
        phoneNumber: '+447891244567',
        countryCode: 'GB',
        pickerDialogStyle: PickerDialogStyle(backgroundColor: Colors.black, searchFieldStyle: customTextStyle),
      ),
    );

    final countryCodeFinder = find.text('+44');
    expect(countryCodeFinder, findsOneWidget);

    // Tap on the country selector to open the dialog
    await tester.tap(countryCodeFinder);
    await tester.pumpAndSettle();

    // Find the search TextField in the dialog
    final textFieldFinder = find.byType(TextField);
    expect(textFieldFinder, findsOneWidget);

    // Verify that the TextField has the custom style applied
    final textField = tester.widget<TextField>(textFieldFinder);
    expect(textField.style, equals(customTextStyle));
  });
}
