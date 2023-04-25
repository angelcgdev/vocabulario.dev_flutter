import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:provider/provider.dart';
import 'package:vocabulario_dev/data/datasource/sections_api_reapository_impl.dart';
import 'package:vocabulario_dev/domain/repository/request_service_reapository.dart';
import 'package:vocabulario_dev/domain/repository/sections_api_reapository.dart';
import 'package:vocabulario_dev/domain/repository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/ui/pages/home/widgets/profile_tab/profile_tab.dart';
import 'package:vocabulario_dev/ui/pages/home/widgets/reports_tab/reports_tab.dart';
import 'package:vocabulario_dev/ui/pages/home/widgets/sections_tab/sections_tab.dart';
import 'package:vocabulario_dev/ui/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  static String path = '/home';
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _controller;
  int index = 0;

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3)
      ..addListener(() {
        setState(() {
          index = _controller.index;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    _controller.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<SectionsApiReapositoryInterface>(
          create: (_) => SectionsApiReapositoryImpl(
              requestService: context.read<RequestServiceRepositoryInterface>(),
              userInfosecureStorage:
                  context.read<UserInfoStorageReapositoryInterface>()),
        ),
      ],
      child: Builder(
        builder: (context) {
          return AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
                systemNavigationBarColor:
                    Theme.of(context).colorScheme.surface),
            child: Scaffold(
              body: SafeArea(
                child: TabBarView(
                  controller: _controller,
                  children: [
                    SectionsTab.init(context),
                    ReportsTab.init(context),
                    ProfileTab.init(context)
                  ],
                ),
              ),
              bottomNavigationBar: _MyCustomBar(
                index: index,
                onTap: _onItemTapped,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MyCustomBar extends StatelessWidget {
  const _MyCustomBar({
    required this.index,
    required this.onTap,
  });
  final int index;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    const tabBarHeight = 70.0;
    const fontSize = 13.0;
    const iconSize = 17.0;
    final localization = AppLocalizations.of(context)!;
    return SizedBox(
      height: tabBarHeight,
      child: BottomNavigationBar(
        currentIndex: index,
        onTap: onTap,
        selectedFontSize: fontSize,
        unselectedFontSize: fontSize,
        iconSize: iconSize,
        items: [
          BottomNavigationBarItem(
            icon: const Padding(
              padding: EdgeInsets.only(bottom: DefaultTheme.gap * .5),
              child: Icon(FeatherIcons.home),
            ),
            label: localization.home_page_tab_inicio_name,
          ),
          BottomNavigationBarItem(
            icon: const Padding(
              padding: EdgeInsets.only(bottom: DefaultTheme.gap * .5),
              child: Icon(FeatherIcons.activity),
            ),
            label: localization.home_page_tab_report_name,
          ),
          BottomNavigationBarItem(
            icon: const Padding(
              padding: EdgeInsets.only(bottom: DefaultTheme.gap * .5),
              child: Icon(FeatherIcons.user),
            ),
            label: localization.home_page_tab_profile_name,
          ),
        ],
      ),
    );
  }
}
