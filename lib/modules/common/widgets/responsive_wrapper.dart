import 'package:flutter/material.dart';
import 'package:vocabulario_dev/utils/breakpoints.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget _xs;
  final Widget? _sm;
  final Widget? _md;
  final Widget? _lg;
  final Widget? _xl;
  final Widget? _xxl;
  const ResponsiveWrapper({super.key, required Widget xs, Widget? sm, Widget? md, Widget? lg, Widget? xl, Widget? xxl}) : _xxl = xxl, _xl = xl, _lg = lg, _md = md, _sm = sm, _xs = xs;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bp = BreakPoints(width: width);
    final isXxlAvailable = bp.breakPointIsActiveWithValue(BreakPoints.xxl, _xxl);
    if(isXxlAvailable) {
      return _xxl!;
    }
    final isXlAvailable = bp.breakPointIsActiveWithValue(BreakPoints.xl, _xl);
    if(isXlAvailable) {
      return _xl!;
    }
    final isLgAvailable = bp.breakPointIsActiveWithValue(BreakPoints.lg, _lg);
    if(isLgAvailable) {
      return _lg!;
    }
    final isMdAvailable = bp.breakPointIsActiveWithValue(BreakPoints.md, _md);
    if(isMdAvailable) {
      return _md!;
    }
    final isSmAvailable = bp.breakPointIsActiveWithValue(BreakPoints.sm, _sm);
    if(isSmAvailable) {
      return _sm!;
    }
    return _xs;
  }
}