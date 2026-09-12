# IntlPhoneField parameters

Every constructor parameter of `IntlPhoneField` in flutter_intl_phone_field
0.1.x, with its type and default. Generated from the constructor; if this
disagrees with the dartdoc, the dartdoc wins:
<https://pub.dev/documentation/flutter_intl_phone_field/latest/>.

## Value & country

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `key` | `Key?` | `null` | Widget key. |
| `formFieldKey` | `GlobalKey<FormFieldState>?` | `null` | Key for the underlying `TextFormField`, for calling `validate()` or `reset()` directly. |
| `initialCountryCode` | `String?` | `null` (falls back to `US`) | The country selected initially. Accepts an ISO 3166-1 alpha-2 code (`'IN'`) or a dial code (`'+225'`). |
| `initialValue` | `String?` | `null` | Pre-fills the field. Interpreted according to `initialValueFormat`. |
| `initialValueFormat` | `InitialValueFormat` | `InitialValueFormat.auto` | How `initialValue` is read: `auto` treats a leading `+`/`00` as international, `national` never strips a country code, `international` always does. |
| `languageCode` | `String` | `'en'` | Language used for country names in the picker. |
| `countries` | `List<Country>?` | `null` (all 251) | The countries to offer. |
| `onlyCountries` | `List<String>?` | `null` | Restrict the picker to these ISO 3166-1 alpha-2 codes. |
| `excludeCountries` | `List<String>?` | `null` | Remove these ISO 3166-1 alpha-2 codes from the picker. |
| `favoriteCountries` | `List<String>` | `const []` | ISO codes pinned to the top of the picker, in the order given. |
| `detectCountryOnPaste` | `bool` | `true` | Switch country automatically when a full international number is pasted or typed in. |
| `controller` | `TextEditingController?` | `null` | Controls the text being edited. One is created if you pass none. |
| `phoneController` | `PhoneController?` | `null` | Programmatic control over the country and number; listenable from outside the widget. |

