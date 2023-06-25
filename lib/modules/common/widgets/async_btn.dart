import 'package:flutter/material.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/presentation/theme.dart';

class ElevateButtonAsyn extends StatelessWidget {
  const ElevateButtonAsyn(
      {super.key, this.onPressed, required this.label, this.isLoading = false});

  final VoidCallback? onPressed;
  final bool isLoading;
  final Text label;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          label,
          if (isLoading) ...[
            const SizedBox(
              width: DefaultTheme.gap,
            ),
            SizedBox.square(
              dimension: 15,
              child: CircularProgressIndicator(
                  color: Theme.of(context).disabledColor),
            )
          ]
        ],
      ),
    );
  }
}
