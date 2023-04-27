class Endpoints {
  static final Endpoints _appColors = Endpoints._internal();

  factory Endpoints() {
    return _appColors;
  }

  Endpoints._internal();

  static const String baseUrl = 'https://www.googleapis.com/books/v1';
  static const String volumes = '/volumes';
}
