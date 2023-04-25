import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:vocabulario_dev/data/datasource/auth_api_reapository_impl.dart';
import 'package:vocabulario_dev/data/datasource/reports_service_reapository_impl.dart';
import 'package:vocabulario_dev/data/datasource/request_service_reapository_impl.dart';
import 'package:vocabulario_dev/data/datasource/secure_storage_reapository_impl.dart';
import 'package:vocabulario_dev/data/datasource/terms_api_reapository_impl.dart';
import 'package:vocabulario_dev/data/datasource/userinfo_storage_reapository_impl.dart';
import 'package:vocabulario_dev/domain/repository/auth_api_reapository.dart';
import 'package:vocabulario_dev/domain/repository/reports_api_reapository.dart';
import 'package:vocabulario_dev/domain/repository/request_service_reapository.dart';
import 'package:vocabulario_dev/domain/repository/secure_storage_reapository.dart';
import 'package:vocabulario_dev/domain/repository/terms_api_reapository.dart';
import 'package:vocabulario_dev/domain/repository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/main_controller.dart';
import 'package:vocabulario_dev/ui/pages/splash/splash_page.dart';
import 'package:vocabulario_dev/ui/theme/theme.dart';
import 'package:vocabulario_dev/ui/routes/routes.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<RequestServiceRepositoryInterface>(
          create: (_) => RequestServiceReapositoryImpl(),
        ),
        Provider<SecureStorageReapositoryInterface>(
          create: (_) => SecureStorageReapositoryImpl(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return MultiProvider(
            providers: [
              Provider<AuthApiReapositoryInterface>(
                create: (_) => AuthApiReapositoryImpl(
                    requestService:
                        context.read<RequestServiceRepositoryInterface>()),
              ),
              Provider<UserInfoStorageReapositoryInterface>(
                create: (_) => UserInfoStorageReapositoryImpl(
                    secureStorage:
                        context.read<SecureStorageReapositoryInterface>()),
              ),
            ],
            child: Builder(builder: (context) {
              return Main.init(context);
            }),
          );
        },
      ),
    );
  }
}

class Main extends StatefulWidget {
  const Main._();

  static Widget init(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ReportsApiRepositoryInterface>(
          create: (_) => ReportsServiceReapositoryImpl(
            userInfo: context.read<UserInfoStorageReapositoryInterface>(),
            requestService: context.read<RequestServiceRepositoryInterface>(),
          ),
        ),
        Provider<TermsApiReapositoryInterface>(
          create: (_) => TermsApiReapositoryImpl(
            userInfo: UserInfoStorageReapositoryImpl(
              secureStorage: context.read<SecureStorageReapositoryInterface>(),
            ),
            requestService: context.read<RequestServiceRepositoryInterface>(),
          ),
        )
      ],
      child: ChangeNotifierProvider(
        create: (_) => MainController(
          loginApi: context.read<AuthApiReapositoryInterface>(),
          userInfo: context.read<UserInfoStorageReapositoryInterface>(),
        ),
        builder: (_, __) => const Main._(),
      ),
    );
  }

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  void _init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MainController>().checkLogin();
    });
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<MainController>();
    return MaterialApp(
      title: 'Vocabulario.dev',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: themeLight,
      darkTheme: themeDark,
      routes: routes(context, controller.allowPrivateRoutes),
      themeMode: controller.themeMode,
      home: const SplashPage(),
      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
                systemNavigationBarColor:
                    Theme.of(context).colorScheme.background),
            child: child!);
      },
    );
  }
}
