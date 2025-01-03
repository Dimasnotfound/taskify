import 'package:dio/dio.dart';
import '../models/user_model.dart';

class AuthRemoteDatasource {
  final Dio client;

  AuthRemoteDatasource(this.client);

  Future<UserModel> login(String email, String password) async {
    try {
      final data = {
        'email': email,
        'password': password,
      };

      final response = await client.post(
        '/login',
        data: data,
      );

      if (response.statusCode == 200) {
        return UserModel.fromJson(response.data);
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      print("Error: $e"); // Debug Error
      throw Exception('Failed to login');
    }
  }
}
