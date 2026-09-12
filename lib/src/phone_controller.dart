import 'package:flutter/foundation.dart';

import 'countries.dart';
import 'country.dart';
import 'country_lookup.dart';
import 'phone_number.dart';

/// Programmatic control over an [IntlPhoneField].
///
/// A [PhoneController] is a [ValueNotifier] over the field's current
/// [PhoneNumber], so it can be listened to, read and written from outside the
/// widget:
///
/// ```dart
/// final controller = PhoneController.fromCompleteNumber('+447400123456');
/// ...
/// IntlPhoneField(phoneController: controller)
/// ...
/// controller.country = someCountry;   // switch country, keep the number
/// controller.number = '7911123456';   // replace the number
/// print(controller.value.completeNumber);
/// ```
///
/// Dispose it when you are done, as with any [ChangeNotifier].
class PhoneController extends ValueNotifier<PhoneNumber> {
  /// Creates a controller, optionally starting from [initialValue].
  PhoneController({PhoneNumber? initialValue})
      : super(initialValue ??
            const PhoneNumber(countryISOCode: '', countryCode: '', number: ''));

  /// Build a controller from a full international number, e.g. `+447400123456`.
  factory PhoneController.fromCompleteNumber(String completeNumber) =>
      PhoneController(
        initialValue:
            PhoneNumber.fromCompleteNumber(completeNumber: completeNumber),
      );

  /// Build a controller from an ISO country code and a national number.
  factory PhoneController.fromParts({
    required String isoCode,
    String number = '',
  }) {
    final country = CountryResolver.instance.byIsoCode(isoCode) ??
        countries.firstWhere((c) => c.code == 'US');
    return PhoneController(
      initialValue: PhoneNumber(
        countryISOCode: country.code,
        countryCode: '+${country.fullCountryCode}',
        number: number,
      ),
    );
  }

  /// The selected country, or `null` when none has been resolved.
  Country? get country => value.country;

  /// Select a country, keeping the current [number].
  set country(Country? country) {
    if (country == null) return;
    value = value.copyWith(
      countryISOCode: country.code,
      countryCode: '+${country.fullCountryCode}',
    );
  }

  /// The national number as typed.
  String get number => value.number;

  /// Replace the national number, keeping the selected country.
  set number(String number) => value = value.copyWith(number: number);

  /// The full number in E.164 form, e.g. `+447400123456`.
  String get completeNumber => value.completeNumber;

  /// Replace the whole value by parsing a full international number.
  set completeNumber(String completeNumber) =>
      value = PhoneNumber.fromCompleteNumber(completeNumber: completeNumber);

  /// Whether the current number is valid for the selected country.
  bool get isValid => value.isValidNumber();

  /// Clear the number, keeping the selected country.
  void clear() => value = value.copyWith(number: '');
}
