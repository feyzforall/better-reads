// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';

import '../endpoints.dart';

class NetworkManager {
  final Dio dio;

  NetworkManager(this.dio) {
    dio.options.baseUrl = Endpoints.baseUrl;
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(path, queryParameters: queryParameters);
      return response;
    } on DioError catch (_) {
      rethrow;
    }
  }
}
