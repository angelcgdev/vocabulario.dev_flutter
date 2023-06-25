import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const colorSchemaLight = {
  'primaryColor': Color.fromRGBO(1, 17, 45, 1),
  'onPrimary': Color.fromRGBO(255, 255, 255, 1),
  'secondary': Color.fromRGBO(254, 55, 96, 1),
  'onSecondary': Color.fromRGBO(255, 255, 255, 1),
  'tertiary': Color.fromRGBO(44, 181, 125, 1),
  'disabledColor': Color.fromRGBO(206, 206, 206, 1),
  'background': Color.fromRGBO(255, 255, 255, 1),
  'tertiaryContainer': Color.fromRGBO(0, 236, 200, 1),
  'onTertiaryContainer': Color.fromRGBO(1, 17, 45, 1),
  'surface': Color.fromRGBO(1, 17, 45, 0.137),
};

class DefaultTheme {
  static const padding = 20.0;
  static const borderRadius = 6.0;
  static const paddingButton = 10.0;
  static const gap = 10.0;
  static const hightbtn = 50.0;
  static const maxWidth = 500.0;
}


final systemUiColorLight = SystemUiOverlayStyle.dark.copyWith(
  statusBarColor: Colors.transparent,
  systemNavigationBarColor: Colors.transparent
);
final systemUiColorDark = SystemUiOverlayStyle.light.copyWith(
  statusBarColor: Colors.transparent,
  systemNavigationBarColor: Colors.transparent
);

final themeLight = ThemeData(
  appBarTheme: AppBarTheme(
    centerTitle: true,
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      statusBarColor: Colors.transparent,
    ),
    titleTextStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: colorSchemaLight['primaryColor'],
    ),
  ),
  navigationBarTheme:
      NavigationBarThemeData(backgroundColor: colorSchemaDark['background']),
  useMaterial3: true,
  fontFamily: 'Poppins',
  splashColor: Colors.black12,
  brightness: Brightness.light,
  primaryColor: colorSchemaLight['primaryColor']!.withOpacity(.5),
  primaryColorLight: colorSchemaLight['primaryColor']!.withOpacity(.5),
  primaryColorDark: colorSchemaLight['primaryColor']!.withOpacity(.5),
  colorScheme: ThemeData.light().colorScheme.copyWith(
        primary: colorSchemaLight['primaryColor'],
        onPrimary: colorSchemaLight['onPrimary'],
        secondary: colorSchemaLight['secondary'],
        tertiary: colorSchemaLight['tertiary'],
        tertiaryContainer: colorSchemaLight['tertiaryContainer'],
        onTertiaryContainer: colorSchemaLight['onTertiaryContainer'],
        onSecondary: colorSchemaLight['onSecondary'],
        surface: colorSchemaLight['surface'],
        background: colorSchemaLight['background'],
        onBackground: const Color.fromARGB(255, 0, 0, 0),
        primaryContainer: colorSchemaLight['primaryColor']!.withOpacity(.5),
      ),
  textTheme: ThemeData.light().textTheme.copyWith(
        displayLarge: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w600,
          color: colorSchemaLight['primaryColor'],
        ),
        displayMedium: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: colorSchemaLight['primaryColor'],
        ),
        displaySmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: colorSchemaLight['primaryColor'],
        ),
        bodyLarge: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black54,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: colorSchemaLight['primaryColor'],
        ),
        bodySmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: colorSchemaLight['primaryColor'],
        ),
        labelMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: colorSchemaLight['primaryColor'],
        ),
      ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    hintStyle: const TextStyle(
      fontSize: 16,
      fontFamily: 'poppins',
      fontWeight: FontWeight.w400,
      color: Colors.black38,
    ),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DefaultTheme.borderRadius),
        borderSide: const BorderSide(color: Color.fromRGBO(255, 115, 105, 1))),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DefaultTheme.borderRadius),
        borderSide: const BorderSide(color: Color.fromARGB(255, 255, 17, 0))),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DefaultTheme.borderRadius),
        borderSide: BorderSide(color: colorSchemaLight['disabledColor']!)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DefaultTheme.borderRadius)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DefaultTheme.borderRadius),
        borderSide: BorderSide(color: colorSchemaLight['disabledColor']!)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.all(DefaultTheme.padding * .5),
        minimumSize: const Size(double.infinity, DefaultTheme.hightbtn),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DefaultTheme.borderRadius),
        ),
        backgroundColor: colorSchemaLight['secondary']),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    elevation: 0,
    padding: const EdgeInsets.all(DefaultTheme.padding * .5),
    minimumSize: const Size(double.infinity, DefaultTheme.hightbtn),
    side: BorderSide(color: colorSchemaLight['primaryColor']!),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(DefaultTheme.borderRadius),
    ),
  )),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
    selectedItemColor: colorSchemaLight['secondary'],
    unselectedItemColor: colorSchemaLight['primaryColor'],
    unselectedIconTheme: IconThemeData(color: colorSchemaLight['primaryColor']),
    selectedIconTheme: IconThemeData(color: colorSchemaLight['secondary']),
    backgroundColor: colorSchemaLight['primaryColor']!.withOpacity(.1),
  ),
);

