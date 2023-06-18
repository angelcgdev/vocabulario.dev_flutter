import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/auth_api_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/main_controller.dart';
import 'package:vocabulario_dev/modules/home/presentation/pages/home_page.dart';
import 'package:vocabulario_dev/modules/auth/presentation/pages/signin/signin_controller.dart';
import 'package:vocabulario_dev/modules/common/widgets/loading_layout.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/presentation/theme.dart';
import 'package:vocabulario_dev/modules/common/widgets/input_wrapper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vocabulario_dev/utils/email_is_valid.dart';

class SignInPage extends StatelessWidget {
  const SignInPage._();
  static String path = '/auth/sigin';

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SigninController(
          authService: context.read<AuthApiReapositoryInterface>(),
          userInfo: context.read<UserInfoStorageReapositoryInterface>()),
      builder: (_, __) => const SignInPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Selector<SigninController, bool>(
        selector: (_, controller) => controller.isLoadingSignIn,
        shouldRebuild: (prev, next) {
          final controller = context.read<SigninController>();
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
        },
        builder: (context, isLoadingSignIn, _) {
          return LoadingLayout(
            isLoading: isLoadingSignIn,
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
                                localization.sigin_page_title,
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                              const SizedBox(height: 20),
                              const _SigInForm(),
                              const SizedBox(height: 20),
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

class _SigInForm extends StatefulWidget {
  // ignore: unused_element
  const _SigInForm({super.key});

  @override
  State<_SigInForm> createState() => _SigInFormState();
}

class _SigInFormState extends State<_SigInForm> {
  final _formKey = GlobalKey<FormState>();
  Map<String, String> form = {};
  sendForm() async {
    final navigator = Navigator.of(context);
    if (_formKey.currentState!.validate()) {
      final mainController = context.read<MainController>();
      final controller = context.read<SigninController>();
      controller.isLoadingSignIn = true;
      final signInCompleted = await controller.signin();
      if (signInCompleted) {
        mainController.allowPrivateRoutes = true;
        await Future.delayed(const Duration(milliseconds: 100));
        navigator.pushNamedAndRemoveUntil(HomePage.path, (route) => false);
      }
      controller.isLoadingSignIn = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SigninController>();
    final localization = AppLocalizations.of(context)!;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          InputWrapper(
            initialValue: controller.form['firstName'],
            label: localization.sigin_page_form_firstname_label,
            placeHolder: localization.sigin_page_form_firstname_placeholder,
            textInputAction: TextInputAction.next,
            onChange: (value) => controller.onChange('firstName', value),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'First name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: DefaultTheme.gap),
          InputWrapper(
            initialValue: controller.form['lastName'],
            label: localization.sigin_page_form_lastname_label,
            placeHolder: localization.sigin_page_form_lastname_placeholder,
            textInputAction: TextInputAction.next,
            onChange: (value) => controller.onChange('lastName', value),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Last name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: DefaultTheme.gap),
          InputWrapper(
            initialValue: controller.form['email'],
            label: localization.sigin_page_form_email_label,
            placeHolder: localization.sigin_page_form_email_placeholder,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            onChange: (value) => controller.onChange('email', value),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Email is required';
              }
              if (!emailIsValid(value)) {
                return 'Email entered is invalid';
              }
              return null;
            },
          ),
          const SizedBox(height: DefaultTheme.gap),
          InputWrapper(
            initialValue: controller.form['password'],
            label: localization.sigin_page_form_password_label,
            placeHolder: localization.sigin_page_form_password_placeholder,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.visiblePassword,
            onChange: (value) => controller.onChange('password', value),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Password is required';
              }
              return null;
            },
          ),
          const SizedBox(height: DefaultTheme.gap),
          InputWrapper(
            initialValue: controller.form['passwordConfirmation'],
            label: localization.sigin_page_form_passwordconfirmation_label,
            placeHolder:
                localization.sigin_page_form_passwordconfirmation_placeholder,
            keyboardType: TextInputType.visiblePassword,
            onEditingComplete: sendForm,
            onChange: (value) =>
                controller.onChange('passwordConfirmation', value),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Password is required';
              }
              return null;
            },
          ),
          const SizedBox(height: DefaultTheme.gap * 1.5),
          ElevatedButton(
              onPressed: sendForm,
              child: Text(localization.sigin_page_form_continue_btn)),
        ],
      ),
    );
  }
}
