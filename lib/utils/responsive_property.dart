import 'package:vocabulario_dev/utils/breakpoints.dart';

class ResponsiveProperty<T> {
  final double _width;
  final T _xs;
  final T? _sm;
  final T? _md;
  final T? _lg;
  final T? _xl;
  final T? _xxl;

  ResponsiveProperty({
    required double width,
    required T xs,
    T? sm,
    T? md,
    T? lg,
    T? xl,
    T? xxl,
  }) : _xxl = xxl, _xl = xl, _lg = lg, _md = md, _sm = sm, _xs = xs, _width = width;

  T get value {
    final bp = BreakPoints(width: _width);
    final isXxlAvailable = bp.breakPointIsActiveWithValue(BreakPoints.xxl, _xxl);
    if (isXxlAvailable) {
      return _xxl!;
    }
    final isXlAvailable = bp.breakPointIsActiveWithValue(BreakPoints.xl, _xl);
    if (isXlAvailable) {
      return _xl!;
    }
    final isLgAvailable = bp.breakPointIsActiveWithValue(BreakPoints.lg, _lg);
    if (isLgAvailable) {
      return _lg!;
    }
    final isMdAvailable = bp.breakPointIsActiveWithValue(BreakPoints.md, _md);
    if (isMdAvailable) {
      return _md!;
    }
    final isSmAvailable = bp.breakPointIsActiveWithValue(BreakPoints.sm, _sm);
    if (isSmAvailable) {
      return _sm!;
    }
    return _xs;
  }
}
