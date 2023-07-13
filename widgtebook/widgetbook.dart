import 'package:flutter/material.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/presentation/theme.dart';
import 'package:widgetbook/widgetbook.dart';

class HotReload extends StatelessWidget {
  const HotReload({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(addons: [
      ThemeAddon(
        themes: [
          WidgetbookTheme(
            name: 'Light',
            data: themeLight(),
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
    ], directories: [
      WidgetbookCategory(children: [
        WidgetbookComponent(name: 'text test', useCases: [
          WidgetbookUseCase(
              name: 'Default',
              builder: (context) {
                return const Text('data');
              })
        ])
      ], name: 'test'),
      WidgetbookCategory(children: [
        WidgetbookComponent(name: 'Primary', useCases: [
          WidgetbookUseCase(
              name: 'Default',
              builder: (context) {
                return _Container(
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text('primary')),
                );
              }),
          WidgetbookUseCase(
              name: 'Disable',
              builder: (context) {
                return const _Container(
                  child:  ElevatedButton(
                      onPressed: null, child: Text('primary')),
                );
              }),
        ]),
        WidgetbookComponent(name: 'Outline', useCases: [
          WidgetbookUseCase(
              name: 'Default',
              builder: (context) {
                return const Text('data');
              })
        ]),
      ], name: 'buttons'),
    ]);
  }
}

class _Container extends StatelessWidget {
  const _Container({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 200, maxWidth: 500),
      alignment: Alignment.center,
      child: child,
    );
  }
}
