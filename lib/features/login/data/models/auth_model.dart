import 'package:dummy/features/login/domain/entities/auth_token.dart';

class AuthTokenModel extends AuthToken {
  const AuthTokenModel({required super.token});

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    if (json['token'] == null) throw Exception('Token missing');
    return AuthTokenModel(token: json['token']);
  }
  Map<String, dynamic> toJson() {
    return {'token': token};
  }

  AuthToken toEntity() => AuthToken(token: token);
}
