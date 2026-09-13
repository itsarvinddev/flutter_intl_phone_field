import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'as_you_type_formatter.dart';
import 'countries.dart';
import 'country.dart';
import 'country_flag.dart';
import 'country_lookup.dart';
import 'country_picker.dart';
import 'localization.dart';
import 'phone_controller.dart';
import 'phone_input_formatter.dart';
import 'phone_number.dart';

/// Where the dropdown arrow sits relative to the flag and dial code.
enum IconPosition {
  /// Before the flag and dial code.
  leading,

  /// After the flag and dial code.
  trailing,
}

/// How to interpret [IntlPhoneField.initialValue].
enum InitialValueFormat {
  /// Treat a value starting with `+` or `00` as international and anything
  /// else as a national number. The default, and almost always right.
  auto,

  /// Always treat the value as a national number, never stripping a country
  /// code from it — even when its leading digits happen to match one.
  national,

  /// Always treat the value as international, stripping the country code.
  international,
}

/// A phone number field with a country picker.
///
/// ```dart
/// IntlPhoneField(
///   initialCountryCode: 'GB',
///   onChanged: (phone) => print(phone.completeNumber),
/// )
/// ```
///
/// The field edits the *national* part of the number; the country's calling
/// code is shown beside it and delivered on [PhoneNumber.countryCode].
class IntlPhoneField extends StatefulWidget {
  /// Key for the underlying [TextFormField], for calling `validate()` or
  /// `reset()` on the field directly.
  final GlobalKey<FormFieldState>? formFieldKey;

  /// Whether to hide the text being edited.
  final bool obscureText;

  /// How the text is aligned horizontally.
  final TextAlign textAlign;

  /// How the text is aligned vertically.
  final TextAlignVertical? textAlignVertical;

  /// Called when the field is tapped.
  final VoidCallback? onTap;

  /// Called when a pointer goes down outside the field.
  ///
  /// Useful for dismissing the keyboard on iOS, which has no done key for
  /// numeric input.
  final void Function(PointerDownEvent)? onTapOutside;

  /// {@macro flutter.widgets.editableText.readOnly}
  final bool readOnly;

  /// Called when the enclosing [Form] is saved.
  final FormFieldSetter<PhoneNumber>? onSaved;

  /// Called whenever the number or the country changes.
  final ValueChanged<PhoneNumber>? onChanged;

  /// Called when the user picks a different country.
  final ValueChanged<Country>? onCountryChanged;

  /// Validates the number, returning an error message or null.
  ///
  /// Runs *after* the built-in length check unless [disableLengthCheck] is
  /// true, so a number of the wrong length is reported without your validator
  /// having to check it. Async validators are supported: the field re-runs
  /// validation when the future completes.
  final FutureOr<String?> Function(PhoneNumber?)? validator;

  /// {@macro flutter.widgets.editableText.keyboardType}
  final TextInputType keyboardType;

  /// Controls the text being edited. One is created if you pass none.
  final TextEditingController? controller;

  /// Programmatic control over the country and number.
  ///
  /// Lets you read and set the value from outside the widget, and listen for
  /// changes. See [PhoneController].
  final PhoneController? phoneController;

  /// Focus for the text field.
  final FocusNode? focusNode;

  /// {@macro flutter.widgets.editableText.onSubmitted}
  final void Function(String)? onSubmitted;

  /// Whether the field accepts input. When false the picker is disabled too.
  final bool enabled;

  /// Keyboard brightness. Honoured on iOS only.
  final Brightness? keyboardAppearance;

  /// Pre-fills the field.
  ///
  /// Interpreted according to [initialValueFormat]. A value beginning with `+`
  /// or `00` is treated as a full international number and its country code is
  /// stripped; anything else is kept verbatim as a national number.
  final String? initialValue;

  /// Language used for country names in the picker, e.g. `'fr'`.
  final String languageCode;

  /// The country selected initially.
  ///
  /// Accepts an ISO 3166-1 alpha-2 code or a dial code:
  ///
  /// ```dart
  /// initialCountryCode: 'IN',    // India
  /// initialCountryCode: '+225',  // Côte d'Ivoire
  /// ```
  final String? initialCountryCode;