const colorSchemaDark = {
  'primaryColor': Color.fromRGBO(224, 235, 255, 1),
  'onPrimary': Color.fromRGBO(33, 33, 33, 1),
  'secondary': Color.fromRGBO(254, 55, 96, 1),
  'onSecondary': Color.fromRGBO(255, 255, 255, 1),
  'tertiary': Color.fromRGBO(44, 181, 125, 1),
  'disabledColor': Color.fromRGBO(206, 206, 206, 1),
  'background': Color.fromRGBO(0, 0, 0, 1),
  'onBackground': Color.fromRGBO(255, 255, 255, 1),
  'tertiaryContainer': Color.fromRGBO(0, 236, 200, 1),
  'onTertiaryContainer': Color.fromRGBO(1, 17, 45, 1),
  'surface': Color.fromRGBO(1, 17, 45, 1),
};
final themeDark = ThemeData(
  appBarTheme: AppBarTheme(
    centerTitle: true,
    backgroundColor: colorSchemaDark['surface'],
    systemOverlayStyle: const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
    titleTextStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18,
      fontWeight: FontWeight.w600,
      color: colorSchemaDark['primaryColor'],
    ),
  ),
  useMaterial3: true,
  navigationBarTheme:
      NavigationBarThemeData(backgroundColor: colorSchemaDark['background']),
  fontFamily: 'Poppins',
  splashColor: Colors.black12,
  brightness: Brightness.dark,
  primaryColor: colorSchemaDark['primaryColor']!.withOpacity(.5),
  primaryColorLight: colorSchemaDark['primaryColor']!.withOpacity(.5),
  primaryColorDark: colorSchemaDark['primaryColor']!.withOpacity(.5),
  colorScheme: ThemeData.dark().colorScheme.copyWith(
        primary: colorSchemaDark['primaryColor'],
        onPrimary: colorSchemaDark['onPrimary'],
        secondary: colorSchemaDark['secondary'],
        tertiary: colorSchemaDark['tertiary'],
        tertiaryContainer: colorSchemaDark['tertiaryContainer'],
        onTertiaryContainer: colorSchemaDark['onTertiaryContainer'],
        surface: colorSchemaDark['surface'],
        onSecondary: colorSchemaDark['onSecondary'],
        background: colorSchemaDark['background'],
        onBackground: colorSchemaDark['onBackground'],
        primaryContainer: colorSchemaDark['primaryColor']!.withOpacity(.5),
      ),
  textTheme: ThemeData.dark().textTheme.copyWith(
        displayLarge: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.w600,
          color: colorSchemaDark['primaryColor'],
        ),
        displayMedium: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: colorSchemaDark['primaryColor'],
        ),
        displaySmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: colorSchemaDark['primaryColor'],
        ),
        bodyLarge: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(255, 230, 230, 230),
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: colorSchemaDark['primaryColor'],
        ),
        bodySmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: colorSchemaDark['primaryColor'],
        ),
        labelMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: colorSchemaDark['primaryColor'],
        ),
      ),
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    hintStyle: const TextStyle(
      fontSize: 16,
      fontFamily: 'poppins',
      fontWeight: FontWeight.w400,
      color: Color.fromARGB(255, 217, 217, 217),
    ),
    errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DefaultTheme.borderRadius),
        borderSide: const BorderSide(color: Color.fromRGBO(255, 115, 105, 1))),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DefaultTheme.borderRadius),
        borderSide: const BorderSide(color: Color.fromARGB(255, 255, 17, 0))),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DefaultTheme.borderRadius),
        borderSide: BorderSide(color: colorSchemaDark['disabledColor']!)),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DefaultTheme.borderRadius),
        borderSide: BorderSide(color: colorSchemaDark['primaryColor']!)),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DefaultTheme.borderRadius),
        borderSide: BorderSide(color: colorSchemaDark['disabledColor']!)),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: const EdgeInsets.all(DefaultTheme.padding * .5),
        minimumSize: const Size(double.infinity, DefaultTheme.hightbtn),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DefaultTheme.borderRadius),
        ),
        backgroundColor: colorSchemaDark['secondary']),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
    elevation: 0,
    padding: const EdgeInsets.all(DefaultTheme.padding * .5),
    minimumSize: const Size(double.infinity, DefaultTheme.hightbtn),
    side: BorderSide(color: colorSchemaDark['primaryColor']!),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(DefaultTheme.borderRadius),
    ),
  )),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 0,
    selectedItemColor: colorSchemaDark['secondary'],
    unselectedItemColor: colorSchemaDark['primaryColor'],
    unselectedIconTheme: IconThemeData(color: colorSchemaDark['primaryColor']),
    selectedIconTheme: IconThemeData(color: colorSchemaDark['secondary']),
    backgroundColor: colorSchemaDark['surface'],
  ),
);
