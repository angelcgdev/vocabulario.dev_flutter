import 'package:flutter/material.dart';

abstract class ThemeReapositoryInterface {
  Future<ThemeMode?> getThemeMode();
  Future<void> setThemeMode(ThemeMode mode);
}