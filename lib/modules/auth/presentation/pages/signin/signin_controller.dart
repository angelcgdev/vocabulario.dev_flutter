import 'package:flutter/foundation.dart';
import 'package:vocabulario_dev/modules/auth/data/exceptions/auth_exception.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/auth_api_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/response/signin_request.dart';

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
