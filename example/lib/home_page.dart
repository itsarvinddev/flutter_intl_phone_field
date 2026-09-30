import 'package:flutter/material.dart';

import 'demo_page.dart';
import 'demos/basic_demo.dart';
import 'demos/controller_demo.dart';
import 'demos/country_list_demo.dart';
import 'demos/edge_cases_demo.dart';
import 'demos/formatting_demo.dart';
import 'demos/localization_demo.dart';
import 'demos/picker_demo.dart';
import 'demos/showcase_demo.dart';
import 'demos/styling_demo.dart';
import 'demos/validation_demo.dart';

/// One entry in the gallery: what it is called, what it shows, and the page
/// that shows it.
class DemoEntry {
  const DemoEntry({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.route,
    required this.builder,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String route;
  final WidgetBuilder builder;
}

/// The gallery's table of contents. `main.dart` turns this into the route
/// table, so adding a demo means adding one entry here.
const List<DemoEntry> demos = <DemoEntry>[
  DemoEntry(
    title: 'Showcase',
    subtitle: 'The same field in five different looks, on one screen.',
    icon: Icons.auto_awesome_outlined,
    route: ShowcaseDemo.route,
    builder: _showcase,
  ),
  DemoEntry(
    title: 'Basic usage & forms',
    subtitle: 'A field inside a Form, validated by a Submit button.',
    icon: Icons.edit_outlined,
    route: BasicDemo.route,
    builder: _basic,
  ),
  DemoEntry(
    title: 'Validation',
    subtitle:
        'Built-in length check, sync and async validators, '
        'strictValidation.',
    icon: Icons.rule_outlined,
    route: ValidationDemo.route,
    builder: _validation,
  ),
  DemoEntry(
    title: 'As-you-type formatting',
    subtitle: 'formatInput on and off, beside the raw digits it reports.',
    icon: Icons.format_shapes_outlined,
    route: FormattingDemo.route,
    builder: _formatting,
  ),
  DemoEntry(
    title: 'PhoneController',
    subtitle: 'Set the country, set the number, clear, read completeNumber.',
    icon: Icons.settings_remote_outlined,
    route: ControllerDemo.route,
    builder: _controller,
  ),
  DemoEntry(
    title: 'Country list curation',
    subtitle: 'favoriteCountries, onlyCountries and excludeCountries.',
    icon: Icons.playlist_add_check_outlined,
    route: CountryListDemo.route,
    builder: _countryList,
  ),
  DemoEntry(
    title: 'Picker presentation',
    subtitle: 'All five DialogType values, switchable at runtime.',
    icon: Icons.open_in_new_outlined,
    route: PickerDemo.route,
    builder: _picker,
  ),
  DemoEntry(
    title: 'Styling',
    subtitle: 'A dark PickerDialogStyle, flag shapes, a custom selector.',
    icon: Icons.palette_outlined,
    route: StylingDemo.route,
    builder: _styling,
  ),
  DemoEntry(
    title: 'Localization',
    subtitle: 'French strings and French country names.',
    icon: Icons.translate_outlined,
    route: LocalizationDemo.route,
    builder: _localization,
  ),
  DemoEntry(
    title: 'Edge cases',
    subtitle: 'RTL, large text, disabled, read-only, pre-filled UAE number.',
    icon: Icons.report_problem_outlined,
    route: EdgeCasesDemo.route,
    builder: _edgeCases,
  ),
];

// Const-constructible builders, so `demos` itself can be const.
Widget _showcase(BuildContext context) => const ShowcaseDemo();
Widget _basic(BuildContext context) => const BasicDemo();
Widget _validation(BuildContext context) => const ValidationDemo();
Widget _formatting(BuildContext context) => const FormattingDemo();
Widget _controller(BuildContext context) => const ControllerDemo();
Widget _countryList(BuildContext context) => const CountryListDemo();
Widget _picker(BuildContext context) => const PickerDemo();
Widget _styling(BuildContext context) => const StylingDemo();
Widget _localization(BuildContext context) => const LocalizationDemo();
Widget _edgeCases(BuildContext context) => const EdgeCasesDemo();

/// The gallery index.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('flutter_intl_phone_field'),
        actions: const <Widget>[ThemeModeButton()],
      ),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: demos.length,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final demo = demos[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primaryContainer,
                foregroundColor: theme.colorScheme.onPrimaryContainer,
                child: Icon(demo.icon),
              ),
              title: Text(demo.title),
              subtitle: Text(demo.subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.of(context).pushNamed(demo.route),
            );
          },
        ),
      ),
    );
  }
}
