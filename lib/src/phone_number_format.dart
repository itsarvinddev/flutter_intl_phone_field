/// One national number formatting rule, as published by libphonenumber.
///
/// [pattern] captures the digit groups; [format] lays them out using `$1`,
/// `$2`, … placeholders. A rule only applies when [leadingDigits] (when
/// present) matches the start of the national number.
class PhoneNumberFormat {
  /// Regular expression with one capture group per digit group,
  /// e.g. `r'(\d{3})(\d{3})(\d{4})'`.
  final String pattern;

  /// Layout for the captured groups, e.g. `'($1) $2-$3'`.
  final String format;

  /// Regular expression the national number must start with for this rule to
  /// apply. `null` means the rule always applies.
  final String? leadingDigits;

  /// libphonenumber's rule for re-inserting the national trunk prefix when
  /// formatting for domestic display, e.g. `r'$NP$FG'`.
  final String? nationalPrefixFormattingRule;

  const PhoneNumberFormat({
    required this.pattern,
    required this.format,
    this.leadingDigits,
    this.nationalPrefixFormattingRule,
  });
}
