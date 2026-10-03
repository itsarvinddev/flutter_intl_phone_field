import 'package:material_ui/material_ui.dart';

import 'demo_page.dart';
import 'home_page.dart';

void main() => runApp(const ExampleApp());

/// Root of the example gallery.
///
/// Holds nothing but the theme mode and the route table; every feature is
/// demonstrated on its own page under `lib/demos/`.
class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  final ValueNotifier<ThemeMode> _themeMode = ValueNotifier<ThemeMode>(
    ThemeMode.system,
  );

  @override
  void dispose() {
    _themeMode.dispose();
    super.dispose();
  }

  ThemeData _theme(Brightness brightness) => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF0B6BCB),
      brightness: brightness,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeMode,
      builder: (context, mode, _) => MaterialApp(
        title: 'flutter_intl_phone_field',
        debugShowCheckedModeBanner: false,
        theme: _theme(Brightness.light),
        darkTheme: _theme(Brightness.dark),
        themeMode: mode,
        // Installed above the navigator so every page can flip the theme.
        builder: (context, child) =>
            ThemeModeScope(notifier: _themeMode, child: child!),
        initialRoute: HomePage.route,
        routes: <String, WidgetBuilder>{
          HomePage.route: (_) => const HomePage(),
          for (final demo in demos) demo.route: demo.builder,
        },
      ),
    );
  }
}
