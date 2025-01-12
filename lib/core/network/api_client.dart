import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  late Dio dio;
  String? token;

  ApiClient() {
    final baseUrl = dotenv.env['BASE_URL'];

    if (baseUrl == null) {
      throw Exception("BASE_URL not found in .env");
    }

    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: Duration(milliseconds: 60000),
        receiveTimeout: Duration(milliseconds: 60000),
        headers: {
          'Authorization': token != null ? 'Bearer $token' : '',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          options.headers['Accept'] = 'application/json';
          return handler.next(options);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  void setToken(String authToken) {
    token = authToken;
    dio.options.headers['Authorization'] = 'Bearer $authToken';
  }

  Dio getClient() => dio;
}