  /// The countries to offer. Defaults to every country the package knows.
  final List<Country>? countries;

  /// Restrict the picker to these ISO 3166-1 alpha-2 codes.
  final List<String>? onlyCountries;

  /// Remove these ISO 3166-1 alpha-2 codes from the picker.
  final List<String>? excludeCountries;

  /// ISO codes pinned to the top of the picker, in the order given.
  final List<String> favoriteCountries;

  /// Decoration for the text field.
  final InputDecoration decoration;

  /// Style of the text being edited.
  final TextStyle? style;

  /// Skip the built-in minimum/maximum length check.
  ///
  /// Also lifts the typing limit, so the field no longer stops at the
  /// country's maximum length.
  final bool disableLengthCheck;

  /// Require the number to match a real fixed-line or mobile range for the
  /// country, not merely to be of a plausible length.
  ///
  /// Off by default: it rejects numbers in ranges allocated after this
  /// package's data was generated.
  final bool strictValidation;

  /// Whether to show the dropdown arrow. Ignored when [enabled] is false.
  final bool showDropdownIcon;

  /// Decoration behind the country selector button.
  final BoxDecoration dropdownDecoration;

  /// Text style for the country dial code.
  final TextStyle? dropdownTextStyle;

  /// Input formatters for the text field.
  ///
  /// Defaults to digits-only plus the country's length limit, and — when
  /// [formatInput] is true — as-you-type national formatting. Supplying your
  /// own replaces all of that.
  final List<TextInputFormatter>? inputFormatters;

  /// Label for the picker's search field.
  @Deprecated('Use localizations.searchHint, or '
      'PickerDialogStyle.searchFieldInputDecoration. '
      'Will be removed in 1.0.0.')
  final String searchText;

  /// Where the dropdown arrow sits.
  final IconPosition dropdownIconPosition;

  /// The dropdown arrow. Hide it with `showDropdownIcon: false`.
  final Icon dropdownIcon;

  /// Whether the field takes focus on first build.
  final bool autofocus;

  /// When the field auto-validates. Defaults to
  /// [AutovalidateMode.onUserInteraction].
  final AutovalidateMode? autovalidateMode;

  /// Whether to show the country flag.
  final bool showCountryFlag;

  /// Whether to show the country dial code.
  final bool showCountryCode;

  /// Shape of the flag in the selector button.
  final FlagShape flagShape;

  /// Width of the flag in the selector button.
  final double flagSize;

  /// Replaces the flag widget entirely.
  final Widget Function(BuildContext context, Country country)? flagBuilder;

  /// Replaces the dial code widget.
  final Widget Function(BuildContext context, Country country)? dialCodeBuilder;

  /// Replaces the whole country selector.
  ///
  /// Receives a callback that opens the picker, so your widget can still
  /// trigger it:
  ///
  /// ```dart
  /// countrySelectorBuilder: (context, country, openPicker) => TextButton(
  ///   onPressed: openPicker,
  ///   child: Text(country.flag),
  /// ),
  /// ```
  final Widget Function(
          BuildContext context, Country country, VoidCallback openPicker)?
      countrySelectorBuilder;

  /// Message shown when the number's length is outside the country's range.
  ///
  /// Overrides [IntlPhoneFieldLocalizations.invalidNumber] when non-null.
  final String? invalidMessage;

  /// Strings shown by the field and the picker.
  final IntlPhoneFieldLocalizations localizations;

  /// Colour of the cursor.
  final Color? cursorColor;

  /// Height of the cursor.
  final double? cursorHeight;

  /// Corner radius of the cursor.
  final Radius? cursorRadius;

  /// Thickness of the cursor.
  final double cursorWidth;

  /// Whether to show the cursor.
  final bool? showCursor;

  /// Padding inside the country selector button.
  final EdgeInsetsGeometry flagsButtonPadding;

  /// Keyboard action button.
  final TextInputAction? textInputAction;

  /// Styling for the country picker.
  final PickerDialogStyle? pickerDialogStyle;

  /// Margin around the country selector button.
  final EdgeInsets flagsButtonMargin;

