part of 'theme_bloc.dart';

abstract class ThemeEvent {}

class ThemeStarted extends ThemeEvent {}
class ThemeModeChoosed extends ThemeEvent {
  ThemeMode themeMode;
  ThemeModeChoosed(this.themeMode);
}