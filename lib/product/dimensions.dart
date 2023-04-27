class Dimensions {
  static final Dimensions _dimensions = Dimensions._internal();

  factory Dimensions() {
    return _dimensions;
  }

  Dimensions._internal();

  static const double pagePadding = 16.0;
}
