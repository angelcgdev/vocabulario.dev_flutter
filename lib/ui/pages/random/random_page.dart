import 'package:flutter/material.dart';
import 'package:vocabulario_dev/ui/theme/theme.dart';

class RandomPage extends StatelessWidget {
  const RandomPage({super.key});
  static String path = '/home/random';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('Choosing a random lesson..'),
            SizedBox(
              height: DefaultTheme.gap,
            ),
            CircularProgressIndicator()
          ],
        ),
      )),
    );
  }
}
