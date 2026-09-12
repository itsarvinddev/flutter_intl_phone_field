# UK Phone Number Validation Fix

## Summary
Fixed validation issue for United Kingdom (+44) phone numbers that were incorrectly being validated as Guernsey numbers.

## Root Cause
Multiple countries/territories share the +44 dial code:
- United Kingdom (GB): +44
- Guernsey (GG): +44 1481
- Isle of Man (IM): +44 1624
- Jersey (JE): +44 1534

Previously, all these territories had `dialCode: "44"` with an empty `regionCode: ""`. The `getCountry()` method uses `firstWhere`, which returns the FIRST match in the list. Since Guernsey appeared before United Kingdom, UK numbers were incorrectly identified as Guernsey numbers. This caused validation to fail because:
- Guernsey expects 6-digit numbers
- UK expects 10-digit numbers

## Solution

### 1. Added Region Codes to Crown Dependencies
Updated `lib/countries.dart` to include proper region codes:
- Guernsey (GG): `regionCode: "1481"`
- Isle of Man (IM): `regionCode: "1624"`
- Jersey (JE): `regionCode: "1534"`
- United Kingdom (GB): `regionCode: ""` (no region code, acts as fallback)

### 2. Fixed Widget Consistency
Updated `lib/flutter_intl_phone_field.dart` to consistently use `fullCountryCode` (which includes region code) when creating PhoneNumber objects:
- Fixed validator callback (line 522)
- Fixed onSaved callback (line 501)
- Fixed autovalidate initial value (line 401)

## How It Works

### Phone Number Matching Algorithm
When `getCountry("+447891234567")` is called:
1. Remove the "+" prefix: `"447891234567"`
2. Try to match each country's `dialCode + regionCode`:
   - Guernsey: `"447891234567".startsWith("441481")` = false
   - Isle of Man: `"447891234567".startsWith("441624")` = false
   - Jersey: `"447891234567".startsWith("441534")` = false
   - UK: `"447891234567".startsWith("44")` = **true** ✓
3. Return United Kingdom

For Guernsey number `"+441481960194"`:
1. Remove the "+" prefix: `"441481960194"`
2. Try to match each country's `dialCode + regionCode`:
   - Guernsey: `"441481960194".startsWith("441481")` = **true** ✓
3. Return Guernsey

### Validation
Once the correct country is identified, validation checks:
- UK: `number.length` must be between 10 and 10 digits
- Guernsey: `number.length` must be between 6 and 6 digits
- Isle of Man: `number.length` must be between 6 and 6 digits
- Jersey: `number.length` must be between 6 and 6 digits

## Testing
Added comprehensive tests in `test/uk_phone_validation_test.dart` covering:
- UK mainland numbers (various formats)
- Guernsey numbers
- Isle of Man numbers
- Jersey numbers
- Edge cases to ensure no confusion between territories

## Existing Tests
All existing tests in `test/phonenumber_test.dart` continue to pass, including:
- UK number test: `+447891234567`
- Guernsey number test: `+441481960194`

## Impact
This fix resolves the issue where UK phone numbers were being incorrectly marked as invalid. Users can now successfully validate:
- UK mainland numbers like `+447891234567`
- Crown Dependencies numbers like `+441481960194` (Guernsey)
- All variations of +44 numbers are now correctly distinguished

## Technical Notes

### Country Ordering
The order of countries in the list matters because `firstWhere` returns the first match. Countries with longer region codes (more specific prefixes) should appear before countries with shorter or empty region codes. Current order for +44 is:
1. Guernsey (441481)
2. Isle of Man (441624)
3. Jersey (441534)
4. United Kingdom (44) - acts as fallback

This order works correctly because more specific prefixes are checked first.

### fullCountryCode Property
The `Country` class has a `fullCountryCode` getter that returns `dialCode + regionCode`. This is used throughout the codebase to ensure region codes are properly included when creating phone numbers.

### Similar Issues
Other dial codes that are shared by multiple countries (like +1 for NANP countries) already have proper region codes or full dial codes set, so they don't have this issue.
