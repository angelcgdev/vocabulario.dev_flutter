import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulario_dev/modules/auth/aplication/login_bloc.dart';
import 'package:vocabulario_dev/modules/auth/aplication/login_event.dart';
import 'package:vocabulario_dev/modules/auth/aplication/login_state.dart';
import 'package:vocabulario_dev/modules/auth/presentation/pages/login/login_page.dart';
import 'package:vocabulario_dev/modules/home/presentation/pages/home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context, listen: false);
    loginBloc.add(LoginCheckSesionStarted());
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        print(state);
        if(state is! LoginCheckSesionSuccess)return;
        if(state.user!=null){
          Navigator.of(context).pushReplacementNamed(LoginPage.path);
        }else{
          Navigator.of(context).pushReplacementNamed(HomePage.path);
        }
      },
      child: const Scaffold(
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
