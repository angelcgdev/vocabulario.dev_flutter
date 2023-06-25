import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulario_dev/modules/auth/data/exceptions/auth_exception.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/auth_api_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/request/login_request.dart';
import 'package:vocabulario_dev/modules/login/domain/models/models.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  final AuthApiReapositoryInterface _authReapository;
  final UserInfoStorageReapositoryInterface _userReapository;
  LoginBloc({ required AuthApiReapositoryInterface authReapository, required UserInfoStorageReapositoryInterface userReapository}): _userReapository = userReapository, _authReapository = authReapository,super(const LoginState()){
    
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
  }


  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final email = Email(event.email);
    emit(
      state.copyWith(
        email: email,
        passwordError: email.validator()
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password(event.password);
    emit(
      state.copyWith(
        password: password,
        passwordError: password.validator()
      ),
    );
  }


  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.emailError.isEmpty && state.emailError.isEmpty) {
      emit(state.copyWith(formStatus: FormSubmissionStatus.inProgress));
      try {
        final authResponse = await _authReapository.login(LoginRequest(state.email.value, state.password.value));
        await _userReapository.saveToken(authResponse.token);
        await _userReapository.saveUser(authResponse.user);
        emit(state.copyWith(formStatus: FormSubmissionStatus.success));
      } on AuthException catch (e) {
        emit(state.copyWith(formStatus: FormSubmissionStatus.failure(e.cause)));
      }
    }
  }

}
