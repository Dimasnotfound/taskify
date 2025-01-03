import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String token;

  UserModel({
    required super.name,
    required super.email,
    required this.token,
  }) : super(token: token);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['user']['name'],
      email: json['user']['email'],
      token: json['access_token'],
    );
  }
}
