import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:vocabulario_dev/modules/home/domain/model/report.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vocabulario_dev/modules/home/modules/definition_report/presentation/pages/definition_report_page.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/presentation/theme.dart';

class ReportItem extends StatelessWidget {
  const ReportItem({
    super.key,
    required this.report,
  });

  final Report report;
  static const imageSize = 45.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final navigator = Navigator.of(context);
    final localization = AppLocalizations.of(context)!;
    return Material(
      child: InkWell(
        onTap: (){
          navigator.pushNamed(DefinitionReportPage.path);
        },
        child: Padding(
          padding: const EdgeInsets.all(DefaultTheme.padding),
          child: Row(
            children: [
              _Avatar(image: report.user?.image, imageSize: imageSize),
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
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({
    this.image,
    required this.imageSize,
  });

  final String? image;
  final double imageSize;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: ClipOval(
        child: (image == null ||
                image?.isEmpty == true)
            ? const Icon(FeatherIcons.user)
            : Image.network(
                image!,
                width: imageSize,
                height: imageSize,
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
