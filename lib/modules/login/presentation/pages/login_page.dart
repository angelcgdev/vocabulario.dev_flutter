import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:vocabulario_dev/modules/auth/aplication/auth_bloc.dart';
import 'package:vocabulario_dev/modules/auth/domain/model/auth_status.dart';
import 'package:vocabulario_dev/modules/auth/presentation/widgets/auth_navigation_manager.dart';
import 'package:vocabulario_dev/modules/common/widgets/loading_layout.dart';
import 'package:vocabulario_dev/modules/home/presentation/pages/home_page.dart';
import 'package:vocabulario_dev/modules/auth/presentation/pages/signin/sigin_page.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/presentation/theme.dart';
import 'package:vocabulario_dev/modules/common/widgets/input_wrapper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vocabulario_dev/modules/login/aplication/login_bloc.dart';
import 'package:vocabulario_dev/modules/login/presentation/widgets/with_login_dependencies.dart';
import 'package:vocabulario_dev/utils/email_is_valid.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static const path = '/auth/login';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final width = size.width;
    final height = size.height;
    final localization = AppLocalizations.of(context)!;
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
    return AuthNavigatorManager(
      child: WithLoginDependencies(
        builder: (context) {
          final scaffolMessageInstance = ScaffoldMessenger.of(context);
          final overlay = LoadingOverlay.of(context);
          return BlocListener<AuthBloc, AuthState>(
            listenWhen: (previous, current) {
              return previous.status == AuthStatus.checking || current.status==AuthStatus.checking;
            },
            listener: (context, state) async {
              if (state.status == AuthStatus.checking) {
                overlay.show();
              } else {
                scaffolMessageInstance.clearSnackBars();
                final duration = ModalRoute.of(context)?.transitionDuration.inMilliseconds??0;
                final redirectionDelay = (AuthNavigatorManager.redirectionDelay+duration);
                await Future.delayed(Duration(milliseconds: redirectionDelay));
                overlay.hide();
              }
            },
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state.formStatus.state == FormStatus.inProgress) {
                  overlay.show();
                }
                if (state.formStatus.state == FormStatus.failure) {
                  overlay.hide();
                  final error = SnackBar(
                    content: Text(state.formStatus.message,
                        style: TextStyle(color: theme.colorScheme.onError)),
                    backgroundColor: theme.colorScheme.error,
                  );
                  scaffolMessageInstance.showSnackBar(error);
                }
                if (state.formStatus.state == FormStatus.success) {
                  authBloc.add(AuthSesinStatusChecked());
                }
              },
              child: Scaffold(
                body: SafeArea(
                  child: Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(
                      minWidth: width,
                      minHeight: height,
                    ),
                    child: SingleChildScrollView(
                      child: Center(
                        child: Container(
                            constraints: const BoxConstraints(maxWidth: 500),
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                Text(
                                  localization.login_page_title,
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                ),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            HomePage.path, (_) => false);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(FeatherIcons.mail),
                                      const SizedBox(
                                        width: DefaultTheme.gap,
                                      ),
                                      Text(localization
                                          .login_page_title_signinwithgoogle),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 10),
                                const Divider(),
                                const SizedBox(height: 10),
                                const _LoginForm(),
                                const SizedBox(height: 20),
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    localization.login_page_forget_password,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                            decoration:
                                                TextDecoration.underline),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(SignInPage.path);
                                  },
                                  child: Text(localization.login_page_sigin),
                                ),
                                const SizedBox(height: 10),
                              ],
                            )),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final loginBloc = BlocProvider.of<LoginBloc>(context, listen: false);
    final localization = AppLocalizations.of(context)!;
    return Form(
      key: formKey,
      child: Column(
        children: [
          InputWrapper(
            // initialValue: _loginBloc.form['email'],
            label: localization.login_page_form_email_label,
            placeHolder: localization.login_page_form_email_placeholder,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            onChange: (value) => {loginBloc.add(LoginEmailChanged(value))},
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return localization.login_page_form_email_error_empty;
              }
              if (!emailIsValid(value)) {
                return localization.login_page_form_email_error_invalid;
              }
              return null;
            },
          ),
          const SizedBox(height: DefaultTheme.gap),
          InputWrapper(
            label: localization.login_page_form_password_label,
            placeHolder: localization.login_page_form_password_placeholder,
            keyboardType: TextInputType.visiblePassword,
            onEditingComplete: () {
              loginBloc.add(const LoginSubmitted());
            },
            onChange: (value) => {loginBloc.add(LoginPasswordChanged(value))},
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return localization.login_page_form_password_error_empty;
              }
              return null;
            },
          )
        ],
      ),
    );
  }
}
