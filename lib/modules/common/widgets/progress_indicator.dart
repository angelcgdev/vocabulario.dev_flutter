import 'dart:math';

import 'package:flutter/material.dart';

class VProgressIndicator extends StatefulWidget {
  const VProgressIndicator(
      {super.key,
      required this.radius,
      required this.strokeWidth,
      required this.color,
      required this.value,
      required this.borderBackgroundTransparence});
  final double radius;
  final double strokeWidth;
  final Color color;
  final double value;
  final double borderBackgroundTransparence;

  @override
  State<VProgressIndicator> createState() => _VProgressIndicatorState();
}

class _VProgressIndicatorState extends State<VProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _animation = Tween(begin: 0.0, end: widget.value).animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.radius * 2,
      height: widget.radius * 2,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: _CircularProgressPainter(
                strokeWidth: widget.strokeWidth,
                color: widget.color,
                value: _animation.value,
                borderBackgroundTransparence:
                    widget.borderBackgroundTransparence),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double strokeWidth;
  final Color color;
  final double value;
  final double borderBackgroundTransparence;

  _CircularProgressPainter({
    required this.strokeWidth,
    required this.color,
    required this.value,
    required this.borderBackgroundTransparence,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final Paint strokePaint = Paint()
      ..color = color.withOpacity(borderBackgroundTransparence)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    canvas.drawCircle(center, radius, strokePaint);

    final Paint progressPaint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double progressAngle = 2 * pi * value;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -pi / 2,
      progressAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(_CircularProgressPainter oldDelegate) {
    return oldDelegate.value != value;
  }
}
