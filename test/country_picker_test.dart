import 'package:flutter/material.dart';
import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:flutter_test/flutter_test.dart';

Country _byCode(String code) => countries.firstWhere((c) => c.code == code);

/// Captures what [showCountryPicker] resolved to.
class _Picker {
  Country? result;
  bool closed = false;
}

Future<_Picker> _open(
  WidgetTester tester, {
  DialogType dialogType = DialogType.showDialog,
  Country? selectedCountry,
  List<Country>? list,
  List<Country> favorites = const <Country>[],
  PickerDialogStyle? style,
  IntlPhoneFieldLocalizations localizations =
      IntlPhoneFieldLocalizations.fallback,
  String languageCode = 'en',
}) async {
  final picker = _Picker();
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => Center(
            child: ElevatedButton(
              onPressed: () async {
                picker.result = await showCountryPicker(
                  context: context,
                  countries: list ?? countries,
                  selectedCountry: selectedCountry ?? _byCode('US'),
                  dialogType: dialogType,
                  favorites: favorites,
                  style: style,
                  localizations: localizations,
                  languageCode: languageCode,
                );
                picker.closed = true;
              },
              child: const Text('open'),
            ),
          ),
        ),
      ),
    ),
  );
  await tester.tap(find.text('open'));
  await tester.pumpAndSettle();
  return picker;
}

Future<void> _search(WidgetTester tester, String query) async {
  await tester.enterText(find.byType(TextField), query);
  await tester.pumpAndSettle();
}

List<String> _renderedNames(WidgetTester tester) => [
  for (final tile in tester.widgetList<ListTile>(find.byType(ListTile)))
    (tile.title as Text).data!,
];

