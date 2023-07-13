import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/presentation/theme.dart';

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
    // final controller = widget.parentcontext.read<LessonController>();
    return AlertDialog(
      scrollable: true,
      titlePadding: const EdgeInsets.only(left: DefaultTheme.padding*.5, right: DefaultTheme.padding, top: DefaultTheme.padding*.5),
      title: Align(
        alignment: Alignment.topLeft,
        child: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(FeatherIcons.x),
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: DefaultTheme.padding, vertical: DefaultTheme.gap),
      content: TextField(
        controller: _descriptionController,
        minLines: 5,
        maxLines: 6,
        decoration: InputDecoration(
          hintText: localization.lesson_page_btn_input_placeholder,
        ),
      ),
      actionsOverflowButtonSpacing: DefaultTheme.gap,
      actions: [
        ElevatedButton(
          onPressed: () {
            // controller.reportTerm(
            //   idLesson: 1,
            //   description: _descriptionController.text,
            //   isCorrect: true,
            // );
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: theme.colorScheme.onTertiaryContainer,
            backgroundColor: theme.colorScheme.tertiaryContainer,
          ),
          child: Text('${localization.lesson_page_btn_report('true')} +1'),
        ),
        ElevatedButton(
          onPressed: () {
            // controller.reportTerm(
            //   idLesson: 1,
            //   description: _descriptionController.text,
            //   isCorrect: false,
            // );
          },
          child: Text('${localization.lesson_page_btn_report('false')} -1'),
        ),
      ],
    );
  }
}
