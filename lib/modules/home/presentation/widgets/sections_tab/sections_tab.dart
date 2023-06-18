import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:vocabulario_dev/modules/home/data/exceptions/section_exception.dart';
import 'package:vocabulario_dev/modules/home/domain/model/section.dart';
import 'package:vocabulario_dev/modules/home/domain/reapository/sections_api_reapository.dart';
import 'package:vocabulario_dev/modules/auth/domain/reapository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/modules/home/presentation/widgets/sections_tab/sections_tab_controller.dart';
import 'package:vocabulario_dev/modules/home/presentation/widgets/sections_tab/widget/leson_item.dart';
import 'package:vocabulario_dev/modules/home/presentation/widgets/sections_tab/widget/random_btn.dart';
import 'package:vocabulario_dev/modules/home/presentation/pages/lesson/lesson_page.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/presentation/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SectionsTab extends StatefulWidget {
  const SectionsTab._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SectionTabController(
        userInfo: context.read<UserInfoStorageReapositoryInterface>(),
        sectionsService: context.read<SectionsApiReapositoryInterface>(),
      ),
      builder: (_, __) => const SectionsTab._(),
    );
  }

  @override
  State<SectionsTab> createState() => _SectionsTabState();
}

class _SectionsTabState extends State<SectionsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final controller = context.read<SectionTabController>();
    return RefreshIndicator(
      onRefresh: controller.simulateRefresh,
      child: Selector<SectionTabController, bool>(
          selector: (_, controller) => controller.isFloarintBtnVisible,
          shouldRebuild: (prev, next) => prev != next,
          builder: (context, isFloarintBtnVisible, child) {
            return Scaffold(
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton:
                  isFloarintBtnVisible ? const RandomBtn() : null,
              body: const Column(
                children: [
                  Expanded(child: _SectionList()),
                ],
              ),
            );
          }),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _SectionList extends StatelessWidget {
  const _SectionList();

  @override
  Widget build(BuildContext context) {
    final controller = context.read<SectionTabController>();
    final localizations = AppLocalizations.of(context)!;
    final systemPadding = MediaQuery.of(context).padding;
    return Selector<SectionTabController, int>(
        selector: (_, controller) => controller.counter,
        shouldRebuild: (previous, next) => previous != next,
        builder: (_, __, ___) {
          return FutureBuilder(
            future: controller.getSections,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                if (snapshot.error is SectionException) {
                  final error = snapshot.error as SectionException;
                  return SafeArea(
                    child: Center(
                      child: Column(
                      mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(error.cause),
                          TextButton(
                            onPressed: controller.simulateRefresh,
                            child: Text(localizations.home_page_tab_report_retry),
                          )
                        ],
                      ),
                    ),
                  );
                }
                return SafeArea(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(localizations.unknow_error),
                        TextButton(
                          onPressed: controller.simulateRefresh,
                          child: Text(localizations.home_page_tab_report_retry),
                        )
                      ],
                    ),
                  ),
                );
              }
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  final data = snapshot.data!;
                  if (data.isEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      controller.isFloarintBtnVisible = false;
                    });
                    return SafeArea(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(localizations.home_page_tab_inicio_empty),
                            TextButton(
                              onPressed: controller.simulateRefresh,
                              child:
                                  Text(localizations.home_page_tab_report_retry),
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                    controller.isFloarintBtnVisible = true;
                  });
                  return NotificationListener<UserScrollNotification>(
                    onNotification: (notification) {
                      print(notification);
                      const pixelsmargin = 20.0;
                      final pixelsAScrolled = notification.metrics.extentAfter;
                      if (notification.direction == ScrollDirection.forward &&
                          pixelsAScrolled > pixelsmargin) {
                        controller.isFloarintBtnVisible = true;
                      }
                      if (notification.direction == ScrollDirection.reverse &&
                          pixelsAScrolled > pixelsmargin) {
                        controller.isFloarintBtnVisible = false;
                      }
                      if (notification.direction == ScrollDirection.idle) {
                        controller.isFloarintBtnVisible = pixelsAScrolled ==
                            notification.metrics.maxScrollExtent;
                      }
                      return true;
                    },
                    child: ListView.builder(
                        padding: EdgeInsets.only(
                          top: systemPadding.top+DefaultTheme.padding,
                          left: DefaultTheme.padding,
                          right: DefaultTheme.padding,
                          bottom: systemPadding.bottom+DefaultTheme.padding,
                        ),
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          return Column(
                            children: [
                              _Header(section: data[i]),
                              _Body(section: data[i]),
                              const SizedBox(height: DefaultTheme.padding)
                            ],
                          );
                        }),
                  );

                default:
                  return const SafeArea(child: Center(child: CircularProgressIndicator(),),);
              }
            },
          );
        });
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.section,
  });

  final Section section;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final width = MediaQuery.of(context).size.width;
        final paddingTomaxWidth = (width - DefaultTheme.maxWidth) / 2;
        const minPadding = 50.0;
        final double padding =
            width > DefaultTheme.maxWidth ? paddingTomaxWidth : minPadding;
        final nroColumns = width > 500 ? 3 : 2;
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: section.lessons.length,
          padding: EdgeInsets.symmetric(horizontal: padding),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 1,
            mainAxisSpacing: 1,
            childAspectRatio: 5 / 6,
            crossAxisCount: nroColumns,
          ),
          itemBuilder: (context, i) {
            return LesonItem(
              leson: section.lessons[i],
              disabled: section.lessons[i].terms.isEmpty,
              onTap: () {
                Navigator.of(context)
                    .pushNamed(LessonPage.path, arguments: section.lessons[i]);
              },
            );
          },
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.section,
  });

  final Section section;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(
          top: DefaultTheme.padding, bottom: DefaultTheme.padding),
      child: Column(children: [
        Text(
          section.title,
          style: theme.textTheme.displayMedium,
        ),
        if (section.description != null)
          Text(
            section.description!,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          )
      ]),
    );
  }
}
