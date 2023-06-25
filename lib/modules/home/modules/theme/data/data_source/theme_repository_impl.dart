import 'package:flutter/material.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/data/data_source/local/theme_local_data_src.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/reapository/theme_reapository.dart';

class ThemeReapositoryImpl implements ThemeReapositoryInterface {
  final ThemeLocalDataSrc _themeDataSource;
  ThemeReapositoryImpl({required ThemeLocalDataSrc themeDataSource}) : _themeDataSource = themeDataSource;
  @override
  Future<ThemeMode?> getThemeMode() {
    return _themeDataSource.getThemeMode();
  }

  @override
  Future<void> setThemeMode(ThemeMode mode) {
    return _themeDataSource.setThemeMode(mode);
  }

}