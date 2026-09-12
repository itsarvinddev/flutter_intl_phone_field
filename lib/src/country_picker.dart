import 'package:flutter/material.dart';

import 'country.dart';
import 'country_flag.dart';
import 'helpers.dart';
import 'localization.dart';

/// How the country picker is presented.
enum DialogType {
  /// A centred [Dialog]. The default.
  showDialog,

  /// A [showModalBottomSheet] sized by [PickerDialogStyle.heightFactor].
  showModalBottomSheet,

  /// A bottom sheet the user can drag between a half and a full screen.
  showDraggableBottomSheet,

  /// A full-screen route, which suits small screens and long lists.
  showFullScreenPage,

  /// A bottom sheet on iOS and macOS, a dialog elsewhere.
  adaptive,
}

/// Styling for the country picker.
///
/// Every field is optional; anything left null follows the ambient [Theme].
class PickerDialogStyle {
  /// Background of the dialog, sheet or page.
  final Color? backgroundColor;

  /// Text style for the dial code shown at the end of each row.
  final TextStyle? countryCodeStyle;

  /// Text style for the country name.
  final TextStyle? countryNameStyle;

  /// Widget drawn between rows. Pass `SizedBox.shrink()` for no divider.
  final Widget? listTileDivider;

  /// Content padding for each row.
  final EdgeInsets? listTilePadding;

  /// Inset padding around the dialog.
  final EdgeInsets? dialogPadding;

  /// Padding inside the dialog, around the search field and list.
  final EdgeInsets? padding;

  /// Cursor colour for the search field.
  final Color? searchFieldCursorColor;

  /// Decoration for the search field. Overrides the default label.
  final InputDecoration? searchFieldInputDecoration;

  /// Padding around the search field.
  final EdgeInsets? searchFieldPadding;

  /// Text style for the search field's input.
  final TextStyle? searchFieldStyle;

  /// Fixed width for the dialog. Defaults to the available width.
  final double? width;

  /// Fraction of the screen height the sheet or dialog occupies, 0–1.
  final double? heightFactor;

  /// How dragging the list affects the keyboard.
  final ScrollViewKeyboardDismissBehavior? scrollViewKeyboardDismissBehavior;

  /// Background colour of the currently selected row.
  final Color? selectedTileColor;

  /// Whether the search field takes focus when the picker opens.
  ///
  /// Defaults to false so the list is visible before the keyboard appears.
  final bool autofocusSearchField;

  /// Whether to show a clear button in the search field once it has text.
  final bool showSearchClearButton;

  /// Shape of the flags in the list.
  final FlagShape flagShape;

  /// Width of the flags in the list.
  final double flagSize;

  const PickerDialogStyle({
    this.backgroundColor,
    this.countryCodeStyle,
    this.countryNameStyle,
    this.listTileDivider,
    this.listTilePadding,
    this.dialogPadding,
    this.padding,
    this.searchFieldCursorColor,
    this.searchFieldInputDecoration,
    this.searchFieldPadding,
    this.searchFieldStyle,
    this.width,
    this.heightFactor,
    this.scrollViewKeyboardDismissBehavior,
    this.selectedTileColor,
    this.autofocusSearchField = false,
    this.showSearchClearButton = true,
    this.flagShape = FlagShape.rectangle,
    this.flagSize = 32,
  });
}

