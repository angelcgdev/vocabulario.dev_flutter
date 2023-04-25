import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocabulario_dev/data/datasource/exceptions/report_exception.dart';
import 'package:vocabulario_dev/domain/model/report.dart';
import 'package:vocabulario_dev/domain/repository/reports_api_reapository.dart';
import 'package:vocabulario_dev/domain/repository/userinfo_storage_reapository.dart';
import 'package:vocabulario_dev/ui/pages/home/widgets/reports_tab/reports_tab_controller.dart';
import 'package:vocabulario_dev/ui/pages/home/widgets/reports_tab/widgets/report_item.dart';
import 'package:vocabulario_dev/ui/theme/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReportsTab extends StatefulWidget {
  const ReportsTab._();

  static Widget init(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReportsTabController(
          userInfo: context.read<UserInfoStorageReapositoryInterface>(),
          reportService: context.read<ReportsApiRepositoryInterface>()),
      builder: (_, __) => const ReportsTab._(),
    );
  }

  @override
  State<ReportsTab> createState() => _ReportsTabState();
}

class _ReportsTabState extends State<ReportsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final controller = context.watch<ReportsTabController>();
    final localizations = AppLocalizations.of(context)!;
    return RefreshIndicator(
      onRefresh: controller.simulateRefresh,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
                child: FutureBuilder(
              future: controller.getReports,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  final error = snapshot.error;
                  if (error is ReportException) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(error.cause),
                          TextButton(
                            onPressed: controller.simulateRefresh,
                            child:
                                Text(localizations.home_page_tab_report_retry),
                          )
                        ],
                      ),
                    );
                  }
                  return Center(
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
                  );
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    final data = snapshot.data!;
                    if (data.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(localizations.home_page_tab_report_empty),
                            TextButton(
                              onPressed: controller.simulateRefresh,
                              child: Text(
                                  localizations.home_page_tab_report_retry),
                            )
                          ],
                        ),
                      );
                    }
                    return _ListItems(data: data);
                  default:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                }
              },
            ))
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
    super.key,
    required this.data,
  });

  final List<Report> data;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      final width = MediaQuery.of(context).size.width;
      final double padding = width > DefaultTheme.maxWidth
          ? ((width - DefaultTheme.maxWidth) / 2)
          : 0;
      return ListView.builder(
        itemCount: data.length + 1,
        padding: EdgeInsets.symmetric(horizontal: padding),
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
  // ignore: unused_element
  const _Header({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
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
            style: Theme.of(context).textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            localizations.home_page_tab_report_description,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
