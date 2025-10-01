part of 'singup_bloc.dart';

abstract class SingupEvent extends Equatable {
  const SingupEvent();

  @override
  List<Object> get props => [];
}

class RegisterUserEvent extends SingupEvent {
  final String email;
  final String password;
  const RegisterUserEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegestierErrorEvent extends SingupEvent {
  final String message;
  const RegestierErrorEvent({required this.message});
  @override
  List<Object> get props => [message];
}
