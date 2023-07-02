import 'package:flutter/material.dart';

class LoadingOverlay extends StatefulWidget {
  const LoadingOverlay({
    super.key,
    required this.child,
  });
  final Widget child;

  // ignore: library_private_types_in_public_api
  static _LoadingOverlayState of(BuildContext context) {
    return context.findAncestorStateOfType<_LoadingOverlayState>()!;
  }

  @override
  State<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay> {

  bool _isLoading = false;
  void show() {
    setState(() => _isLoading = true);
  }

  void hide() {
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_isLoading)
          const Scaffold(
            body: SafeArea(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
      ],
    );
  }
}
