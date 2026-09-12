import 'package:flutter/services.dart';

import 'as_you_type_formatter.dart';
import 'country.dart';

/// Formats the field's text into the country's national layout as it is typed.
///
/// The formatter only ever inserts separators, so the digits the user typed are
/// always preserved. The caret is kept next to the same digit it was next to
/// before formatting, which is what keeps mid-number edits from jumping.
class PhoneInputFormatter extends TextInputFormatter {
  PhoneInputFormatter({required this.country, this.enabled = true});

  /// The country whose national layout to apply.
  Country country;

  /// When false the text is passed through with non-digits stripped.
  bool enabled;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (!enabled) {
      return TextEditingValue(
        text: digits,
        selection: TextSelection.collapsed(
          offset: _caretForDigits(digits, digits, _digitsBefore(newValue)),
        ),
      );
    }

    final formatted = AsYouTypeFormatter.format(country, digits);
    if (formatted == newValue.text) return newValue;

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: _caretForDigits(formatted, digits, _digitsBefore(newValue)),
      ),
      composing: TextRange.empty,
    );
  }

  static int _digitsBefore(TextEditingValue value) {
    final end = value.selection.end.clamp(0, value.text.length);
    var n = 0;
    for (var i = 0; i < end; i++) {
      final c = value.text.codeUnitAt(i);
      if (c >= 0x30 && c <= 0x39) n++;
    }
    return n;
  }

  /// Offset in [formatted] that sits just after [count] digits.
  static int _caretForDigits(String formatted, String digits, int count) {
    if (count <= 0) return 0;
    var seen = 0;
    for (var i = 0; i < formatted.length; i++) {
      final c = formatted.codeUnitAt(i);
      if (c >= 0x30 && c <= 0x39) {
        seen++;
        if (seen == count) return i + 1;
      }
    }
    return formatted.length;
  }
}
