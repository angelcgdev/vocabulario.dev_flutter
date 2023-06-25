import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulario_dev/modules/auth/aplication/auth_bloc.dart';
import 'package:vocabulario_dev/modules/auth/presentation/widgets/auth_navigation_manager.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/aplication/theme_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  static const String path = '/';
  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
    authBloc.add(AuthSesinStatusChecked());
    final themeBloc = BlocProvider.of<ThemeBloc>(context, listen: false);
    themeBloc.add(ThemeStarted());
    return const AuthNavigatorManager(
      child: Scaffold(
          body: SafeArea(
              child: Center(
                child: Text(
                  'Logo',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ),
    );
  }
}
