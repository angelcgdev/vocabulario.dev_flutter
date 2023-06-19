import 'package:vocabulario_dev/modules/auth/domain/model/user.dart';

abstract class LoginState {}

class LoginInitial extends LoginState {}
class LoginCheckSesionInProgress extends LoginState {}
class LoginCheckSesionSuccess extends LoginState {
  User? user;
  LoginCheckSesionSuccess({this.user});
}
class LoginCheckSesionFailure extends LoginState {}
