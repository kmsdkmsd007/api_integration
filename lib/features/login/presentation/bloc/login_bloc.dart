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
    on<LoginApi>(_loginApi);
  }

  void _onEmailChanges(EmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _loginApi(LoginApi event, Emitter<LoginState> emit) async {
    Map data = {"email": state.email, "password": state.password};
    // Map data = {"email": "eve.holt@reqres.in", "password": "cityslicka"};
    emit(
      state.copyWith(
        loginStatus: LoginStatus.loading,
        message: 'Submitting login request...',
      ),
    );

    final result = await loginUserCase.login(state.email, state.password);
    result.fold(
      (failure) => emit(
        state.copyWith(
          message: failure.toString(),
          loginStatus: LoginStatus.error,
        ),
      ),
      (AuthTokenModel) => emit(
        state.copyWith(
          token: AuthTokenModel.token,
          loginStatus: LoginStatus.success,
          message: 'Login successfully',
        ),
      ),
    );
  }
}
