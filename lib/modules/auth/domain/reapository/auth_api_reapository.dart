import 'package:vocabulario_dev/modules/auth/domain/request/login_request.dart';
import 'package:vocabulario_dev/modules/auth/domain/response/signin_request.dart';
import 'package:vocabulario_dev/modules/auth/domain/response/login_response.dart';

abstract class AuthApiReapositoryInterface {
  Future<LoginResponse> refreshSesion(String token);
  Future<LoginResponse> login(LoginRequest loginData);
  Future<LoginResponse> signin(SignInRequest signinData);
  Future<void> logout(String token);
}