  /// Autofill hints. Defaults to telephone hints in the order iOS expects.
  final Iterable<String>? autofillHints;

  /// Magnifier configuration for text selection.
  final TextMagnifierConfiguration? magnifierConfiguration;

  /// Replaces the country selector with your own prefix icon.
  ///
  /// The picker becomes unreachable; use [countrySelectorBuilder] if you want
  /// a custom look that still opens it.
  final Widget? prefixIcon;

  /// How the picker is presented.
  final DialogType dialogType;

  /// Maximum number of characters. Defaults to the country's maximum length.
  final int? maxLength;

  /// Minimum number of lines.
  final int? minLines;

  /// Maximum number of lines.
  final int? maxLines;

  /// Whether the field expands to fill its parent.
  final bool expands;

  /// How [maxLength] is enforced.
  final MaxLengthEnforcement? maxLengthEnforcement;

  /// Builds the character counter.
  final InputCounterWidgetBuilder? buildCounter;

  /// Called when editing completes.
  final void Function()? onEditingComplete;

  /// Format the number as it is typed, using the country's national layout.
  ///
  /// `2015550123` becomes `(201) 555-0123` for the United States. The value
  /// delivered on [onChanged] is always digits only, whatever is displayed.
  final bool formatInput;

  /// Show the country's example number as the field's hint.
  ///
  /// Ignored when [decoration] already sets a `hintText`.
  final bool showExampleAsHint;

  /// Switch country automatically when a full international number is pasted
  /// or typed into the field.
  final bool detectCountryOnPaste;

  /// How [initialValue] is interpreted.
  final InitialValueFormat initialValueFormat;

  /// Restore state across app restarts. See [TextFormField.restorationId].
  final String? restorationId;

  /// Creates an international phone number field.
  const IntlPhoneField({
    super.key,
    this.formFieldKey,
    this.initialCountryCode,
    this.languageCode = 'en',
    this.autofillHints,
    this.obscureText = false,
    this.textAlign = TextAlign.left,
    this.textAlignVertical,
    this.onTap,
    this.onTapOutside,
    this.readOnly = false,
    this.initialValue,
    this.keyboardType = TextInputType.phone,
    this.controller,
    this.phoneController,
    this.focusNode,
    this.decoration = const InputDecoration(),
    this.style,
    this.dropdownTextStyle,
    this.onSubmitted,
    this.validator,
    this.onChanged,
    this.countries,
    this.onlyCountries,
    this.excludeCountries,
    this.favoriteCountries = const <String>[],
    this.onCountryChanged,
    this.onSaved,
    this.showDropdownIcon = true,
    this.dropdownDecoration = const BoxDecoration(),
    this.inputFormatters,
    this.enabled = true,
    this.keyboardAppearance,
    @Deprecated('Use localizations.searchHint, or '
        'PickerDialogStyle.searchFieldInputDecoration. '
        'Will be removed in 1.0.0.')
    this.searchText = 'Search country',
    this.dropdownIconPosition = IconPosition.leading,
    this.dropdownIcon = const Icon(Icons.arrow_drop_down),
    this.autofocus = false,
    this.textInputAction,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.showCountryFlag = true,
    this.showCountryCode = true,
    this.flagShape = FlagShape.rectangle,
    this.flagSize = 32,
    this.flagBuilder,
    this.dialCodeBuilder,
    this.countrySelectorBuilder,
    this.cursorColor,
    this.disableLengthCheck = false,
    this.strictValidation = false,
    this.flagsButtonPadding = EdgeInsets.zero,
    this.invalidMessage,
    this.localizations = IntlPhoneFieldLocalizations.fallback,
    this.cursorHeight,
    this.cursorRadius = Radius.zero,
    this.cursorWidth = 2.0,
    this.showCursor = true,
    this.pickerDialogStyle,
    this.flagsButtonMargin = EdgeInsets.zero,
    this.magnifierConfiguration,
    this.prefixIcon,
    this.dialogType = DialogType.showDialog,
    this.maxLength,
    this.minLines,
    this.maxLines,
    this.expands = false,
    this.maxLengthEnforcement,
    this.buildCounter,
    this.onEditingComplete,
    this.formatInput = false,
    this.showExampleAsHint = false,
    this.detectCountryOnPaste = true,
    this.initialValueFormat = InitialValueFormat.auto,
    this.restorationId,
  });

