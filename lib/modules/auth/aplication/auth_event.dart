part of 'auth_bloc.dart';
abstract class AuthEvent {}

class AuthSesinStatusChecked extends AuthEvent {}

class AuthLogoutRequest extends AuthEvent {}
