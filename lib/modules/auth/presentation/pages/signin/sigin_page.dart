import 'package:flutter/material.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/presentation/theme.dart';
import 'package:vocabulario_dev/modules/common/widgets/input_wrapper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vocabulario_dev/utils/email_is_valid.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});
  static String path = '/auth/sigin';


  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
            // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            //   final scaffolMessageInstance = ScaffoldMessenger.of(context);
            //   final error = SnackBar(
            //     content: Text(controller.error!,
            //         style: const TextStyle(color: Colors.white)),
            //     backgroundColor: Colors.red,
            //   );
            //   scaffolMessageInstance.showSnackBar(error);
            // });
    return Scaffold(
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
    );
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
    if (_formKey.currentState!.validate()) {
    }
  }

  @override
  Widget build(BuildContext context) {
    // final controller = context.read<SigninController>();
    final localization = AppLocalizations.of(context)!;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          InputWrapper(
            // initialValue: controller.form['firstName'],
            label: localization.sigin_page_form_firstname_label,
            placeHolder: localization.sigin_page_form_firstname_placeholder,
            textInputAction: TextInputAction.next,
            // onChange: (value) => controller.onChange('firstName', value),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'First name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: DefaultTheme.gap),
          InputWrapper(
            // initialValue: controller.form['lastName'],
            label: localization.sigin_page_form_lastname_label,
            placeHolder: localization.sigin_page_form_lastname_placeholder,
            textInputAction: TextInputAction.next,
            // onChange: (value) => controller.onChange('lastName', value),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Last name is required';
              }
              return null;
            },
          ),
          const SizedBox(height: DefaultTheme.gap),
          InputWrapper(
            // initialValue: controller.form['email'],
            label: localization.sigin_page_form_email_label,
            placeHolder: localization.sigin_page_form_email_placeholder,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            // onChange: (value) => controller.onChange('email', value),
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
            // initialValue: controller.form['password'],
            label: localization.sigin_page_form_password_label,
            placeHolder: localization.sigin_page_form_password_placeholder,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.visiblePassword,
            // onChange: (value) => controller.onChange('password', value),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Password is required';
              }
              return null;
            },
          ),
          const SizedBox(height: DefaultTheme.gap),
          InputWrapper(
            // initialValue: controller.form['passwordConfirmation'],
            label: localization.sigin_page_form_passwordconfirmation_label,
            placeHolder:
                localization.sigin_page_form_passwordconfirmation_placeholder,
            keyboardType: TextInputType.visiblePassword,
            onEditingComplete: sendForm,
            // onChange: (value) =>
            //     controller.onChange('passwordConfirmation', value),
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