void main() {
  group('showCountryPicker', () {
    testWidgets('returns the country the user taps', (tester) async {
      final picker = await _open(tester);
      await _search(tester, 'Antigua');
      await tester.tap(find.widgetWithText(ListTile, 'Antigua & Barbuda'));
      await tester.pumpAndSettle();

      expect(picker.closed, isTrue);
      expect(picker.result?.code, 'AG');
    });

    testWidgets('returns null when dismissed', (tester) async {
      final picker = await _open(tester);
      expect(find.byType(ListTile), findsWidgets);

      await tester.tapAt(const Offset(5, 5));
      await tester.pumpAndSettle();

      expect(picker.closed, isTrue);
      expect(picker.result, isNull);
      expect(find.byType(ListTile), findsNothing);
    });

    testWidgets('lists every country, sorted by name', (tester) async {
      await _open(tester);
      expect(_renderedNames(tester).first, 'Afghanistan');
      expect(_renderedNames(tester), contains('Albania'));
    });

    testWidgets('sorts and labels the list in the given language', (
      tester,
    ) async {
      await _open(tester, languageCode: 'fr');
      expect(_renderedNames(tester).first, 'Afghanistan');
      expect(_renderedNames(tester), contains('Afrique du Sud'));
      expect(_renderedNames(tester), isNot(contains('South Africa')));
    });
  });

  group('search field', () {
    testWidgets('filters the list', (tester) async {
      await _open(tester);
      expect(_renderedNames(tester), contains('Afghanistan'));

      await _search(tester, 'Antigua');
      expect(_renderedNames(tester), <String>['Antigua & Barbuda']);
      expect(find.text('Afghanistan'), findsNothing);
    });

    testWidgets('filters by dial code prefix', (tester) async {
      await _open(tester);
      await _search(tester, '+44');
      expect(_renderedNames(tester), <String>[
        'Guernsey',
        'Isle of Man',
        'Jersey',
        'United Kingdom',
      ]);
    });

    testWidgets('shows the localised empty message when nothing matches', (
      tester,
    ) async {
      await _open(
        tester,
        localizations: const IntlPhoneFieldLocalizations(
          noCountriesFound: 'Nothing here',
        ),
      );
      await _search(tester, 'zzzzz');

      expect(find.byType(ListTile), findsNothing);
      expect(find.text('Nothing here'), findsOneWidget);
    });

    testWidgets('the clear button empties the search and restores the list', (
      tester,
    ) async {
      await _open(tester);
      await _search(tester, 'zzzzz');
      expect(find.text('No countries found'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.clear));
      await tester.pumpAndSettle();

      expect(
        tester.widget<TextField>(find.byType(TextField)).controller!.text,
        isEmpty,
      );
      expect(find.text('No countries found'), findsNothing);
      expect(_renderedNames(tester), contains('Afghanistan'));
      expect(find.byIcon(Icons.clear), findsNothing);
    });

    testWidgets('the clear button is hidden when disabled by the style', (
      tester,
    ) async {
      await _open(
        tester,
        style: const PickerDialogStyle(showSearchClearButton: false),
      );
      await _search(tester, 'Antigua');
      expect(find.byIcon(Icons.clear), findsNothing);
    });
  });

  group('rows', () {
    testWidgets('show the full calling code, area code included', (
      tester,
    ) async {
      await _open(tester);
      await _search(tester, 'Antigua');

      expect(find.text('+1 268'), findsOneWidget);
      expect(find.text('+1'), findsNothing);
    });

    testWidgets('mark the currently selected country', (tester) async {
      await _open(tester, selectedCountry: _byCode('IN'));
      await _search(tester, 'india');

      expect(_renderedNames(tester), <String>[
        'British Indian Ocean Territory',
        'India',
      ]);
      expect(
        tester
            .widget<ListTile>(find.widgetWithText(ListTile, 'India'))
            .selected,
        isTrue,
      );
      expect(
        tester
            .widget<ListTile>(
              find.widgetWithText(ListTile, 'British Indian Ocean Territory'),
            )
            .selected,
        isFalse,
      );
    });
  });

  group('favorites', () {
    testWidgets('are pinned at the top under the favourites header', (
      tester,
    ) async {
      await _open(tester, favorites: <Country>[_byCode('IN'), _byCode('GB')]);

      final names = _renderedNames(tester);
      expect(names.take(2).toList(), <String>['India', 'United Kingdom']);
      // Neither is repeated further down the list.
      expect(names.where((n) => n == 'India').length, 1);
      expect(names.where((n) => n == 'United Kingdom').length, 1);

      expect(find.text('Frequently used'), findsOneWidget);
      expect(
        tester.getTopLeft(find.text('Frequently used')).dy,
        lessThan(tester.getTopLeft(find.text('India')).dy),
      );
    });

    testWidgets('use the localised favourites label', (tester) async {
      await _open(
        tester,
        favorites: <Country>[_byCode('IN')],
        localizations: const IntlPhoneFieldLocalizations(
          favoritesLabel: 'Pinned',
        ),
      );
      expect(find.text('Pinned'), findsOneWidget);
    });

    testWidgets('are filtered out when they do not match the search', (
      tester,
    ) async {
      await _open(tester, favorites: <Country>[_byCode('IN')]);
      await _search(tester, 'Antigua');

      expect(find.text('Frequently used'), findsNothing);
      expect(_renderedNames(tester), <String>['Antigua & Barbuda']);
    });
  });

  group('dialog types', () {
    testWidgets('showModalBottomSheet opens and selects', (tester) async {
      final picker = await _open(
        tester,
        dialogType: DialogType.showModalBottomSheet,
      );
      expect(find.byType(BottomSheet), findsOneWidget);

      await _search(tester, 'Antigua');
      await tester.tap(find.widgetWithText(ListTile, 'Antigua & Barbuda'));
      await tester.pumpAndSettle();

      expect(picker.result?.code, 'AG');
    });

    testWidgets('showDraggableBottomSheet opens and selects', (tester) async {
      final picker = await _open(
        tester,
        dialogType: DialogType.showDraggableBottomSheet,
      );
      expect(find.byType(DraggableScrollableSheet), findsOneWidget);

      await _search(tester, 'Antigua');
      await tester.tap(find.widgetWithText(ListTile, 'Antigua & Barbuda'));
      await tester.pumpAndSettle();

      expect(picker.result?.code, 'AG');
    });

    testWidgets('showFullScreenPage opens and selects', (tester) async {
      final picker = await _open(
        tester,
        dialogType: DialogType.showFullScreenPage,
      );
      expect(find.byType(AppBar), findsOneWidget);

      await _search(tester, 'Antigua');
      await tester.tap(find.widgetWithText(ListTile, 'Antigua & Barbuda'));
      await tester.pumpAndSettle();

      expect(picker.result?.code, 'AG');
    });
  });

  group('PickerDialogStyle', () {
    testWidgets('searchFieldStyle reaches the search field', (tester) async {
      const searchStyle = TextStyle(fontSize: 27, color: Color(0xFF00FF00));
      await _open(
        tester,
        style: const PickerDialogStyle(searchFieldStyle: searchStyle),
      );

      expect(
        tester.widget<TextField>(find.byType(TextField)).style,
        searchStyle,
      );
    });

    testWidgets('searchFieldInputDecoration replaces the default label', (
      tester,
    ) async {
      await _open(
        tester,
        style: const PickerDialogStyle(
          searchFieldInputDecoration: InputDecoration(labelText: 'Find'),
        ),
      );

      expect(find.text('Find'), findsOneWidget);
      expect(find.text('Search country'), findsNothing);
    });

    testWidgets('countryNameStyle and countryCodeStyle reach the rows', (
      tester,
    ) async {
      const nameStyle = TextStyle(fontSize: 21);
      const codeStyle = TextStyle(fontSize: 13);
      await _open(
        tester,
        style: const PickerDialogStyle(
          countryNameStyle: nameStyle,
          countryCodeStyle: codeStyle,
        ),
      );
      await _search(tester, 'Antigua');

      expect(
        tester.widget<Text>(find.text('Antigua & Barbuda')).style,
        nameStyle,
      );
      expect(tester.widget<Text>(find.text('+1 268')).style, codeStyle);
    });
  });
}
