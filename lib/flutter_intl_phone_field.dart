/// International phone number input for Flutter.
///
/// A [IntlPhoneField] is a `TextFormField` with a country picker attached. It
/// edits the national part of a number and reports the whole thing as a
/// [PhoneNumber]:
///
/// ```dart
/// IntlPhoneField(
///   initialCountryCode: 'GB',
///   onChanged: (phone) => print(phone.completeNumber), // +447400123456
/// )
/// ```
///
/// The field is built on `package:material_ui`, not on the SDK's
/// `package:flutter/material.dart`: the app around it, and any
/// `InputDecoration` passed to it, must come from `material_ui` as well.
///
/// Country data — calling codes, national number lengths, validation patterns
/// and formatting rules — is generated from Google's libphonenumber metadata,
/// with localised country names from the Unicode CLDR.
library;

export 'src/as_you_type_formatter.dart';
export 'src/countries.dart';
export 'src/country.dart';
export 'src/country_flag.dart' show CountryFlag, FlagShape;
export 'src/country_lookup.dart' show CountryResolver;
export 'src/country_picker.dart'
    show CountryPickerBody, DialogType, PickerDialogStyle, showCountryPicker;
export 'src/intl_phone_field.dart'
    show IconPosition, InitialValueFormat, IntlPhoneField;
export 'src/localization.dart';
export 'src/phone_controller.dart';
export 'src/phone_input_formatter.dart';
export 'src/phone_number.dart';
export 'src/phone_number_format.dart';
