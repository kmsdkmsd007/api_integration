import 'package:dummy/features/login/domain/entities/auth_token.dart';

class AuthTokenModel extends AuthToken {
  const AuthTokenModel({required super.token, required super.error});

  factory AuthTokenModel.fromJson(Map<String, dynamic> json) {
    if (json['token'] == null) throw Exception('Token missing');
    return AuthTokenModel(token: json['token'], error: json['error'] ?? '');
  }
  Map<String, dynamic> toJson() {
    return {'token': token, 'error': error};
  }

  AuthToken toEntity() => AuthToken(token: token, error: error);
}
