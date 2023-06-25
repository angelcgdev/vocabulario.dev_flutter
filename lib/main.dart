import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vocabulario_dev/modules/auth/aplication/auth_bloc.dart';
import 'package:vocabulario_dev/modules/auth/domain/model/auth_status.dart';
import 'package:vocabulario_dev/modules/auth/presentation/widgets/with_auth_dependecies.dart';
import 'package:vocabulario_dev/modules/common/presentation/with_data_soure_dependencies.dart';
import 'package:vocabulario_dev/modules/auth/presentation/pages/splash/splash_page.dart';
import 'package:vocabulario_dev/modules/common/widgets/loading_layout.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/aplication/theme_bloc.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/presentation/theme.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/presentation/widgets/with_theme_dependencies.dart';
import 'package:vocabulario_dev/routes/routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return WithBasicDataSourceDependencies(
      builder: (context) {
        return WithThemeDependencies(
          builder: (context) {
            return WithAuthDependencies(
              builder: (context) => const Main(),
            );
          },
        );
      },
    );
  }
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (previous, current) {
        return current.status == AuthStatus.unauthenticated ||
            current.status == AuthStatus.authenticated;
      },
      builder: (context, authState) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          buildWhen: (previous, current) => previous.themeMode!=current.themeMode,
          builder: (context, themeState) {
            return MaterialApp(
              title: 'Vocabulario.dev',
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              theme: themeLight,
              darkTheme: themeDark,
              routes: routes(
                context: context,
                isUserAuthenticated: authState.status == AuthStatus.authenticated,
              ),
              themeMode: themeState.themeMode,
              initialRoute: SplashPage.path,
              builder: (context, child) {
                final brightness = Theme.of(context).brightness;
                final systemUiColor = brightness == Brightness.dark
                    ? systemUiColorDark
                    : systemUiColorLight;
                return AnnotatedRegion<SystemUiOverlayStyle>(
                  value: systemUiColor,
                  child: LoadingOverlay(child: child!),
                );
              },
            );
          }
        );
      },
    );
  }
}