/// Show the country picker and return the country the user chose, or `null`
/// if they dismissed it.
Future<Country?> showCountryPicker({
  required BuildContext context,
  required List<Country> countries,
  required Country selectedCountry,
  DialogType dialogType = DialogType.showDialog,
  PickerDialogStyle? style,
  String languageCode = 'en',
  List<Country> favorites = const <Country>[],
  IntlPhoneFieldLocalizations localizations =
      IntlPhoneFieldLocalizations.fallback,
  bool useRootNavigator = false,
}) {
  final resolved = dialogType == DialogType.adaptive
      ? (switch (Theme.of(context).platform) {
          TargetPlatform.iOS ||
          TargetPlatform.macOS =>
            DialogType.showModalBottomSheet,
          _ => DialogType.showDialog,
        })
      : dialogType;

  Widget body({ScrollController? scrollController}) => CountryPickerBody(
        countries: countries,
        selectedCountry: selectedCountry,
        style: style,
        languageCode: languageCode,
        favorites: favorites,
        localizations: localizations,
        scrollController: scrollController,
      );

  switch (resolved) {
    case DialogType.showDialog:
    case DialogType.adaptive:
      return showDialog<Country>(
        context: context,
        useRootNavigator: useRootNavigator,
        builder: (_) => _PickerDialog(style: style, child: body()),
      );

    case DialogType.showModalBottomSheet:
      return showModalBottomSheet<Country>(
        context: context,
        useRootNavigator: useRootNavigator,
        isScrollControlled: true,
        backgroundColor: style?.backgroundColor,
        builder: (ctx) => FractionallySizedBox(
          heightFactor: style?.heightFactor ?? 0.8,
          child: Padding(
            padding:
                EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(ctx).bottom),
            child: body(),
          ),
        ),
      );

    case DialogType.showDraggableBottomSheet:
      return showModalBottomSheet<Country>(
        context: context,
        useRootNavigator: useRootNavigator,
        isScrollControlled: true,
        backgroundColor: style?.backgroundColor,
        builder: (_) => DraggableScrollableSheet(
          expand: false,
          initialChildSize: style?.heightFactor ?? 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.95,
          builder: (_, controller) => body(scrollController: controller),
        ),
      );

    case DialogType.showFullScreenPage:
      return Navigator.of(context, rootNavigator: useRootNavigator)
          .push<Country>(MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => Scaffold(
          backgroundColor: style?.backgroundColor,
          appBar: AppBar(title: Text(localizations.searchHint)),
          body: SafeArea(child: body()),
        ),
      ));
  }
}

class _PickerDialog extends StatelessWidget {
  const _PickerDialog({required this.child, this.style});

  final Widget child;
  final PickerDialogStyle? style;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.sizeOf(context);
    // Left unbounded, the dialog spans a whole desktop window. Cap it at a
    // comfortable reading width and let narrow screens use what they have.
    final width = style?.width ?? (media.width < 560 ? media.width : 480.0);
    const horizontal = 40.0;
    const vertical = 24.0;
    return Dialog(
      insetPadding: style?.dialogPadding ??
          EdgeInsets.symmetric(
            vertical: vertical,
            horizontal: media.width > (width + horizontal * 2)
                ? (media.width - width) / 2
                : horizontal,
          ),
      backgroundColor: style?.backgroundColor,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: media.height * (style?.heightFactor ?? 1.0),
        ),
        child: child,
      ),
    );
  }
}

/// The picker's contents: a search field above a list of countries.
///
/// Exposed so it can be embedded in a layout of your own; it pops the enclosing
/// route with the chosen [Country].
class CountryPickerBody extends StatefulWidget {
  const CountryPickerBody({
    super.key,
    required this.countries,
    required this.selectedCountry,
    this.style,
    this.languageCode = 'en',
    this.favorites = const <Country>[],
    this.localizations = IntlPhoneFieldLocalizations.fallback,
    this.scrollController,
  });

  final List<Country> countries;
  final Country selectedCountry;
  final PickerDialogStyle? style;
  final String languageCode;
  final List<Country> favorites;
  final IntlPhoneFieldLocalizations localizations;
  final ScrollController? scrollController;

  @override
  State<CountryPickerBody> createState() => _CountryPickerBodyState();
}

class _CountryPickerBodyState extends State<CountryPickerBody> {
  late final TextEditingController _search = TextEditingController();
  late List<_Row> _rows;

  @override
  void initState() {
    super.initState();
    _rows = _build('');
  }

