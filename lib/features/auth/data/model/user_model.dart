import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel(
      {required String name, required String email, required String token})
      : super(name: name, email: email, token: token);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['user']['name'],
      email: json['user']['email'],
      token: json['access_token'],
    );
  }
}
