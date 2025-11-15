import 'package:bloc/bloc.dart';
import 'package:dummy/core/utils/enum.dart';
import 'package:dummy/features/login/domain/usecases/login_usecase.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserCase loginUserCase;
  LoginBloc({required this.loginUserCase}) : super(LoginState()) {
    on<EmailChanged>(_onEmailChanges);
    on<PasswordChanged>(_passwordChanged);
    on<LoginApiEvent>(_loginApi);
  }

  void _onEmailChanges(EmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _loginApi(LoginApiEvent event, Emitter<LoginState> emit) async {
    emit(
      state.copyWith(
        loginStatus: Status.loading,
        message: 'Submitting login request...',
      ),
    );

    final result = await loginUserCase.login(event.email, event.password);
    result.fold(
      (failure) => emit(
        state.copyWith(message: failure.toString(), loginStatus: Status.error),
      ),
      (AuthTokenModel) => emit(
        state.copyWith(
          token: AuthTokenModel.token,
          loginStatus: Status.success,
          message: 'Login successfully',
        ),
      ),
    );
  }
}
