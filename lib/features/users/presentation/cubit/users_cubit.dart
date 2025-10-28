import 'package:bloc/bloc.dart';
import 'package:dummy/features/users/domain/entities/user.dart';
import 'package:dummy/features/users/domain/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UserRepository userRepository;
  UsersCubit(Object object, {required this.userRepository})
    : super(UsersInitial());

  Future<void> fetchAllUsers() async {
    emit(UsersLoading());
    final result = await userRepository.fetchUser();
    result.fold((failure) {
      emit(UserError(failure.toString()));
    }, (users) => emit(UsersLoaded(users)));
  }
}
