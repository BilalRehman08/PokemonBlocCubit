import 'dart:io';
import 'package:dio/dio.dart';

class ApiClient {
  Dio _dio = Dio();

  ApiClient() {
    BaseOptions options = BaseOptions(
      baseUrl: "https://pokeapi.co/api/v2/",
      connectTimeout: 5000,
      receiveTimeout: 3000,
    );

    _dio = Dio(options);
  }

  Future<dynamic> get({
    required String endpoint,
    Map<String, dynamic>? params,
  }) async {
    try {
      Response response = await _dio.get(endpoint, queryParameters: params);

      if (response.statusCode == HttpStatus.ok) {
        return response;
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      throw Exception("Failed to load data");
    }
  }
}
