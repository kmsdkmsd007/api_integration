part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class PasswordChanged extends LoginEvent {
  final String password;
  const PasswordChanged({required this.password});
  @override
  List<Object> get props => [password];
}

class TogglePasswordVisibility extends LoginEvent {
  const TogglePasswordVisibility();
}

class LoginErrorEvent extends LoginEvent {
  final String error;
  const LoginErrorEvent({required this.error});
  @override
  List<Object> get props => [error];
}

class EmailChanged extends LoginEvent {
  final String email;

  const EmailChanged({required this.email});
  @override
  List<Object> get props => [email];
}

class LoginApi extends LoginEvent {}

class LoginSuccess extends LoginEvent {
  final String token;
  const LoginSuccess({required this.token});
  @override
  List<Object> get props => [token];
}
