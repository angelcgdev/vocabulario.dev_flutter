import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:provider/provider.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/auth_api_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/main_controller.dart';
import 'package:vocabulario_dev/modules/home/presentation/pages/home_page.dart';
import 'package:vocabulario_dev/modules/auth/presentation/pages/login/login_controller.dart';
import 'package:vocabulario_dev/modules/auth/presentation/pages/signin/sigin_page.dart';
import 'package:vocabulario_dev/modules/common/widgets/loading_layout.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/presentation/theme.dart';
import 'package:vocabulario_dev/modules/common/widgets/input_wrapper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vocabulario_dev/utils/email_is_valid.dart';

class LoginPage extends StatelessWidget {
  const LoginPage._();

  static String path = '/auth/login';

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginController(
          secureStorageReapositoryInterface:
              context.read<UserInfoStorageReapositoryInterface>(),
          apiReapositoryInterface: context.read<AuthApiReapositoryInterface>()),
      builder: (_, __) => const LoginPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final localization = AppLocalizations.of(context)!;
    return Selector<LoginController, bool>(selector: (_, controller) {
      return controller.isLoadingSession;
    }, shouldRebuild: (prev, next) {
      final controller = context.read<LoginController>();
      if (controller.error != null) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          final scaffolMessageInstance = ScaffoldMessenger.of(context);
          final error = SnackBar(
            content: Text(controller.error!,
                style: const TextStyle(color: Colors.white)),
            backgroundColor: Colors.red,
          );
          scaffolMessageInstance.showSnackBar(error);
        });
      }
      return prev != next;
    }, builder: (context, isLoadingSession, _) {
      return LoadingLayout(
        isLoading: isLoadingSession,
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
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                              onPressed: () => {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            HomePage.path, (_) => false)
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
                              )),
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
                                      decoration: TextDecoration.underline),
                            ),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(SignInPage.path);
                              },
                              child: Text(localization.login_page_sigin)),
                          const SizedBox(height: 10),
                        ],
                      )),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class _LoginForm extends StatefulWidget {
  // ignore: unused_element
  const _LoginForm({super.key});

  @override
  State<_LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<_LoginForm> {
  late LoginController _controller;
  final _formKey = GlobalKey<FormState>();
  sendForm() async {
    if (!_formKey.currentState!.validate()) return;
    final navigator = Navigator.of(context);
    final mainController = context.read<MainController>();
    _controller.isLoadingSession = true;
    final result = await _controller.login();
    if (result) {
      mainController.allowPrivateRoutes = result;
      await Future.delayed(const Duration(milliseconds: 100));
      navigator.pushNamedAndRemoveUntil(HomePage.path, (_) => false);
    }
    _controller.isLoadingSession = false;
  }

  @override
  void initState() {
    _controller = context.read<LoginController>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          InputWrapper(
            initialValue: _controller.form['email'],
            label: localization.login_page_form_email_label,
            placeHolder: localization.login_page_form_email_placeholder,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            onChange: (value) => _controller.onChange('email', value),
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
            onEditingComplete: sendForm,
            onChange: (value) => _controller.onChange('password', value),
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
