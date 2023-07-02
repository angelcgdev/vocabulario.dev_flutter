import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vocabulario_dev/modules/home/modules/definition_report/aplication/reports_bloc.dart';
import 'package:vocabulario_dev/modules/home/modules/definition_report/domain/model/report.dart';
import 'package:vocabulario_dev/modules/home/modules/definition_report/presentation/widgets/report_item.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/presentation/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReportsTab extends StatefulWidget {
  const ReportsTab({super.key});

  @override
  State<ReportsTab> createState() => _ReportsTabState();
}

class _ReportsTabState extends State<ReportsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final reportsBloc = BlocProvider.of<ReportsBloc>(context, listen: false);
    reportsBloc.add(ReportsFetched());
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return RefreshIndicator(
      edgeOffset: MediaQuery.of(context).padding.top,
      onRefresh: () async {
        reportsBloc.add(ReportsFetched());
        await Future.delayed(
          const Duration(seconds: 2),
        );
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<ReportsBloc, ReportsState>(
                builder: (context, state) {
                  switch (state.status) {
                    case ReportStatus.failure:
                      return SafeArea(
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(localizations.unknow_error),
                              TextButton(
                                onPressed: () {
                                  reportsBloc.add(ReportsFetched());
                                },
                                child: Text(
                                    localizations.home_page_tab_report_retry),
                              )
                            ],
                          ),
                        ),
                      );
                    case ReportStatus.initial:
                      return const SafeArea(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    case ReportStatus.success:
                      final data = state.reports;
                      final backgroundColor = theme.colorScheme.background;
                      return Stack(
                        children: [
                          _ListItems(data: data),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            height: MediaQuery.of(context).padding.top,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    backgroundColor,
                                    backgroundColor.withOpacity(0)
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _ListItems extends StatelessWidget {
  const _ListItems({
    required this.data,
  });

  final List<Report> data;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      final width = constrains.maxWidth;
      final systemPadding = MediaQuery.of(context).padding;
      final double padding = width > DefaultTheme.maxWidth
          ? ((width - DefaultTheme.maxWidth) / 2)
          : 0;
      return ListView.builder(
        itemCount: data.length + 1,
        padding: EdgeInsets.only(
            top: systemPadding.top,
            left: padding,
            right: padding,
            bottom: systemPadding.bottom),
        itemBuilder: (context, index) {
          if (index == 0) {
            return const _Header();
          }
          return ReportItem(report: data[index - 1]);
        },
      );
    });
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(
          top: DefaultTheme.padding * 2,
          left: DefaultTheme.padding,
          right: DefaultTheme.padding,
          bottom: DefaultTheme.gap),
      child: Column(
        children: [
          Text(
            localizations.home_page_tab_report_title,
            style: theme.textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            localizations.home_page_tab_report_description,
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
