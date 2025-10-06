part of 'singup_bloc.dart';

abstract class SingupEvent extends Equatable {
  const SingupEvent();

  @override
  List<Object> get props => [];
}

class RegestierErrorEvent extends SingupEvent {
  final String message;
  const RegestierErrorEvent({required this.message});
  @override
  List<Object> get props => [message];
}

class RegestierLoadingEvent extends SingupEvent {}

class RegestierLoadedEvent extends SingupEvent {}

class RegisterEmailChanged extends SingupEvent {
  final String email;

  const RegisterEmailChanged({required this.email});
  @override
  List<Object> get props => [email];
}

class RegisterPasswordChanged extends SingupEvent {
  final String password;

  const RegisterPasswordChanged({required this.password});
  @override
  List<Object> get props => [password];
}

class RegisterConfirmPasswordChanged extends SingupEvent {
  final String confirmpassword;

  const RegisterConfirmPasswordChanged({required this.confirmpassword});
  @override
  List<Object> get props => [confirmpassword];
}

class SignUpApi extends SingupEvent {}

class RegisterSuccess extends SingupEvent {
  final int id;
  final String password;

  const RegisterSuccess({required this.password, required this.id});
  @override
  List<Object> get props => [password, id];
}
