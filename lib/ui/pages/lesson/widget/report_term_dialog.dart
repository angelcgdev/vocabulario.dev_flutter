import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:vocabulario_dev/ui/pages/lesson/lesson_controller.dart';
import 'package:vocabulario_dev/ui/theme/theme.dart';

class ReportTermDialog extends StatefulWidget {
  const ReportTermDialog({super.key, required this.parentcontext});
  final BuildContext parentcontext;
  @override
  State<ReportTermDialog> createState() => _ReportTermDialogState();
}

class _ReportTermDialogState extends State<ReportTermDialog> {
  late TextEditingController _descriptionController;
  @override
  void initState() {
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localization = AppLocalizations.of(context)!;
    final controller = widget.parentcontext.read<LessonController>();
    return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      content: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * .9,
          constraints: const BoxConstraints(maxWidth: 500),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(DefaultTheme.borderRadius),
              color: theme.colorScheme.surface),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(FeatherIcons.x),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: DefaultTheme.padding,
                  right: DefaultTheme.padding,
                  bottom: DefaultTheme.padding,
                ),
                child: Builder(builder: (context) {
                  return Column(
                    children: [
                      TextField(
                        controller: _descriptionController,
                        minLines: 5,
                        maxLines: 6,
                        decoration: InputDecoration(
                          hintText:
                              localization.lesson_page_btn_input_placeholder,
                        ),
                      ),
                      const SizedBox(
                        height: DefaultTheme.gap,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.reportTerm(
                            idLesson: 1,
                            description: _descriptionController.text,
                            isCorrect: true,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor:
                              theme.colorScheme.onTertiaryContainer,
                          backgroundColor: theme.colorScheme.tertiaryContainer,
                        ),
                        child: Text(
                            '${localization.lesson_page_btn_report('true')} +1'),
                      ),
                      const SizedBox(
                        height: DefaultTheme.gap,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.reportTerm(
                            idLesson: 1,
                            description: _descriptionController.text,
                            isCorrect: false,
                          );
                        },
                        child: Text(
                            '${localization.lesson_page_btn_report('false')} -1'),
                      ),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
