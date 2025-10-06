import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:dummy/core/utils/enum.dart';
import 'package:dummy/features/singup/domain/usecases/register_usecas.dart';
import 'package:equatable/equatable.dart';

part 'singup_event.dart';
part 'singup_state.dart';

class SingupBloc extends Bloc<SingupEvent, SingupState> {
  final RegisterUsecas registerUsecas;
  SingupBloc({required this.registerUsecas}) : super(SingupState()) {
    on<SignUpApi>(_registeUer);
    on<RegisterEmailChanged>(_onEmailChanges);
    on<RegisterPasswordChanged>(_passwordChanged);
  }
  void _onEmailChanges(RegisterEmailChanged event, Emitter<SingupState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordChanged(
    RegisterPasswordChanged event,
    Emitter<SingupState> emit,
  ) {
    emit(state.copyWith(password: event.password));
  }

  void _registeUer(SignUpApi event, Emitter<SingupState> emit) async {
    emit(
      SingupState(
        signupStatus: Status.loading,
        message: 'Submitting register request...',
      ),
    );
    final result = await registerUsecas.registerWthEmailandPassword(
      state.email,
      state.password,
    );
    result.fold(
      (failure) => emit(
        SingupState(signupStatus: Status.error, message: failure.toString()),
      ),
      (signUpModel) => emit(
        SingupState(
          id: signUpModel.id,
          token: signUpModel.token,
          signupStatus: Status.success,
          message: 'Register successfully',
        ),
      ),
    );
  }
}
