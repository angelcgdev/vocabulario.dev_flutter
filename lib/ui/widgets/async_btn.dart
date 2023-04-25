import 'package:flutter/material.dart';
import 'package:vocabulario_dev/ui/theme/theme.dart';

class ElevateButtonAsyn extends StatelessWidget {
  ElevateButtonAsyn(
      {super.key, this.onPressed, required this.label, this.isLoading = false});

  final VoidCallback? onPressed;
  bool isLoading = false;
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
