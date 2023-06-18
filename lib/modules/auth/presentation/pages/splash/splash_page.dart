import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulario_dev/main_controller.dart';
import 'package:vocabulario_dev/modules/home/presentation/pages/home_page.dart';
import 'package:vocabulario_dev/modules/auth/presentation/pages/login/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  late MainController controller;
  void _init() {
    controller = context.read<MainController>();
    controller.addListener(manageRedirect);
  }

  void manageRedirect() {
    final isUserLoggedIn = controller.allowPrivateRoutes;
    final checking = controller.isChecking;
    final navigator = Navigator.of(context);
    if (checking) return;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(
        const Duration(milliseconds: 1),
      );
      if (isUserLoggedIn && context.mounted) {
        navigator.pushReplacementNamed(HomePage.path);
      } else {
        navigator.pushReplacementNamed(LoginPage.path);
      }
    });
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(manageRedirect);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text(
            'Logo',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
