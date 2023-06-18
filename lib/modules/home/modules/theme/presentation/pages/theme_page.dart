import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulario_dev/main_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeOption {
  String name;
  ThemeMode value;
  ThemeOption({required this.name, required this.value});
}

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  static String path = "/home/theme";

  @override
  Widget build(BuildContext context) {
    final mainController = context.watch<MainController>();
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
        appBar: AppBar(
          title: Text(localization.theme_page_title),
        ),
        body: Column(
          children: ThemeMode.values
              .map((e) => RadioListTile(
                  value: e,
                  title: Text(
                      localization.theme_page_options_title(describeEnum(e))),
                  groupValue: mainController.themeMode,
                  onChanged: (theme) {
                    if (theme != null) {
                      mainController.themeMode = theme;
                    }
                  }))
              .toList(),
        ));
  }
}



class CustomColorScheme extends ColorScheme {
  final Color background1;
  final Color background2;
  final Color background3;

  const CustomColorScheme({
    required this.background1,
    required this.background2,
    required this.background3,
    // Heredamos los demás parámetros del constructor de ColorScheme
    required Color primary,
    required Color secondary,
    required Color surface,
    required Color background,
    required Color error,
    required Color onPrimary,
    required Color onSecondary,
    required Color onSurface,
    required Color onBackground,
    required Color onError,
    required Brightness brightness,
    Color? tertiary,
    Color? onTertiary
  }) : super(
          primary: primary,
          secondary: secondary,
          surface: surface,
          background: background,
          error: error,
          onPrimary: onPrimary,
          onSecondary: onSecondary,
          onSurface: onSurface,
          onBackground: onBackground,
          onError: onError,
          brightness: brightness,
          tertiary: tertiary,
          onTertiary: onTertiary
        );

  ColorScheme copyWitH({
    Brightness? brightness,
    Color? primary,
    Color? primaryVariant,
    Color? secondary,
    Color? secondaryVariant,
    Color? surface,
    Color? background,
    Color? error,
    Color? onPrimary,
    Color? onSecondary,
    Color? onSurface,
    Color? onBackground,
    Color? onError,
  }) {
    return CustomColorScheme(
      brightness: brightness ?? this.brightness,
      background1: background1,
      background2: background2,
      background3: background3,
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      surface: surface ?? this.surface,
      background: background ?? this.background,
      error: error ?? this.error,
      onPrimary: onPrimary ?? this.onPrimary,
      onSecondary: onSecondary ?? this.onSecondary,
      onSurface: onSurface ?? this.onSurface,
      onBackground: onBackground ?? this.onBackground,
      onError: onError ?? this.onError,
    );
  }
}

final testTheme = ThemeData.from(
  colorScheme: const CustomColorScheme(
    background1: Colors.black,
    background2: Colors.black12,
    background3: Colors.black26,
    background: Colors.black38,
    brightness: Brightness.light,
    error: Colors.red,
    onBackground: Colors.white,
    onError: Colors.white,
    onPrimary: Colors.white,
    primary: Colors.green,
    onSecondary: Colors.white,
    secondary: Colors.blue,
    surface: Colors.black87,
    onSurface: Colors.white
  )
);

final colorschema = testTheme.colorScheme as CustomColorScheme;

final testc = colorschema.background1;
