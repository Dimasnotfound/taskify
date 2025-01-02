import 'package:dio/dio.dart';
import '../model/user_model.dart';

class AuthRemoteDatasource {
  final Dio client;

  AuthRemoteDatasource(this.client);

  Future<UserModel> login(String email, String password) async {
    final response = await client.post('/login', data: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception('Login failed');
    }
  }
}
