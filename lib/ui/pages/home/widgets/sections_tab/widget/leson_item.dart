import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:vocabulario_dev/domain/model/lesson.dart';
import 'package:vocabulario_dev/ui/pages/widgets/progress_indicator.dart';
import 'package:vocabulario_dev/ui/theme/theme.dart';

class LesonItem extends StatelessWidget {
  const LesonItem({
    super.key,
    required this.leson,
    required this.onTap,
    this.disabled = false,
  });

  final Lesson leson;
  final GestureTapCallback? onTap;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    const size = 50.0;
    const sizeChildren = 65.0;
    final totalTerms = leson.terms.length;
    final completedTerms =
        leson.terms.takeWhile((value) => value.completed).length;
    final calc = completedTerms / totalTerms;
    double progress = calc.isNaN ? 0 : calc * 100;
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: !disabled ? onTap : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipOval(
                child: Image.network(
                  leson.image,
                  width: sizeChildren,
                  height: sizeChildren,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: sizeChildren,
                      height: sizeChildren,
                      color: theme.primaryColor,
                      alignment: Alignment.center,
                      child: Icon(
                        FeatherIcons.alertCircle,
                        color: theme.colorScheme.onPrimary,
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    return Container(
                      width: sizeChildren,
                      height: sizeChildren,
                      color: theme.primaryColor,
                      alignment: Alignment.center,
                      child: child,
                    );
                  },
                ),
              ),
              VProgressIndicator(
                value: progress / 100,
                color: theme.colorScheme.tertiary,
                borderBackgroundTransparence:
                    MediaQuery.of(context).platformBrightness == Brightness.dark
                        ? 0.3
                        : 0.1,
                strokeWidth: 11,
                radius: size,
              ),
              if (disabled)
                SizedBox.square(
                  dimension: sizeChildren,
                  child: Container(
                      decoration: BoxDecoration(
                          color: theme.colorScheme.background.withOpacity(.5),
                          borderRadius:
                              BorderRadius.circular(sizeChildren * .5))),
                )
            ],
          ),
          const SizedBox(
            height: DefaultTheme.gap,
          ),
          Text(
            leson.name,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: disabled
                ? theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onBackground.withOpacity(.5))
                : null,
          ),
        ],
      ),
    );
  }
}
