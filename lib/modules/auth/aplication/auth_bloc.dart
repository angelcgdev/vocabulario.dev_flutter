import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/auth_api_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/model/models.dart';
import 'package:vocabulario_dev/modules/auth/domain/response/login_response.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final AuthApiReapositoryInterface _authReapository;
  final UserInfoStorageReapositoryInterface _userInfoReapository;

  AuthBloc({
    required AuthApiReapositoryInterface authReapository,
    required UserInfoStorageReapositoryInterface userInfoReapository
  }): _authReapository = authReapository, _userInfoReapository = userInfoReapository,super(const AuthState.unknown()){

    on<AuthSesinStatusChecked>(_onAuthSesionStatusChecked);
    on<AuthLogoutRequest>(_onAuthLogoutRequest);

  }

  void _onAuthSesionStatusChecked(AuthSesinStatusChecked event, Emitter<AuthState> emit) async{
    emit(const AuthState.checking());
    final loginResponse = await _tryGetNewLoginResponse();
    if(loginResponse!=null){
      return emit(AuthState.authenticated(loginResponse.user));
    }
    return emit(const AuthState.unauthenticated());
  }

  void _onAuthLogoutRequest(AuthLogoutRequest event, Emitter<AuthState> emit) async{
    final token = await _userInfoReapository.getToken();
    if(token!= null){
      await _userInfoReapository.deleteToken();
      await _userInfoReapository.deleteUser();
      await _authReapository.logout(token);
      emit(const AuthState.unauthenticated());
    }
  }

  Future<LoginResponse?> _tryGetNewLoginResponse()async{
    try {
      final token = await _userInfoReapository.getToken();
      if(token==null)return null;
      final authresponse = await _authReapository.refreshSesion(token);
      await _userInfoReapository.saveToken(authresponse.token);
      await _userInfoReapository.saveUser(authresponse.user);
      return authresponse;
    } catch (e) {
      return null;
    }
  }
}

