import 'package:dummy/features/login/domain/entities/auth_token.dart';

class AuthTokenModel extends AuthToken {
  const AuthTokenModel({
    required super.token,
    required super.email,
    required super.password,
  });

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    if (json['token'] == null) throw Exception('Token missing');
    return AuthTokenModel(
      token: json['token'],
      email: json['email'] ?? '',
      password: json['password'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {'token': token};
  }

  AuthToken toEntity() =>
      AuthToken(token: token, email: email, password: email);
}
