import 'package:flutter/foundation.dart';
import 'package:vocabulario_dev/data/datasource/exceptions/auth_exception.dart';
import 'package:vocabulario_dev/domain/repository/auth_api_reapository.dart';
import 'package:vocabulario_dev/domain/repository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/domain/request/signin_request.dart';

class SigninController extends ChangeNotifier {
  final AuthApiReapositoryInterface _authService;
  final UserInfoStorageReapositoryInterface _userInfo;
  SigninController(
      {required AuthApiReapositoryInterface authService,
      required UserInfoStorageReapositoryInterface userInfo})
      : _authService = authService,
        _userInfo = userInfo;

  String? _error;
  String? get error => _error;
  bool _loadignSignIn = false;
  bool get isLoadingSignIn => _loadignSignIn;
  set isLoadingSignIn(value) {
    _loadignSignIn = value;
    notifyListeners();
  }

  final Map<String, String> _form = {};
  Map<String, String> get form => _form;
  Future<bool> signin() async {
    try {
      _error = null;
      notifyListeners();
      final request = await _authService.signin(SignInRequest.fromJson(_form));
      _userInfo.saveToken(request.token);
      _userInfo.saveUser(request.user);
      return true;
    } on AuthException catch (e) {
      _error = e.cause;
      notifyListeners();
      return false;
    }
  }

  void onChange(String field, String value) {
    _form[field] = value;
  }
}
