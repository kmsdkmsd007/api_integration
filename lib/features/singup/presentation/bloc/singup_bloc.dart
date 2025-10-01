import 'package:bloc/bloc.dart';
import 'package:dummy/core/utils/enum.dart';
import 'package:dummy/features/singup/domain/usecases/register_usecas.dart';
import 'package:equatable/equatable.dart';

part 'singup_event.dart';
part 'singup_state.dart';

class SingupBloc extends Bloc<SingupEvent, SingupState> {
  final RegisterUsecas registerUsecas;
  SingupBloc({required this.registerUsecas}) : super(SingupInitial()) {
    on<RegisterUserEvent>(_registeUer);
  }

  void _registeUer(RegisterUserEvent event, Emitter<SingupState> emit) async {
    emit(
      SinguplodedState(
        signupStatus: Status.loading,
        message: 'Submitting register request...',
      ),
    );
    final result = await registerUsecas.registerWthEmailandPassword(
      event.email,
      event.password,
    );
    result.fold(
      (failure) => emit(
        SinguplodedState(
          signupStatus: Status.error,
          message: failure.toString(),
        ),
      ),
      (SignUpModel) => emit(
        SinguplodedState(
          email: event.email,
          password: event.password,
          token: SignUpModel.token,
          signupStatus: Status.success,
          message: 'Register successfully',
        ),
      ),
    );
  }
}
