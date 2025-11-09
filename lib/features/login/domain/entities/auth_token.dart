import 'package:equatable/equatable.dart';

class AuthToken extends Equatable {
  final String token;
  final String email, password;

  const AuthToken({
    required this.token,
    required this.email,
    required this.password,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [token, email, password];
}
