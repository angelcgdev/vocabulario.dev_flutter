import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:vocabulario_dev/domain/model/report.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vocabulario_dev/ui/theme/theme.dart';

class ReportItem extends StatelessWidget {
  const ReportItem({
    super.key,
    required this.report,
  });

  final Report report;

  @override
  Widget build(BuildContext context) {
    const imageSize = 45.0;
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(DefaultTheme.padding),
      child: Row(
        children: [
          CircleAvatar(
            child: ClipOval(
              child: (report.user?.image == null ||
                      report.user?.image?.isEmpty == true)
                  ? const Icon(FeatherIcons.user)
                  : Image.network(
                      report.user!.image!,
                      width: imageSize,
                      height: imageSize,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          const SizedBox(width: DefaultTheme.gap),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Text(
                      '${report.user!.fisrtName} ${report.user!.lastName}',
                      overflow: TextOverflow.ellipsis,
                    )),
                    Text(
                      localization
                          .home_page_reports_tab_report_date(report.date!),
                      style: theme.textTheme.bodySmall,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '${report.lesson!.name}:',
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: theme.textTheme.bodyLarge?.color),
                    ),
                    const SizedBox(width: DefaultTheme.gap),
                    Expanded(
                      child: Text(
                        localization.home_page_tab_report_value(
                          report.isCorrect.toString(),
                        ),
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: report.isCorrect
                                ? theme.colorScheme.tertiary
                                : theme.colorScheme.secondary),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
