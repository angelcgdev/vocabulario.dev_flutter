class BreakPoints {
  final double _width;
  BreakPoints({required double width}) : _width = width;
  static const xs = 475;

  static const sm = 640;

  static const md = 768;

  static const lg = 1024;

  static const xl = 1280;

  static const xxl = 1536;

  breakPointIsActiveWithValue<T>(int breakPoint, T? value){
    return (_width >= breakPoint && value != null);
  }
}