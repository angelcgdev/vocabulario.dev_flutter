import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulario_dev/modules/auth/aplication/auth_bloc.dart';
import 'package:vocabulario_dev/modules/auth/domain/model/auth_status.dart';
import 'package:vocabulario_dev/modules/login/presentation/pages/login_page.dart';
import 'package:vocabulario_dev/modules/home/presentation/pages/home_page.dart';

class AuthNavigatorManager extends StatelessWidget {
  const AuthNavigatorManager({super.key, required this.child});
  final Widget child;
  static const redirectionDelay = 50;
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listenWhen: (previous, current) => current.status == AuthStatus.authenticated || current.status == AuthStatus.unauthenticated,
      listener: (context, state) async{
        final ownNavigator = Navigator.of(context);
        await Future.delayed(const Duration(milliseconds: redirectionDelay));
        switch (state.status){
          case AuthStatus.authenticated:
            ownNavigator.pushNamedAndRemoveUntil(HomePage.path, (route) => false);
            break;
          case AuthStatus.unauthenticated:
            ownNavigator.pushNamedAndRemoveUntil(LoginPage.path, (route) => false);
            break;
          default:
            break;
        }
      }, 
      child: child,
    );
  }
}