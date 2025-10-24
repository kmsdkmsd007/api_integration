import 'package:dummy/core/exception/app_exception.dart';
import 'package:dummy/features/singup/domain/entities/sign_up.dart';

class SignUpModel extends SignUp {
  const SignUpModel({required super.id, required super.token});

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    if (json['token'] == null || json['id'] == null) {
      throw TokenMissingException('token  is missing');
    }

    return SignUpModel(id: json['id'], token: json['token']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'token': token};
  }

  SignUp toEntity() => SignUp(id: id, token: token);
}
