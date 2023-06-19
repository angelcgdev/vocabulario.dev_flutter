import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulario_dev/modules/auth/aplication/login_event.dart';
import 'package:vocabulario_dev/modules/auth/aplication/login_state.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/auth_api_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  AuthApiReapositoryInterface authReapository;
  UserInfoStorageReapositoryInterface userInfoReapository;

  LoginBloc({required LoginState initialState, required this.authReapository, required this.userInfoReapository}):super(initialState){
    on<LoginCheckSesionStarted>((event, emit) async{
      try {
        emit(LoginCheckSesionInProgress());
        final token = await userInfoReapository.getToken();
        if(token!=null){
          final authResponse = await authReapository.refreshSesion(token);
          print(authResponse);
          await userInfoReapository.saveToken(authResponse.token);
          await userInfoReapository.saveUser(authResponse.user);
          emit(LoginCheckSesionSuccess(user: authResponse.user));
        }else{
          emit(LoginCheckSesionSuccess());
        }
      } catch (e) {
        emit(LoginCheckSesionFailure());
      }
    });
  }

}