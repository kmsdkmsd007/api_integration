part of 'users_cubit.dart';

abstract class UsersState extends Equatable {
  const UsersState();

  @override
  List<Object> get props => [];
}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersLoaded extends UsersState {
  final List<User> users;
  const UsersLoaded(this.users);
}

class UserError extends UsersState {
  final String message;
  const UserError(this.message);

  @override
  List<Object> get props => [message];
}

class UserloggedOut extends UsersState {
  const UserloggedOut();
}
