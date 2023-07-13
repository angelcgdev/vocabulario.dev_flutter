import 'package:flutter/material.dart';
import 'package:vocabulario_dev/modules/home/modules/theme/presentation/theme.dart';

class RandomPage extends StatelessWidget {
  const RandomPage({super.key});
  static String path = '/home/random';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Choosing a random lesson..'),
              SizedBox(
                height: DefaultTheme.gap,
              ),
              CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}
