import 'package:bloc/bloc.dart';
import 'package:dummy/core/error/failure.dart';
import 'package:dummy/features/login/domain/entities/auth_token.dart';
import 'package:dummy/features/login/domain/usecases/login_usecase.dart';
import 'package:equatable/equatable.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final LoginUserCase userCase;
  SplashCubit(this.userCase) : super(SplashInitial());

  Future<void> checkAuthentication() async {
    await Future.delayed(const Duration(seconds: 2)); // show splash a bit
    try {
      final result = await userCase.getlastUser();
      result.fold(
        (failure) => CacheFailure('cache not found'),
        (user) => emit(AuthenticatedUser(user as AuthToken)),
      );
    } catch (e) {
      emit(SplashError('${e.toString()}'));
    }
  }
}
