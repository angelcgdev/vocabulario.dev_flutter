import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vocabulario_dev/ui/pages/random/random_page.dart';

class RandomBtn extends StatelessWidget {
  const RandomBtn({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return FloatingActionButton.extended(
      foregroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
      highlightElevation: 10,
      label: Text(localization.home_page_tab_inicio_btn_random),
      onPressed: () {
        Navigator.of(context).pushNamed(RandomPage.path);
      },
      backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
      icon: const Icon(FeatherIcons.shuffle, size: 15),
    );
  }
}
