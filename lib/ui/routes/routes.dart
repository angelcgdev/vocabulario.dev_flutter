import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:vocabulario_dev/ui/pages/home/home.dart';
import 'package:vocabulario_dev/ui/pages/lesson/lesson.dart';
import 'package:vocabulario_dev/ui/pages/login/login_page.dart';
import 'package:vocabulario_dev/ui/pages/random/random_page.dart';
import 'package:vocabulario_dev/ui/pages/signin/sigin_page.dart';
import 'package:vocabulario_dev/ui/pages/theme.dart';

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
      return (context) => LoginPage.init(context);
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

Map<String, WidgetBuilder> routes(BuildContext context, bool isUserLoggedIn) {
  return ConditionalRouter(isUserLoggedIn: isUserLoggedIn, private: {
    HomePage.path: (context) => const HomePage(),
    RandomPage.path: (context) => const RandomPage(),
    LessonPage.path: (context) => LessonPage.init(context),
    ThemePage.path: (context) => const ThemePage(),
  }, public: {
    SignInPage.path: (context) => SignInPage.init(context),
    LoginPage.path: (context) => LoginPage.init(context),
  });
}
