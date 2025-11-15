import 'package:equatable/equatable.dart';

class SignUp extends Equatable {
  final int id;
  final String token;
  const SignUp({required this.id, required this.token});

  @override
  List<Object?> get props => [id, token];
}
