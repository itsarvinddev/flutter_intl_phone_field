## 0.0.8 (Unreleased)

- Fixed UK (+44) phone number validation issue
- Added region codes for Crown Dependencies: Guernsey (1481), Isle of Man (1624), Jersey (1534)
- Fixed widget to consistently use fullCountryCode when creating PhoneNumber objects
- Added comprehensive tests for UK and Crown Dependencies phone validation

## 0.0.7

- Refactor initState to use Future.microtask for improved initialization of country list and phone number handling

## 0.0.6

- [#1](https://github.com/rvndsngwn/flutter_intl_phone_field/issues/1) has been fixed.
- [#2](https://github.com/rvndsngwn/flutter_intl_phone_field/issues/2) has been fixed.

## 0.0.5

- Future.microtask() added to initState() to avoid `setState() or markNeedsBuild() called during build` error.

## 0.0.4

- Dependency updated.

## 0.0.3

- Error exception handled.

## 0.0.2

- README.md updated.

## 0.0.1

- A Custom Phone Input TextFormField.
