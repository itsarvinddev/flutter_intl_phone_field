// Test file to verify UK phone number validation fix
import 'package:flutter_intl_phone_field/countries.dart';
import 'package:flutter_intl_phone_field/phone_number.dart';
import 'package:test/test.dart';

void main() {
  group('UK +44 Phone Number Validation', () {
    test('UK mainland number +447891234567 should be valid', () {
      PhoneNumber phoneNumber = PhoneNumber.fromCompleteNumber(
        completeNumber: "+447891234567",
      );
      expect(phoneNumber.countryISOCode, "GB");
      expect(phoneNumber.countryCode, "44");
      expect(phoneNumber.number, "7891234567");
      expect(phoneNumber.isValidNumber(), true);
    });

    test('UK mainland number +442012345678 should be valid', () {
      PhoneNumber phoneNumber = PhoneNumber.fromCompleteNumber(
        completeNumber: "+442012345678",
      );
      expect(phoneNumber.countryISOCode, "GB");
      expect(phoneNumber.countryCode, "44");
      expect(phoneNumber.number, "2012345678");
      expect(phoneNumber.isValidNumber(), true);
    });

    test('UK number created directly with countryCode should be valid', () {
      PhoneNumber phoneNumber = PhoneNumber(
        countryISOCode: "GB",
        countryCode: "+44",
        number: "7891234567",
      );
      expect(phoneNumber.isValidNumber(), true);
    });

    test('UK number created with countryCode without + should be valid', () {
      PhoneNumber phoneNumber = PhoneNumber(
        countryISOCode: "GB",
        countryCode: "44",
        number: "7891234567",
      );
      expect(phoneNumber.isValidNumber(), true);
    });

    test('UK short number should be invalid', () {
      PhoneNumber phoneNumber = PhoneNumber(
        countryISOCode: "GB",
        countryCode: "+44",
        number: "789123456", // 9 digits, need 10
      );
      expect(phoneNumber.isValidNumber(), false);
    });

    test('UK long number should be invalid', () {
      PhoneNumber phoneNumber = PhoneNumber(
        countryISOCode: "GB",
        countryCode: "+44",
        number: "78912345678", // 11 digits, need 10
      );
      expect(phoneNumber.isValidNumber(), false);
    });

    test('getCountry should return UK for +447891234567', () {
      Country country = PhoneNumber.getCountry("+447891234567");
      expect(country.name, "United Kingdom");
      expect(country.code, "GB");
      expect(country.dialCode, "44");
      expect(country.regionCode, "");
    });
  });

  group('Guernsey +44 1481 Phone Number Validation', () {
    test('Guernsey number +441481960194 should be valid', () {
      PhoneNumber phoneNumber = PhoneNumber.fromCompleteNumber(
        completeNumber: "+441481960194",
      );
      expect(phoneNumber.countryISOCode, "GG");
      expect(phoneNumber.countryCode, "441481");
      expect(phoneNumber.number, "960194");
      expect(phoneNumber.isValidNumber(), true);
    });

    test('Guernsey number created directly should be valid', () {
      PhoneNumber phoneNumber = PhoneNumber(
        countryISOCode: "GG",
        countryCode: "+441481",
        number: "960194",
      );
      expect(phoneNumber.isValidNumber(), true);
    });

    test('getCountry should return Guernsey for +441481960194', () {
      Country country = PhoneNumber.getCountry("+441481960194");
      expect(country.name, "Guernsey");
      expect(country.code, "GG");
      expect(country.dialCode, "44");
      expect(country.regionCode, "1481");
    });

    test('Guernsey short number should be invalid', () {
      PhoneNumber phoneNumber = PhoneNumber(
        countryISOCode: "GG",
        countryCode: "+441481",
        number: "96019", // 5 digits, need 6
      );
      expect(phoneNumber.isValidNumber(), false);
    });

    test('Guernsey long number should be invalid', () {
      PhoneNumber phoneNumber = PhoneNumber(
        countryISOCode: "GG",
        countryCode: "+441481",
        number: "9601945", // 7 digits, need 6
      );
      expect(phoneNumber.isValidNumber(), false);
    });
  });

  group('Isle of Man +44 1624 Phone Number Validation', () {
    test('Isle of Man number should be correctly identified', () {
      PhoneNumber phoneNumber = PhoneNumber.fromCompleteNumber(
        completeNumber: "+441624123456",
      );
      expect(phoneNumber.countryISOCode, "IM");
      expect(phoneNumber.countryCode, "441624");
      expect(phoneNumber.number, "123456");
      expect(phoneNumber.isValidNumber(), true);
    });

    test('getCountry should return Isle of Man for +441624123456', () {
      Country country = PhoneNumber.getCountry("+441624123456");
      expect(country.name, "Isle of Man");
      expect(country.code, "IM");
      expect(country.dialCode, "44");
      expect(country.regionCode, "1624");
    });
  });

  group('Jersey +44 1534 Phone Number Validation', () {
    test('Jersey number should be correctly identified', () {
      PhoneNumber phoneNumber = PhoneNumber.fromCompleteNumber(
        completeNumber: "+441534123456",
      );
      expect(phoneNumber.countryISOCode, "JE");
      expect(phoneNumber.countryCode, "441534");
      expect(phoneNumber.number, "123456");
      expect(phoneNumber.isValidNumber(), true);
    });

    test('getCountry should return Jersey for +441534123456', () {
      Country country = PhoneNumber.getCountry("+441534123456");
      expect(country.name, "Jersey");
      expect(country.code, "JE");
      expect(country.dialCode, "44");
      expect(country.regionCode, "1534");
    });
  });

  group('Edge Cases', () {
    test('UK number should not be confused with Guernsey', () {
      // A UK number starting with 789 should be UK, not Guernsey
      PhoneNumber phoneNumber = PhoneNumber.fromCompleteNumber(
        completeNumber: "+447891234567",
      );
      expect(phoneNumber.countryISOCode, "GB");
      expect(phoneNumber.countryISOCode, isNot("GG"));
    });

    test('UK number should not be confused with Isle of Man', () {
      // A UK number starting with 789 should be UK, not Isle of Man
      PhoneNumber phoneNumber = PhoneNumber.fromCompleteNumber(
        completeNumber: "+447891234567",
      );
      expect(phoneNumber.countryISOCode, "GB");
      expect(phoneNumber.countryISOCode, isNot("IM"));
    });

    test('UK number should not be confused with Jersey', () {
      // A UK number starting with 789 should be UK, not Jersey
      PhoneNumber phoneNumber = PhoneNumber.fromCompleteNumber(
        completeNumber: "+447891234567",
      );
      expect(phoneNumber.countryISOCode, "GB");
      expect(phoneNumber.countryISOCode, isNot("JE"));
    });
  });
}