  @override
  State<IntlPhoneField> createState() => _IntlPhoneFieldState();
}

class _IntlPhoneFieldState extends State<IntlPhoneField> {
  late List<Country> _countryList;
  late Country _selectedCountry;
  late TextEditingController _controller;
  late PhoneInputFormatter _formatter;
  late _DigitLimitingFormatter _limiter;
  late _CountryDetectingFormatter _detector;
  bool _ownsController = false;
  bool _syncing = false;
  String? _validatorMessage;

  /// Digits only, whatever separators the formatter is showing.
  String get _digits => _controller.text.replaceAll(RegExp(r'\D'), '');

  @override
  void initState() {
    super.initState();
    _countryList = _resolveCountryList();
    _selectedCountry = _resolveInitialCountry();

    final initialText = _parseInitialNumber();
    _controller = widget.controller ?? TextEditingController();
    _ownsController = widget.controller == null;
    _formatter = PhoneInputFormatter(
        country: _selectedCountry, enabled: widget.formatInput);
    _limiter = _DigitLimitingFormatter(_digitLimit);
    _detector = _CountryDetectingFormatter(
      isEnabled: () => widget.detectCountryOnPaste,
      resolve: _detectCountry,
      onDetected: _applyDetectedCountry,
    );
    final text = widget.formatInput
        ? AsYouTypeFormatter.format(_selectedCountry, initialText)
        : initialText;
    // Assigning resets the selection, so an unchanged text still notified
    // every listener -- including another field on the same controller, which
    // was then marked dirty in the middle of this build.
    if (_controller.text != text) _controller.text = text;

    widget.phoneController?.addListener(_onPhoneControllerChanged);
    _pushToPhoneController();

    if (widget.autovalidateMode == AutovalidateMode.always) {
      // Deferred so a validator that calls setState does not run during build.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _runValidator(_currentNumber());
      });
    }
  }

  @override
  void didUpdateWidget(IntlPhoneField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.phoneController != widget.phoneController) {
      oldWidget.phoneController?.removeListener(_onPhoneControllerChanged);
      widget.phoneController?.addListener(_onPhoneControllerChanged);
    }

    if (oldWidget.controller != widget.controller) {
      if (_ownsController) _controller.dispose();
      _controller = widget.controller ?? TextEditingController();
      _ownsController = widget.controller == null;
    }

    final listChanged = oldWidget.countries != widget.countries ||
        oldWidget.onlyCountries != widget.onlyCountries ||
        oldWidget.excludeCountries != widget.excludeCountries;
    if (listChanged) {
      _countryList = _resolveCountryList();
      _afterBuild(() {
        if (!_countryList.any((c) => c.code == _selectedCountry.code)) {
          _selectCountry(_countryList.first, notify: true);
        }
      });
    }

    if (oldWidget.initialCountryCode != widget.initialCountryCode &&
        widget.initialCountryCode != null) {
      final next = _countryFromCode(widget.initialCountryCode!);
      if (next != null) {
        _afterBuild(() {
          if (next.code != _selectedCountry.code) {
            _selectCountry(next, notify: true);
          }
        });
      }
    }

    if (oldWidget.initialValue != widget.initialValue &&
        widget.controller == null) {
      _afterBuild(() {
        final text = _parseInitialNumber();
        _setText(widget.formatInput
            ? AsYouTypeFormatter.format(_selectedCountry, text)
            : text);
      });
    }

    if (oldWidget.formatInput != widget.formatInput) {
      _formatter.enabled = widget.formatInput;
      _afterBuild(() => _setText(widget.formatInput
          ? AsYouTypeFormatter.format(_selectedCountry, _digits)
          : _digits));
    }
  }

  /// Runs [action] once the frame being built has finished.
  ///
  /// didUpdateWidget runs in the middle of a build. Writing the controller
  /// there makes this field's own TextFormField rebuild its enclosing [Form],
  /// which Flutter rejects ("setState() or markNeedsBuild() called during
  /// build"), and would run onChanged and onCountryChanged mid-build too.
  void _afterBuild(VoidCallback action) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) action();
    });
  }

  @override
  void dispose() {
    widget.phoneController?.removeListener(_onPhoneControllerChanged);
    if (_ownsController) _controller.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------- country

  List<Country> _resolveCountryList() {
    var list = widget.countries ?? countries;
    final only = widget.onlyCountries;
    if (only != null && only.isNotEmpty) {
      final wanted = only.map((c) => c.toUpperCase()).toSet();
      list = list.where((c) => wanted.contains(c.code)).toList();
    }
    final exclude = widget.excludeCountries;
    if (exclude != null && exclude.isNotEmpty) {
      final unwanted = exclude.map((c) => c.toUpperCase()).toSet();
      list = list.where((c) => !unwanted.contains(c.code)).toList();
    }
    return list.isEmpty ? countries : list;
  }

  Country? _countryFromCode(String code) {
    final upper = code.toUpperCase();
    for (final c in _countryList) {
      if (c.code == upper) return c;
    }
    // Also accept a dial code, as the dartdoc promises.
    final digits = code.replaceFirst('+', '');
    if (digits.isEmpty) return null;
    for (final c in _countryList) {
      if (c.fullCountryCode == digits) return c;
    }
    for (final c in _countryList) {
      if (c.dialCode == digits && c.isMainCountryForDialCode) return c;
    }
    for (final c in _countryList) {
      if (c.dialCode == digits) return c;
    }
    return null;
  }

  Country _resolveInitialCountry() {
    final fromController = widget.phoneController?.country;
    if (fromController != null &&
        _countryList.any((c) => c.code == fromController.code)) {
      return fromController;
    }

    final code = widget.initialCountryCode;
    if (code != null) {
      final found = _countryFromCode(code);
      if (found != null) return found;
    }

    // No explicit country: derive one from an international initial value.
    final raw = _rawInitialValue();
    if (code == null && _looksInternational(raw)) {
      final detected = CountryResolver.instance.fromInternationalNumber(raw);
      if (detected != null &&
          _countryList.any((c) => c.code == detected.code)) {
        return detected;
      }
    }
    return _countryFromCode('US') ?? _countryList.first;
  }

  String _rawInitialValue() =>
      (widget.initialValue ?? widget.controller?.text ?? '').trim();

  bool _looksInternational(String raw) {
    switch (widget.initialValueFormat) {
      case InitialValueFormat.national:
        return false;
      case InitialValueFormat.international:
        return true;
      case InitialValueFormat.auto:
        return raw.startsWith('+') || raw.startsWith('00');
    }
  }

  /// Strip the country code from [initialValue] — but only when the value is
  /// unambiguously international.
  ///
  /// A national number whose leading digits happen to match the dial code (a
  /// UAE subscriber number starting `971`) must be left alone; stripping it
  /// silently corrupted the number in earlier releases.
  String _parseInitialNumber() {
    final raw = _rawInitialValue();
    if (raw.isEmpty) return '';

    var digits = raw.replaceAll(RegExp(r'\D'), '');
    if (!_looksInternational(raw)) return digits;

    if (!raw.startsWith('+') && digits.startsWith('00')) {
      digits = digits.substring(2);
    }
    final full = _selectedCountry.fullCountryCode;
    if (digits.startsWith(full)) {
      final rest = digits.substring(full.length);
      // Only accept the strip if what remains could be a real number.
      if (rest.length >= _selectedCountry.minLength || rest.isEmpty) {
        return rest;
      }
    }
    final dial = _selectedCountry.dialCode;
    if (digits.startsWith(dial)) {
      final rest = digits.substring(dial.length);
      if (rest.length >= _selectedCountry.minLength) return rest;
    }
    return digits;
  }

  void _selectCountry(Country country, {bool notify = true}) {
    setState(() {
      _selectedCountry = country;
      _formatter.country = country;
      if (widget.formatInput) {
        _setText(AsYouTypeFormatter.format(country, _digits));
      }
      // Typing room may have shrunk; never leave more digits than allowed.
      if (!widget.disableLengthCheck) {
        final limit = widget.maxLength ?? country.maxLength;
        if (_digits.length > limit) {
          final trimmed = _digits.substring(0, limit);
          _setText(widget.formatInput
              ? AsYouTypeFormatter.format(country, trimmed)
              : trimmed);
        }
      }
    });
    if (notify) {
      widget.onCountryChanged?.call(country);
      final number = _currentNumber();
      widget.onChanged?.call(number);
      _pushToPhoneController();
      _runValidator(number);
      widget.formFieldKey?.currentState?.validate();
    }
  }

  void _setText(String text) {
    if (_controller.text == text) return;
    _controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }

  Future<void> _openPicker() async {
    final chosen = await showCountryPicker(
      context: context,
      countries: _countryList,
      selectedCountry: _selectedCountry,
      dialogType: widget.dialogType,
      style: widget.pickerDialogStyle,
      languageCode: widget.languageCode,
      favorites: _favorites(),
      localizations: _localizations,
    );
    if (chosen != null && mounted) _selectCountry(chosen);
  }

  List<Country> _favorites() {
    if (widget.favoriteCountries.isEmpty) return const <Country>[];
    final out = <Country>[];
    for (final code in widget.favoriteCountries) {
      final upper = code.toUpperCase();
      for (final c in _countryList) {
        if (c.code == upper) {
          out.add(c);
          break;
        }
      }
    }
    return out;
  }

  IntlPhoneFieldLocalizations get _localizations {
    // ignore: deprecated_member_use_from_same_package
    final legacy = widget.searchText;
    if (legacy != 'Search country' &&
        widget.localizations.searchHint == 'Search country') {
      return widget.localizations.copyWith(searchHint: legacy);
    }
    return widget.localizations;
  }

  // ----------------------------------------------------------------- value

  PhoneNumber _currentNumber() => PhoneNumber(
        countryISOCode: _selectedCountry.code,
        countryCode: '+${_selectedCountry.fullCountryCode}',
        number: _digits,
      );

  void _pushToPhoneController() {
    final pc = widget.phoneController;
    if (pc == null) return;
    _syncing = true;
    pc.value = _currentNumber();
    _syncing = false;
  }

  void _onPhoneControllerChanged() {
    if (_syncing || !mounted) return;
    final value = widget.phoneController!.value;
    final country = value.country;
    if (country != null && country.code != _selectedCountry.code) {
      setState(() {
        _selectedCountry = country;
        _formatter.country = country;
      });
    }
    if (value.number != _digits) {
      _setText(widget.formatInput
          ? AsYouTypeFormatter.format(_selectedCountry, value.number)
          : value.number);
    }
  }

  /// Digits the field currently accepts, or null when unlimited.
  int? _digitLimit() => widget.disableLengthCheck
      ? widget.maxLength
      : (widget.maxLength ?? _selectedCountry.maxLength);

  /// Recognise a full international number, so pasting one switches country
  /// instead of gluing foreign digits onto the current one.
  Country? _detectCountry(String raw) {
    final detected = CountryResolver.instance.fromInternationalNumber(raw);
    if (detected == null) return null;
    if (detected.code == _selectedCountry.code) return null;
    if (!_countryList.any((c) => c.code == detected.code)) return null;
    return detected;
  }

  void _applyDetectedCountry(Country country) {
    setState(() {
      _selectedCountry = country;
      _formatter.country = country;
    });
    widget.onCountryChanged?.call(country);
  }

  void _onChanged(String value) {
    final number = _currentNumber();
    widget.onChanged?.call(number);
    _pushToPhoneController();
    if (widget.autovalidateMode != AutovalidateMode.disabled) {
      _runValidator(number);
    }
  }

  /// Run a possibly-async validator, re-validating the form when it resolves.
  void _runValidator(PhoneNumber number) {
    final result = widget.validator?.call(number);
    if (result is Future<String?>) {
      result.then((message) {
        if (!mounted || message == _validatorMessage) return;
        setState(() => _validatorMessage = message);
        widget.formFieldKey?.currentState?.validate();
      });
    } else {
      _validatorMessage = result;
    }
  }

  String? _validate(String? _) {
    final digits = _digits;
    final l10n = _localizations;

    if (digits.isEmpty) {
      // An empty field is only an error when there is no custom validator to
      // decide otherwise.
      if (widget.validator == null) return l10n.requiredNumber;
    } else if (!widget.disableLengthCheck) {
      final min = _selectedCountry.minLength;
      final max = widget.maxLength ?? _selectedCountry.maxLength;
      if (digits.length < min || digits.length > max) {
        return widget.invalidMessage ?? l10n.invalidNumber;
      }
      if (widget.strictValidation &&
          !CountryResolver.isValidFor(_selectedCountry, digits, strict: true)) {
        return widget.invalidMessage ?? l10n.invalidNumber;
      }
    }

    if (widget.validator == null) return null;

    final result = widget.validator!.call(_currentNumber());
    if (result is Future<String?>) {
      // Async: report the last known result and re-validate when it settles.
      _runValidator(_currentNumber());
      return _validatorMessage;
    }
    _validatorMessage = result;
    return result;
  }

  // ----------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {
    final limit = widget.disableLengthCheck
        ? widget.maxLength
        : (widget.maxLength ?? _selectedCountry.maxLength);

    return TextFormField(
      key: widget.formFieldKey,
      controller: _controller,
      restorationId: widget.restorationId,
      autofillHints: widget.autofillHints ??
          const [
            // Telephone first: iOS and macOS QuickType only honour the first
            // hint, and it is the full number they have stored.
            AutofillHints.telephoneNumber,
            AutofillHints.telephoneNumberNational,
          ],
      readOnly: widget.readOnly,
      obscureText: widget.obscureText,
      textAlign: widget.textAlign,
      textAlignVertical: widget.textAlignVertical,
      cursorColor: widget.cursorColor,
      onTap: widget.onTap,
      onTapOutside: widget.onTapOutside,
      onFieldSubmitted: widget.onSubmitted,
      focusNode: widget.focusNode,
      cursorHeight: widget.cursorHeight,
      cursorRadius: widget.cursorRadius,
      cursorWidth: widget.cursorWidth,
      showCursor: widget.showCursor,
      magnifierConfiguration: widget.magnifierConfiguration,
      decoration: widget.decoration.copyWith(
        prefixIcon: widget.prefixIcon ?? _buildCountrySelector(),
        counterText: !widget.enabled ? '' : null,
        hintText: widget.decoration.hintText ??
            (widget.showExampleAsHint ? _exampleHint() : null),
      ),
      style: widget.style,
      onSaved: (_) => widget.onSaved?.call(_currentNumber()),
      onChanged: _onChanged,
      validator: _validate,
      // TextField's maxLength counts characters, so with formatting on it
      // would cut '(201) 555-0123' down to ten characters. The digit cap is
      // enforced by _DigitLimitingFormatter instead, and the counter below
      // reports digits rather than characters.
      maxLength:
          (widget.disableLengthCheck || widget.formatInput) ? null : limit,
      onEditingComplete: widget.onEditingComplete,
      expands: widget.expands,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      maxLengthEnforcement: widget.maxLengthEnforcement,
      buildCounter: widget.buildCounter ??
          (widget.formatInput && limit != null ? _digitCounter(limit) : null),
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters ??
          <TextInputFormatter>[
            // The detector runs first: it is the only stage that still sees the
            // '+' of a pasted international number, which every later stage
            // strips.
            _detector,
            FilteringTextInputFormatter.allow(RegExp(r'[0-9+\s\-().]')),
            _limiter,
            _formatter,
          ],
      enabled: widget.enabled,
      keyboardAppearance: widget.keyboardAppearance,
      autofocus: widget.autofocus,
      textInputAction: widget.textInputAction,
      autovalidateMode: widget.autovalidateMode,
    );
  }

  /// Counts digits rather than characters, so a formatted number still
  /// reports '7/10' and not '12/10'.
  InputCounterWidgetBuilder _digitCounter(int limit) {
    return (context, {required currentLength, required isFocused, maxLength}) {
      final count = _digits.length;
      return Text(
        '$count/$limit',
        semanticsLabel: '$count of $limit digits',
        style: Theme.of(context).textTheme.bodySmall,
      );
    };
  }

  String? _exampleHint() {
    final example = _selectedCountry.example;
    if (example == null) return null;
    return widget.formatInput
        ? AsYouTypeFormatter.format(_selectedCountry, example)
        : example;
  }

  Widget _buildCountrySelector() {
    final open = widget.enabled ? _openPicker : null;

    if (widget.countrySelectorBuilder != null) {
      return widget.countrySelectorBuilder!(
          context, _selectedCountry, open ?? () {});
    }

    final showIcon = widget.enabled && widget.showDropdownIcon;
    final children = <Widget>[
      const SizedBox(width: 4),
      if (showIcon && widget.dropdownIconPosition == IconPosition.leading) ...[
        widget.dropdownIcon,
        const SizedBox(width: 4),
      ],
      if (widget.showCountryFlag) ...[
        widget.flagBuilder?.call(context, _selectedCountry) ??
            CountryFlag(
              country: _selectedCountry,
              shape: widget.flagShape,
              size: widget.flagSize,
            ),
        const SizedBox(width: 8),
      ],
      if (widget.showCountryCode) ...[
        widget.dialCodeBuilder?.call(context, _selectedCountry) ??
            FittedBox(
              child: Text(
                '+${_selectedCountry.displayCC}',
                // Keep '+971' from rendering as '971+' in RTL layouts.
                textDirection: TextDirection.ltr,
                style: widget.dropdownTextStyle,
              ),
            ),
      ],
      if (showIcon && widget.dropdownIconPosition == IconPosition.trailing) ...[
        const SizedBox(width: 4),
        widget.dropdownIcon,
      ],
      const SizedBox(width: 8),
    ];

    return Container(
      margin: widget.flagsButtonMargin,
      child: DecoratedBox(
        decoration: widget.dropdownDecoration,
        child: Semantics(
          button: true,
          enabled: widget.enabled,
          label: _localizations.countrySelectorLabelFor(
              _selectedCountry.localizedName(widget.languageCode)),
          child: InkWell(
            // BorderRadiusDirectional is a BorderRadiusGeometry but not a
            // BorderRadius, so a cast here crashes for RTL-aware decorations.
            borderRadius: switch (widget.dropdownDecoration.borderRadius) {
              final BorderRadius r => r,
              _ => null,
            },
            onTap: open,
            child: Padding(
              padding: widget.flagsButtonPadding,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Caps the number of *digits*, ignoring any formatting separators.
///
/// The limit is read on each edit rather than captured, so it follows the
/// selected country without the field having to rebuild first.
class _DigitLimitingFormatter extends TextInputFormatter {
  const _DigitLimitingFormatter(this.limit);

  final int? Function() limit;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final max = limit();
    if (max == null) return newValue;
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    if (digits.length <= max) return newValue;
    return oldValue;
  }
}

/// Rewrites a pasted or typed international number into its national part and
/// reports the country it belongs to.
///
/// This has to run before the digits-only filter: once the '+' is gone there is
/// no way to tell '+447400123456' from a long national number.
class _CountryDetectingFormatter extends TextInputFormatter {
  const _CountryDetectingFormatter({
    required this.isEnabled,
    required this.resolve,
    required this.onDetected,
  });

  final bool Function() isEnabled;
  final Country? Function(String raw) resolve;
  final void Function(Country country) onDetected;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (!isEnabled()) return newValue;

    final raw = newValue.text.trim();
    final isInternational =
        raw.startsWith('+') || (raw.startsWith('00') && raw.length > 4);
    if (!isInternational) return newValue;

    final country = resolve(raw);
    if (country == null) return newValue;

    final parsed = PhoneNumber.fromCompleteNumber(completeNumber: raw);
    if (parsed.countryISOCode.isEmpty) return newValue;

    onDetected(country);
    return TextEditingValue(
      text: parsed.number,
      selection: TextSelection.collapsed(offset: parsed.number.length),
    );
  }
}
