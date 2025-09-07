import 'package:dummy/features/login/domain/entities/auth_token.dart';

class AuthTokenModel extends AuthToken {
  const AuthTokenModel({required super.token, required super.error});

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    return AuthTokenModel(error: json['error'], token: json['token']);
  }
  Map<String, dynamic> toJson() {
    return {'token': token, 'error': error};
  }

  AuthToken toEntity() => AuthToken(token: token, error: error);
}
