part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashLoading extends SplashState {}

class AuthenticatedUser extends SplashState {
  final AuthToken user;
  const AuthenticatedUser(this.user);
  @override
  List<Object> get props => [user];
}

class UnauthenticaterUser extends SplashState {}

class LogoutUser extends SplashState {}

class SplashError extends SplashState {
  final String message;
  const SplashError(this.message);
  @override
  List<Object> get props => [message];
}
