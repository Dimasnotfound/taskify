import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  late Dio dio;

  ApiClient() {
    final baseUrl = dotenv.env['BASE_URL'];

    if (baseUrl == null) {
      throw Exception("BASE_URL not found in .env");
    }

    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl, // Base URL diatur di sini
        connectTimeout: Duration(milliseconds: 60000),
        receiveTimeout: Duration(milliseconds: 60000),
      ),
    );
  }

  Dio getClient() => dio;
}
