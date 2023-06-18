import 'package:flutter/material.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/auth_api_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';

class SplashController extends ChangeNotifier {
  final UserInfoStorageReapositoryInterface _userInfoStorage;
  final AuthApiReapositoryInterface _login;

  SplashController(
      {required UserInfoStorageReapositoryInterface
          userInfoStorageReapositoryInterface,
      required AuthApiReapositoryInterface loginReapositoryInterface})
      : _login = loginReapositoryInterface,
        _userInfoStorage = userInfoStorageReapositoryInterface;

  Future<bool> refreshSesion() async {
    final token = await _userInfoStorage.getToken();
    if (token == null) return false;
    try {
      final loginInfo = await _login.refreshSesion(token);
      await _userInfoStorage.saveUser(loginInfo.user);
      await _userInfoStorage.saveToken(loginInfo.token);
      return true;
    } catch (e) {
      return false;
    }
  }
}
