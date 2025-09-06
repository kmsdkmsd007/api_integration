import 'package:dummy/features/login/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({required String token, required String error})
    : super(token: token, error: error);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(error: json['error'], token: json['token']);
  }
  Map<String, dynamic> toJson() {
    return {'token': token, 'error': error};
  }
}
