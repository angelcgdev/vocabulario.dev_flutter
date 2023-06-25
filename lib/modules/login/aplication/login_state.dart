part of 'login_bloc.dart';
enum FormStatus {
  initial,
  inProgress,
  success,
  failure,
}
class FormSubmissionStatus {
  final FormStatus state;
  final String message;
  const FormSubmissionStatus({required this.state, required this.message});

  static const initial = FormSubmissionStatus(state: FormStatus.initial, message: '');
  static const inProgress = FormSubmissionStatus(state: FormStatus.inProgress, message: '');
  static const success = FormSubmissionStatus(state: FormStatus.success, message: '');
  factory FormSubmissionStatus.failure(String message){
    return FormSubmissionStatus(state: FormStatus.failure, message: message);
  }
}
class LoginState extends Equatable {
  const LoginState({
    this.email = Email.pure,
    this.emailError = '',
    this.password = Password.pure,
    this.passwordError = '',
    this.formStatus = FormSubmissionStatus.initial,
  });

  final FormSubmissionStatus formStatus;
  final Email email;
  final String emailError;
  final Password password;
  final String passwordError;

  LoginState copyWith({
    FormSubmissionStatus formStatus = FormSubmissionStatus.initial,
    Email? email,
    String? emailError,
    Password? password,
    String? passwordError,
  }){
    return LoginState(
      email: email ?? this.email,
      emailError: emailError ?? this.emailError,
      password: password ?? this.password,
      passwordError: passwordError ?? this.passwordError,
      formStatus: formStatus,
    );
  }

  @override
  List<Object?> get props => [formStatus, email, password];
}