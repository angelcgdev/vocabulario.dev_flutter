import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vocabulario_dev/main_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ThemeOption {
  String name;
  ThemeMode value;
  ThemeOption({required this.name, required this.value});
}

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  static String path = "/home/theme";

  @override
  Widget build(BuildContext context) {
    final mainController = context.watch<MainController>();
    final localization = AppLocalizations.of(context)!;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Theme.of(context).colorScheme.surface),
      child: Scaffold(
          appBar: AppBar(
            title: Text(localization.theme_page_title),
          ),
          body: Column(
            children: ThemeMode.values
                .map((e) => RadioListTile(
                    value: e,
                    title: Text(
                        localization.theme_page_options_title(describeEnum(e))),
                    groupValue: mainController.themeMode,
                    onChanged: (theme) {
                      if (theme != null) {
                        mainController.themeMode = theme;
                      }
                    }))
                .toList(),
          )),
    );
  }
}
