import 'package:flutter/material.dart';
import 'package:vocabulario_dev/modules/common/domain/reapository/secure_storage_reapository.dart';

class ThemeLocalDataSrc {
  final SecureStorageReapositoryInterface _storageReapository;
  final String _themeModeKey = 'thememode';
  ThemeLocalDataSrc({required SecureStorageReapositoryInterface storage}) : _storageReapository = storage;

  Future<void> setThemeMode(ThemeMode mode) async{
    await _storageReapository.write(_themeModeKey, mode.toString());
  }

  Future<ThemeMode?> getThemeMode() async {
    final themeModeAsString = await _storageReapository.read(_themeModeKey);
    if(themeModeAsString==null)return null;
    return ThemeMode.values.firstWhere((element) => element.toString()==themeModeAsString);
  }

}