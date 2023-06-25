import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:vocabulario_dev/modules/auth/presentation/pages/splash/splash_page.dart';
import 'package:vocabulario_dev/modules/home/modules/definition_report/presentation/pages/definition_report_page.dart';
import 'package:vocabulario_dev/modules/home/presentation/pages/home_page.dart';
import 'package:vocabulario_dev/modules/home/presentation/pages/lesson/lesson_page.dart';
import 'package:vocabulario_dev/modules/login/presentation/pages/login_page.dart';
import 'package:vocabulario_dev/modules/home/presentation/pages/random/random_page.dart';
import 'package:vocabulario_dev/modules/auth/presentation/pages/signin/sigin_page.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/presentation/pages/theme_page.dart';

class ConditionalRouter extends MapMixin<String, WidgetBuilder> {
  final Map<String, WidgetBuilder> public;
  final Map<String, WidgetBuilder> private;
  final bool isUserLoggedIn;

  ConditionalRouter(
      {required this.public,
      required this.private,
      required this.isUserLoggedIn});

  @override
  WidgetBuilder? operator [](Object? key) {
    if (public.containsKey(key)) return public[key];
    if (private.containsKey(key)) {
      if (isUserLoggedIn) return private[key];
      return (context) => const LoginPage();
    }
    return null;
  }

  @override
  void operator []=(key, value) {}

  @override
  void clear() {}

  @override
  Iterable<String> get keys {
    final set = <String>{};
    set.addAll(public.keys);
    set.addAll(private.keys);
    return set;
  }

  @override
  WidgetBuilder? remove(Object? key) {
    return public[key] ?? private[key];
  }
}

Map<String, WidgetBuilder> routes({required BuildContext context,required bool isUserAuthenticated}) {
  return ConditionalRouter(
    isUserLoggedIn: isUserAuthenticated,
    private: {
      HomePage.path: (context) => const HomePage(),
      RandomPage.path: (context) => const RandomPage(),
      LessonPage.path: (context) => LessonPage.init(context),
      ThemePage.path: (context) => const ThemePage(),
      DefinitionReportPage.path: (context) => const DefinitionReportPage(),
    },
    public: {
      SignInPage.path: (context) => const SignInPage(),
      LoginPage.path: (context) => const LoginPage(),
      SplashPage.path: (context) => const SplashPage(),
    }
  );
}
