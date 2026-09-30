import 'package:flutter/foundation.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_test/flutter_test.dart';

Country _byCode(String code) => countries.firstWhere((c) => c.code == code);

void main() {
  group('construction', () {
    test('an empty controller has no country and no number', () {
      final controller = PhoneController();
      addTearDown(controller.dispose);

      expect(controller.number, '');
      expect(controller.country, isNull);
      expect(controller.completeNumber, '');
      expect(controller.isValid, isFalse);
    });

    test('takes an initial value', () {
      final controller = PhoneController(
        initialValue: const PhoneNumber(
          countryISOCode: 'GB',
          countryCode: '+44',
          number: '7400123456',
        ),
      );
      addTearDown(controller.dispose);

      expect(controller.country?.code, 'GB');
      expect(controller.completeNumber, '+447400123456');
    });

    test('fromCompleteNumber splits the number into its parts', () {
      final controller = PhoneController.fromCompleteNumber('+447400123456');
      addTearDown(controller.dispose);

      expect(
        controller.value,
        const PhoneNumber(
          countryISOCode: 'GB',
          countryCode: '+44',
          number: '7400123456',
        ),
      );
      expect(controller.completeNumber, '+447400123456');
    });

    test('fromCompleteNumber keeps the area code out of the number', () {
      final controller = PhoneController.fromCompleteNumber('+12684641234');
      addTearDown(controller.dispose);

      expect(controller.country?.code, 'AG');
      expect(controller.value.countryCode, '+1268');
      expect(controller.number, '4641234');
      expect(controller.completeNumber, '+12684641234');
    });

    test('fromCompleteNumber keeps an unparseable value verbatim', () {
      final controller = PhoneController.fromCompleteNumber('nonsense');
      addTearDown(controller.dispose);

      expect(controller.value.countryISOCode, '');
      expect(controller.number, 'nonsense');
      expect(controller.isValid, isFalse);
    });

    test('fromParts builds the value from an ISO code', () {
      final controller = PhoneController.fromParts(
        isoCode: 'GB',
        number: '7400123456',
      );
      addTearDown(controller.dispose);

      expect(
        controller.value,
        const PhoneNumber(
          countryISOCode: 'GB',
          countryCode: '+44',
          number: '7400123456',
        ),
      );
    });

    test('fromParts uses the full calling code for a territory', () {
      final controller = PhoneController.fromParts(
        isoCode: 'ag',
        number: '4641234',
      );
      addTearDown(controller.dispose);

      expect(controller.value.countryISOCode, 'AG');
      expect(controller.value.countryCode, '+1268');
      expect(controller.completeNumber, '+12684641234');
    });

    test('fromParts defaults to an empty number and falls back to the US', () {
      final controller = PhoneController.fromParts(isoCode: 'ZZ');
      addTearDown(controller.dispose);

      expect(controller.value.countryISOCode, 'US');
      expect(controller.number, '');
    });
  });

  group('mutation', () {
    test('setting country keeps the number', () {
      final controller = PhoneController.fromParts(
        isoCode: 'GB',
        number: '7400123456',
      );
      addTearDown(controller.dispose);

      controller.country = _byCode('IN');

      expect(controller.country?.code, 'IN');
      expect(controller.value.countryCode, '+91');
      expect(controller.number, '7400123456');
      expect(controller.completeNumber, '+917400123456');
    });

    test('setting country to null is a no-op', () {
      final controller = PhoneController.fromParts(
        isoCode: 'GB',
        number: '7400123456',
      );
      addTearDown(controller.dispose);

      controller.country = null;

      expect(controller.country?.code, 'GB');
      expect(controller.number, '7400123456');
    });

    test('setting number keeps the country', () {
      final controller = PhoneController.fromParts(
        isoCode: 'GB',
        number: '7400123456',
      );
      addTearDown(controller.dispose);

      controller.number = '7911123456';

      expect(controller.country?.code, 'GB');
      expect(controller.value.countryCode, '+44');
      expect(controller.completeNumber, '+447911123456');
    });

    test('the completeNumber setter reparses the whole value', () {
      final controller = PhoneController.fromParts(
        isoCode: 'GB',
        number: '7400123456',
      );
      addTearDown(controller.dispose);

      controller.completeNumber = '+12684641234';

      expect(controller.value.countryISOCode, 'AG');
      expect(controller.value.countryCode, '+1268');
      expect(controller.number, '4641234');
    });

    test('clear empties the number only', () {
      final controller = PhoneController.fromParts(
        isoCode: 'GB',
        number: '7400123456',
      );
      addTearDown(controller.dispose);

      controller.clear();

      expect(controller.number, '');
      expect(controller.country?.code, 'GB');
      expect(controller.value.countryCode, '+44');
      expect(controller.completeNumber, '+44');
    });
  });

  group('isValid', () {
    test('reflects the current value', () {
      final controller = PhoneController.fromParts(isoCode: 'GB');
      addTearDown(controller.dispose);
      expect(controller.isValid, isFalse);

      controller.number = '7400123456';
      expect(controller.isValid, isTrue);

      controller.number = '740012';
      expect(controller.isValid, isFalse);

      controller.number = '74001234567890';
      expect(controller.isValid, isFalse);

      controller.clear();
      expect(controller.isValid, isFalse);
    });

    test('follows a change of country', () {
      final controller = PhoneController.fromParts(
        isoCode: 'GB',
        number: '7400123456',
      );
      addTearDown(controller.dispose);
      expect(controller.isValid, isTrue);

      // Antigua numbers are seven digits after the +1 268 prefix.
      controller.country = _byCode('AG');
      expect(controller.isValid, isFalse);

      controller.number = '4641234';
      expect(controller.isValid, isTrue);
    });
  });

  group('notification', () {
    test('listeners fire on each mutation', () {
      final controller = PhoneController.fromParts(
        isoCode: 'GB',
        number: '7400123456',
      );
      addTearDown(controller.dispose);

      var notifications = 0;
      controller.addListener(() => notifications++);

      controller.number = '7911123456';
      expect(notifications, 1);

      controller.country = _byCode('IN');
      expect(notifications, 2);

      controller.completeNumber = '+12684641234';
      expect(notifications, 3);

      controller.clear();
      expect(notifications, 4);
    });

    test('an unchanged value does not notify', () {
      final controller = PhoneController.fromParts(
        isoCode: 'GB',
        number: '7400123456',
      );
      addTearDown(controller.dispose);

      var notifications = 0;
      controller.addListener(() => notifications++);

      controller.number = '7400123456';
      controller.country = _byCode('GB');
      expect(notifications, 0);
    });

    test('no notification after dispose', () {
      final controller = PhoneController.fromParts(
        isoCode: 'GB',
        number: '7400123456',
      );

      var notifications = 0;
      controller.addListener(() => notifications++);
      controller.number = '7911123456';
      expect(notifications, 1);

      controller.dispose();

      // A disposed ChangeNotifier rejects further mutation rather than
      // silently notifying stale listeners.
      expect(
        () => controller.number = '7911123457',
        throwsA(isA<FlutterError>()),
      );
      expect(notifications, 1);
    });
  });
}
