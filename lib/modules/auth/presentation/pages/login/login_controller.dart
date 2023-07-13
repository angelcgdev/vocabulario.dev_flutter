import 'package:flutter/material.dart';
import 'package:vocabulario_dev/modules/auth/data/exceptions/auth_exception.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/auth_api_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/request/login_request.dart';

// class LoginController extends ChangeNotifier {
//   final UserInfoStorageReapositoryInterface _userInfoStorage;
//   final AuthApiReapositoryInterface _authService;
//   LoginController(
//       {required UserInfoStorageReapositoryInterface
//           secureStorageReapositoryInterface,
//       required AuthApiReapositoryInterface apiReapositoryInterface})
//       : _authService = apiReapositoryInterface,
//         _userInfoStorage = secureStorageReapositoryInterface;
//   final Map<String, String> _form = {};
//   Map<String, String> get form => _form;
//   bool _isLoadingSession = false;
//   String? _error;
//   bool get isLoadingSession => _isLoadingSession;
//   set isLoadingSession(value) {
//     _isLoadingSession = value;
//     notifyListeners();
//   }

//   String? get error => _error;

//   Future<bool> login() async {
//     try {
//       _error = null;
//       notifyListeners();
//       final request = LoginRequest.fromJson(_form);
//       final response = await _authService.login(request);
//       _userInfoStorage.saveToken(response.token);
//       _userInfoStorage.saveUser(response.user);
//       return true;
//     } on AuthException catch (e) {
//       _error = e.cause;
//       notifyListeners();
//       return false;
//     }
//   }

//   void onChange(String field, String value) {
//     try {
//       _form.update(field, (prev) => value);
//     } catch (e) {
//       _form.addAll({field: value});
//     }
//   }
// }
