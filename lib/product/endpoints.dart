class Endpoints {
  static final Endpoints _endpoints = Endpoints._internal();

  factory Endpoints() {
    return _endpoints;
  }

  Endpoints._internal();

  static const String baseUrl = 'https://www.googleapis.com/books/v1';
  static const String volumes = '/volumes';
}
