part of 'singup_bloc.dart';

abstract class SingupState extends Equatable {
  const SingupState();

  @override
  List<Object> get props => [];
}

class SingupInitial extends SingupState {}

class SinguplodaingState extends SingupState {}

class SinguplodedState extends SingupState {
  final String email;
  final String password;
  final Status signupStatus;
  final String message;
  final String token;

  const SinguplodedState({
    this.email = '',
    this.password = '',
    this.token = '',

    this.message = '',
    this.signupStatus = Status.initial,
  });
  SinguplodedState copyWith({
    final String? email,
    final String? password,
    final Status? signupStatus,
    final String? message,
    final String? token,
  }) {
    return SinguplodedState(
      email: email ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,
      token: token ?? this.token,
      signupStatus: signupStatus ?? this.signupStatus,
    );
  }
}
