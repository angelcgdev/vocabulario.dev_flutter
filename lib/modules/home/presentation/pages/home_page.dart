import 'package:flutter/material.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:provider/provider.dart';
import 'package:vocabulario_dev/modules/auth/presentation/widgets/auth_navigation_manager.dart';
import 'package:vocabulario_dev/modules/common/widgets/responsive_wrapper.dart';
import 'package:vocabulario_dev/modules/home/data/data_source/sections_api_reapository_impl.dart';
import 'package:vocabulario_dev/modules/common/domain/reapository/request_service_reapository.dart';
import 'package:vocabulario_dev/modules/home/domain/reapository/sections_api_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/modules/home/modules/definition_report/presentation/widgets/with_reports_dependencies.dart';
import 'package:vocabulario_dev/modules/home/presentation/widgets/profile_tab/profile_tab.dart';
import 'package:vocabulario_dev/modules/home/modules/definition_report/presentation/widgets/reports_tab.dart';
import 'package:vocabulario_dev/modules/home/presentation/widgets/sections_tab/sections_tab.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/presentation/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vocabulario_dev/utils/responsive_property.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

  static const String path = '/home';
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
    return AuthNavigatorManager(
      child: MultiProvider(
        providers: [
          Provider<SectionsApiReapositoryInterface>(
            create: (_) => SectionsApiReapositoryImpl(
                requestService:
                    context.read<RequestServiceRepositoryInterface>(),
                userInfosecureStorage:
                    context.read<UserInfoStorageReapositoryInterface>()),
          ),
        ],
        child: Builder(
          builder: (context) {
            return ResponsiveWrapper(
              xs: Scaffold(
                body: TabBarView(
                  controller: _controller,
                  children: [
                    SectionsTab.init(context),
                    WithReportsDependencies(
                      builder: (context) => const ReportsTab(),
                    ),
                    ProfileTab.init(context)
                  ],
                ),
                bottomNavigationBar: _MyCustomBar(
                  index: index,
                  onTap: _onItemTapped,
                ),
              ),
              md: Scaffold(
                body: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: _MyCustomBarLg(
                        index: index,
                        onTap: _onItemTapped,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: TabBarView(
                        controller: _controller,
                        children: [
                          SectionsTab.init(context),
                          WithReportsDependencies(
                            builder: (context) => const ReportsTab(),
                          ),
                          ProfileTab.init(context)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
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
      height: tabBarHeight + MediaQuery.of(context).padding.bottom,
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
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

class _MyCustomBarLg extends StatelessWidget {
  const _MyCustomBarLg({
    required this.index,
    required this.onTap,
  });
  final int index;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(DefaultTheme.padding),
          alignment: Alignment.centerRight,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vocabulario.dev',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(
                  height: DefaultTheme.padding,
                ),
                Column(
                  children: [
                    _MyCustomBarItemLg(
                      index: 0,
                      currentIndex: index,
                      onTap: onTap,
                      icon: FeatherIcons.home,
                      label: localization.home_page_tab_inicio_name,
                    ),
                    const SizedBox(
                      height: DefaultTheme.gap * .5,
                    ),
                    _MyCustomBarItemLg(
                      index: 1,
                      currentIndex: index,
                      onTap: onTap,
                      icon: FeatherIcons.activity,
                      label: localization.home_page_tab_report_name,
                    ),
                    const SizedBox(
                      height: DefaultTheme.gap * .5,
                    ),
                    _MyCustomBarItemLg(
                      index: 2,
                      currentIndex: index,
                      onTap: onTap,
                      icon: FeatherIcons.user,
                      label: localization.home_page_tab_profile_name,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MyCustomBarItemLg extends StatelessWidget {
  const _MyCustomBarItemLg({
    required this.icon,
    required this.label,
    required this.index,
    required this.currentIndex,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final int index;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isActive = index == currentIndex;
    final activeColor = theme.colorScheme.secondary;
    final color = theme.colorScheme.primary;
    return InkWell(
      radius: 300,
      // splashFactory: InkRipple.splashFactory,
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DefaultTheme.borderRadius),
      ),
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: DefaultTheme.padding,
          vertical: DefaultTheme.padding * .5,
        ),
        decoration: BoxDecoration(
            // color: color.withOpacity(.01),
            borderRadius: BorderRadius.circular(DefaultTheme.borderRadius)),
        child: Row(
          children: [
            Icon(
              icon,
              color: isActive ? activeColor : color,
            ),
            SizedBox(
              width: ResponsiveProperty(
                width: MediaQuery.of(context).size.width,
                xs: DefaultTheme.gap,
                lg: DefaultTheme.gap * 1.5,
              ).value,
            ),
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isActive ? activeColor : color,
              ),
            )
          ],
        ),
      ),
    );
  }
}
