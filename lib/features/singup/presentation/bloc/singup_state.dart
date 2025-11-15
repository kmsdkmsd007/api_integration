part of 'singup_bloc.dart';

class SingupState extends Equatable {
  final String email;
  final String password;
  final Status signupStatus;
  final int id;

  final String message;
  final String token;
  const SingupState({
    this.email = '',
    this.password = '',
    this.token = '',
    this.id = 0,

    this.message = '',
    this.signupStatus = Status.initial,
  });
  SingupState copyWith({
    final String? email,
    final String? password,
    final int? id,

    final Status? signupStatus,
    final String? message,
    final String? token,
  }) {
    return SingupState(
      email: email ?? this.email,
      id: id ?? this.id,
      password: password ?? this.password,
      message: message ?? this.message,
      token: token ?? this.token,
      signupStatus: signupStatus ?? this.signupStatus,
    );
  }

  @override
  List<Object> get props => [
    this.email,
    this.password,
    this.signupStatus,
    this.message,
    this.token,
  ];
}
