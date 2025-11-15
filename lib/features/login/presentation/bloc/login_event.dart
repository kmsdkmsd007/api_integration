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

class LoginError extends LoginEvent {
  final String error;
  const LoginError({required this.error});
  @override
  List<Object> get props => [error];
}

class EmailChanged extends LoginEvent {
  final String email;

  const EmailChanged({required this.email});
  @override
  List<Object> get props => [email];
}

class LoginApiEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginApiEvent({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class LoginLoading extends LoginEvent {}

class LoginInitail extends LoginEvent {}

class LoginSuccess extends LoginEvent {
  final String token;
  const LoginSuccess({required this.token});
  @override
  List<Object> get props => [token];
}
