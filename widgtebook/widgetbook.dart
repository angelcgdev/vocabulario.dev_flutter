import 'package:flutter/material.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/presentation/theme.dart';
import 'package:widgetbook/widgetbook.dart';

class HotReload extends StatelessWidget {
  const HotReload({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        ThemeAddon(
          themes: [
            WidgetbookTheme(
              name: 'Light',
              data: themeLight,
            ),
            WidgetbookTheme(
              name: 'Dark',
              data: themeDark,
            ),
          ],
          themeBuilder: (context, theme, child) {
            return MaterialApp(
              theme: theme,
              home: child,  
            );
          },
        ),
      ],
      directories: [
        WidgetbookCategory(
          children: [
            WidgetbookComponent(
              name: 'text test',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context){
                    return const Text('data');
                  }
                )
              ]
            )
          ],
          name: 'test'
        )
      ]
    );
  }
}