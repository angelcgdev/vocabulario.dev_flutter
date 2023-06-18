import 'package:flutter/material.dart';
import 'package:vocabulario_dev/modules/auth/domain/model/user.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/auth_api_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/routes/routes.dart';

class MainController extends ChangeNotifier {
  final UserInfoStorageReapositoryInterface _userInfo;
  final AuthApiReapositoryInterface _loginApiReapositoryInterface;
  MainController(
      {required UserInfoStorageReapositoryInterface userInfo,
      required AuthApiReapositoryInterface loginApi})
      : _loginApiReapositoryInterface = loginApi,
        _userInfo = userInfo;
  bool _allowPrivateRoutes = false;
  bool _isChecking = false;
  ThemeMode _themeMode = ThemeMode.system;
  User? _user;

  ThemeMode get themeMode => _themeMode;
  set themeMode(ThemeMode value) {
    _themeMode = value;
    notifyListeners();
  }

  bool get allowPrivateRoutes => _allowPrivateRoutes;
  set allowPrivateRoutes(value) {
    _allowPrivateRoutes = value;
    notifyListeners();
  }

  bool get isChecking => _isChecking;
  User? get user => _user;

  checkLogin() async {
    final token = await _userInfo.getToken();
    if (token == null) {
      _allowPrivateRoutes = false;
      notifyListeners();
      return;
    }
    _isChecking = true;
    notifyListeners();
    try {
      final request =
          (await _loginApiReapositoryInterface.refreshSesion(token));
      await _userInfo.saveToken(request.token);
      await _userInfo.saveUser(request.user);
      _allowPrivateRoutes = true;
      notifyListeners();
    } catch (e) {
      _allowPrivateRoutes = false;
      notifyListeners();
      debugPrint('$e');
    } finally {
      _isChecking = false;
      notifyListeners();
    }
  }

  getRoutes(BuildContext context, bool allowPrivateRoutes) {
    return routes(context, allowPrivateRoutes);
  }
}
