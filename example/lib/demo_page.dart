import 'package:flutter_intl_phone_field/flutter_intl_phone_field.dart';
import 'package:material_ui/material_ui.dart';

/// Carries the app-wide light/dark setting down to every page.
///
/// Installed once, above the navigator, by `MaterialApp.builder` in
/// `main.dart`, so any demo can flip the theme from its app bar.
class ThemeModeScope extends InheritedNotifier<ValueNotifier<ThemeMode>> {
  const ThemeModeScope({
    super.key,
    required ValueNotifier<ThemeMode> notifier,
    required super.child,
  }) : super(notifier: notifier);

  static ValueNotifier<ThemeMode> of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<ThemeModeScope>();
    assert(scope != null, 'No ThemeModeScope above this widget.');
    return scope!.notifier!;
  }
}

/// The light/dark switch shown in every app bar.
class ThemeModeButton extends StatelessWidget {
  const ThemeModeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final mode = ThemeModeScope.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return IconButton(
      tooltip: isDark ? 'Switch to light theme' : 'Switch to dark theme',
      icon: Icon(isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
      onPressed: () => mode.value = isDark ? ThemeMode.light : ThemeMode.dark,
    );
  }
}

/// Page chrome shared by every demo: a title, a short explanation of what the
/// page shows, the theme toggle, and a scrolling body.
class DemoScaffold extends StatelessWidget {
  const DemoScaffold({
    super.key,
    required this.title,
    required this.description,
    required this.children,
  });

  final String title;

  /// One or two sentences saying what the page demonstrates.
  final String description;

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: const <Widget>[ThemeModeButton()],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 48),
          children: <Widget>[
            Text(description, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 20),
            ...children,
          ],
        ),
      ),
    );
  }
}

/// A titled block inside a demo page, optionally with a caption explaining the
/// parameter being shown.
class DemoSection extends StatelessWidget {
  const DemoSection({
    super.key,
    required this.title,
    this.caption,
    required this.child,
  });

  final String title;
  final String? caption;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (caption != null) ...<Widget>[
            const SizedBox(height: 4),
            Text(caption!, style: theme.textTheme.bodySmall),
          ],
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

/// Renders every field of a [PhoneNumber] on screen.
///
/// The example never prints to the console: whatever a demo produces is shown
/// through one of these panels instead.
class PhoneValuePanel extends StatelessWidget {
  const PhoneValuePanel({
    super.key,
    this.value,
    this.title = 'Live value',
    this.extras = const <String, String>{},
  });

  /// The value to display, or null before anything has been typed.
  final PhoneNumber? value;

  final String title;

  /// Extra rows appended after the [PhoneNumber] fields.
  final Map<String, String> extras;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final number = value;
    final rows = <String, String>{};
    if (number == null) {
      if (extras.isEmpty) rows['(no value yet)'] = 'Type a number above';
    } else {
      rows['countryISOCode'] = number.countryISOCode;
      rows['countryCode'] = number.countryCode;
      rows['number'] = number.number.isEmpty ? '(empty)' : number.number;
      rows['completeNumber'] = number.completeNumber;
      rows['isValidNumber()'] = '${number.isValidNumber()}';
      rows['isValidNumber(strict: true)'] =
          '${number.isValidNumber(strict: true)}';
    }
    rows.addAll(extras);

    return Card(
      margin: EdgeInsets.zero,
      color: theme.colorScheme.surfaceContainerHighest,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            for (final entry in rows.entries)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 168,
                      child: Text(entry.key, style: theme.textTheme.bodySmall),
                    ),
                    Expanded(
                      child: Text(
                        entry.value,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// The outlined decoration used by most fields in this example.
InputDecoration phoneDecoration(String label, {String? helper}) =>
    InputDecoration(
      labelText: label,
      helperText: helper,
      border: const OutlineInputBorder(),
    );
