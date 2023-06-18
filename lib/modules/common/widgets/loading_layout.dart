import 'package:flutter/material.dart';

class LoadingLayout extends StatelessWidget {
  const LoadingLayout(
      {super.key, required this.isLoading, required this.child});
  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isLoading
            ? const SafeArea(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : child);
  }
}