## Validation & messages

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `validator` | `FutureOr<String?> Function(PhoneNumber?)?` | `null` | Validates the number, returning an error message or `null`. Runs after the built-in length check. Async validators are supported. |
| `disableLengthCheck` | `bool` | `false` | Skip the built-in minimum/maximum length check. Also lifts the typing limit. |
| `strictValidation` | `bool` | `false` | Require the number to match a real fixed-line or mobile range, not merely a plausible length. |
| `invalidMessage` | `String?` | `null` | Message shown when the length is outside the country's range. Overrides `localizations.invalidNumber`. |
| `localizations` | `IntlPhoneFieldLocalizations` | `IntlPhoneFieldLocalizations.fallback` | Strings shown by the field and the picker. |
| `autovalidateMode` | `AutovalidateMode?` | `AutovalidateMode.onUserInteraction` | When the field auto-validates. |
| `maxLength` | `int?` | `null` (country's maximum) | Maximum number of digits. |
| `maxLengthEnforcement` | `MaxLengthEnforcement?` | `null` | How `maxLength` is enforced. |

## Appearance

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `decoration` | `InputDecoration` | `const InputDecoration()` | Decoration for the text field. |
| `style` | `TextStyle?` | `null` | Style of the text being edited. |
| `showExampleAsHint` | `bool` | `false` | Show the country's example number as the hint. Ignored when `decoration` sets a `hintText`. |
| `formatInput` | `bool` | `false` | Format the number as it is typed, using the country's national layout. |
| `cursorColor` | `Color?` | `null` | Colour of the cursor. |
| `cursorHeight` | `double?` | `null` | Height of the cursor. |
| `cursorRadius` | `Radius?` | `Radius.zero` | Corner radius of the cursor. |
| `cursorWidth` | `double` | `2.0` | Thickness of the cursor. |
| `showCursor` | `bool?` | `true` | Whether to show the cursor. |
| `magnifierConfiguration` | `TextMagnifierConfiguration?` | `null` | Magnifier configuration for text selection. |

## Country selector

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `showCountryFlag` | `bool` | `true` | Whether to show the country flag. |
| `showCountryCode` | `bool` | `true` | Whether to show the country dial code. |
| `showDropdownIcon` | `bool` | `true` | Whether to show the dropdown arrow. Ignored when `enabled` is false. |
| `dropdownIcon` | `Icon` | `Icon(Icons.arrow_drop_down)` | The dropdown arrow itself. |
| `dropdownIconPosition` | `IconPosition` | `IconPosition.leading` | Where the arrow sits relative to the flag and dial code. |
| `dropdownTextStyle` | `TextStyle?` | `null` | Text style for the country dial code. |
| `dropdownDecoration` | `BoxDecoration` | `const BoxDecoration()` | Decoration behind the country selector button. |
| `flagShape` | `FlagShape` | `FlagShape.rectangle` | Shape of the flag: `rectangle`, `circle`, `rounded` or `square`. |
| `flagSize` | `double` | `32` | Width of the flag in logical pixels. |
| `flagBuilder` | `Widget Function(BuildContext, Country)?` | `null` | Replaces the flag widget entirely. |
| `dialCodeBuilder` | `Widget Function(BuildContext, Country)?` | `null` | Replaces the dial code widget. |
| `countrySelectorBuilder` | `Widget Function(BuildContext, Country, VoidCallback openPicker)?` | `null` | Replaces the whole selector; receives a callback that opens the picker. |
| `prefixIcon` | `Widget?` | `null` | Replaces the selector with your own prefix icon. The picker becomes unreachable. |
| `flagsButtonPadding` | `EdgeInsetsGeometry` | `EdgeInsets.zero` | Padding inside the selector button. |
| `flagsButtonMargin` | `EdgeInsets` | `EdgeInsets.zero` | Margin around the selector button. |

## Picker

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `dialogType` | `DialogType` | `DialogType.showDialog` | How the picker is presented: `showDialog`, `showModalBottomSheet`, `showDraggableBottomSheet`, `showFullScreenPage` or `adaptive`. |
| `pickerDialogStyle` | `PickerDialogStyle?` | `null` | Styling for the country picker. |
| `searchText` | `String` | `'Search country'` | **Deprecated** — use `localizations.searchHint` or `PickerDialogStyle.searchFieldInputDecoration`. Removed in 1.0.0. |

## Text field

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `keyboardType` | `TextInputType` | `TextInputType.phone` | Keyboard type for the field. |
| `keyboardAppearance` | `Brightness?` | `null` | Keyboard brightness. Honoured on iOS only. |
| `textInputAction` | `TextInputAction?` | `null` | Keyboard action button. |
| `textAlign` | `TextAlign` | `TextAlign.left` | How the text is aligned horizontally. |
| `textAlignVertical` | `TextAlignVertical?` | `null` | How the text is aligned vertically. |
| `obscureText` | `bool` | `false` | Whether to hide the text being edited. |
| `readOnly` | `bool` | `false` | Whether the field is read-only. |
| `enabled` | `bool` | `true` | Whether the field accepts input. When false the picker is disabled too. |
| `autofocus` | `bool` | `false` | Whether the field takes focus on first build. |
| `focusNode` | `FocusNode?` | `null` | Focus for the text field. |
| `inputFormatters` | `List<TextInputFormatter>?` | `null` | Defaults to digits-only plus the country's length limit, and as-you-type formatting when `formatInput` is true. Supplying your own replaces all of that. |
| `autofillHints` | `Iterable<String>?` | `null` | Defaults to `[telephoneNumber, telephoneNumberNational]`, the order iOS expects. |
| `minLines` | `int?` | `null` | Minimum number of lines. |
| `maxLines` | `int?` | `null` | Maximum number of lines. |
| `expands` | `bool` | `false` | Whether the field expands to fill its parent. |
| `buildCounter` | `InputCounterWidgetBuilder?` | `null` | Builds the character counter. |
| `restorationId` | `String?` | `null` | Restore state across app restarts. |

## Callbacks

| Parameter | Type | Default | Description |
| --- | --- | --- | --- |
| `onChanged` | `ValueChanged<PhoneNumber>?` | `null` | Called whenever the number or the country changes. |
| `onCountryChanged` | `ValueChanged<Country>?` | `null` | Called when the user picks a different country. |
| `onSubmitted` | `void Function(String)?` | `null` | Called when the user submits from the keyboard. |
| `onSaved` | `FormFieldSetter<PhoneNumber>?` | `null` | Called when the enclosing `Form` is saved. |
| `onTap` | `VoidCallback?` | `null` | Called when the field is tapped. |
| `onTapOutside` | `void Function(PointerDownEvent)?` | `null` | Called when a pointer goes down outside the field — useful for dismissing the iOS numeric keyboard. |
| `onEditingComplete` | `void Function()?` | `null` | Called when editing completes. |
