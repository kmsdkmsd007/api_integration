part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.email = '',
    this.token = '',
    this.password = '',
    this.message = '',
    this.loginStatus = LoginStatus.initial,
  });
  final String email;
  final String token;
  final LoginStatus loginStatus;
  final String password;
  final String message;

  LoginState copyWith({
    String? email,
    String? password,
    String? token,
    String? message,
    LoginStatus? loginStatus,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      message: message ?? this.message,
      token: token ?? this.token,
      loginStatus: loginStatus ?? this.loginStatus,
    );
  }

  @override
  List<Object> get props => [email, password, token, message, loginStatus];
}