  @override
  void didUpdateWidget(CountryPickerBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.countries != widget.countries ||
        oldWidget.favorites != widget.favorites ||
        oldWidget.languageCode != widget.languageCode) {
      _rows = _build(_search.text);
    }
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  List<_Row> _build(String query) {
    final matches =
        widget.countries.stringSearch(query).sortedByName(widget.languageCode);
    if (widget.favorites.isEmpty) {
      return [for (final c in matches) _Row.country(c)];
    }
    final favCodes = {for (final f in widget.favorites) f.code};
    final favs = <Country>[
      for (final f in widget.favorites)
        if (matches.any((m) => m.code == f.code)) f,
    ];
    final rest = [
      for (final c in matches)
        if (!favCodes.contains(c.code)) c,
    ];
    return [
      if (favs.isNotEmpty) _Row.header(widget.localizations.favoritesLabel),
      for (final c in favs) _Row.country(c),
      if (favs.isNotEmpty && rest.isNotEmpty) _Row.header(''),
      for (final c in rest) _Row.country(c),
    ];
  }

  void _onSearch(String value) => setState(() => _rows = _build(value));

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = widget.style;
    final divider = style?.listTileDivider ?? const Divider(thickness: 1);

    return Padding(
      padding: style?.padding ?? const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Padding(
            padding: style?.searchFieldPadding ?? EdgeInsets.zero,
            child: TextField(
              controller: _search,
              autofocus: style?.autofocusSearchField ?? false,
              cursorColor: style?.searchFieldCursorColor,
              style: style?.searchFieldStyle,
              textInputAction: TextInputAction.search,
              decoration: style?.searchFieldInputDecoration ??
                  InputDecoration(
                    labelText: widget.localizations.searchHint,
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: (style?.showSearchClearButton ?? true) &&
                            _search.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            tooltip: MaterialLocalizations.of(context)
                                .deleteButtonTooltip,
                            onPressed: () {
                              _search.clear();
                              _onSearch('');
                            },
                          )
                        : null,
                  ),
              onChanged: _onSearch,
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: _rows.isEmpty
                ? Center(
                    child: Text(
                      widget.localizations.noCountriesFound,
                      style: theme.textTheme.bodyMedium,
                    ),
                  )
                : ListView.builder(
                    controller: widget.scrollController,
                    keyboardDismissBehavior:
                        style?.scrollViewKeyboardDismissBehavior ??
                            ScrollViewKeyboardDismissBehavior.onDrag,
                    itemCount: _rows.length,
                    itemBuilder: (context, index) {
                      final row = _rows[index];
                      if (row.isHeader) {
                        return row.title!.isEmpty
                            ? divider
                            : Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(16, 12, 16, 4),
                                child: Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: Text(
                                    row.title!,
                                    style: theme.textTheme.labelMedium
                                        ?.copyWith(
                                            color: theme.colorScheme.primary),
                                  ),
                                ),
                              );
                      }
                      final country = row.country!;
                      final selected =
                          country.code == widget.selectedCountry.code;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            selected: selected,
                            selectedTileColor: style?.selectedTileColor,
                            leading: CountryFlag(
                              country: country,
                              shape: style?.flagShape ?? FlagShape.rectangle,
                              size: style?.flagSize ?? 32,
                            ),
                            contentPadding: style?.listTilePadding,
                            title: Text(
                              country.localizedName(widget.languageCode),
                              style: style?.countryNameStyle ??
                                  const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            trailing: Text(
                              '+${country.displayCC}',
                              // '+' must lead the digits even in RTL layouts.
                              textDirection: TextDirection.ltr,
                              style: style?.countryCodeStyle ??
                                  const TextStyle(fontWeight: FontWeight.w700),
                            ),
                            onTap: () => Navigator.of(context).pop(country),
                          ),
                          divider,
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _Row {
  const _Row.country(Country this.country)
      : title = null,
        isHeader = false;
  const _Row.header(String this.title)
      : country = null,
        isHeader = true;

  final Country? country;
  final String? title;
  final bool isHeader;
}
