import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:vocabulario_dev/modules/auth/data/data_source/auth_api_reapository_impl.dart';
import 'package:vocabulario_dev/modules/auth/presentation/widgets/with_presentation_dependecies.dart';
import 'package:vocabulario_dev/modules/common/presentation/with_data_soure_dependencies.dart';
import 'package:vocabulario_dev/modules/home/data/data_source/reports_service_reapository_impl.dart';
import 'package:vocabulario_dev/modules/home/data/data_source/terms_api_reapository_impl.dart';
import 'package:vocabulario_dev/modules/auth/data/data_source/userinfo_storage_reapository_impl.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/auth_api_reapository.dart';
import 'package:vocabulario_dev/modules/home/domain/reapository/reports_api_reapository.dart';
import 'package:vocabulario_dev/modules/common/domain/reapository/request_service_reapository.dart';
import 'package:vocabulario_dev/modules/common/domain/reapository/secure_storage_reapository.dart';
import 'package:vocabulario_dev/modules/home/domain/reapository/terms_api_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/main_controller.dart';
import 'package:vocabulario_dev/modules/auth/presentation/pages/splash/splash_page.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/presentation/theme.dart';
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
        return WithPresentationDependencies(
          builder: (context) {
            return Main.init(context);
          }
        );
      },
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
        final systemUiColorLight = SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent
        );
        final systemUiColorDark = SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Colors.transparent
        );
        final brightness = Theme.of(context).brightness;
        final systemUiColor = brightness==Brightness.dark?systemUiColorDark:systemUiColorLight;
        return AnnotatedRegion<SystemUiOverlayStyle>(
            value: systemUiColor,
            child: child!
        );
      },
    );
  }
}
