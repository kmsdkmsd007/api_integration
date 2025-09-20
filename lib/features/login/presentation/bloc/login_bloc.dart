import 'package:bloc/bloc.dart';
import 'package:dummy/core/error/failure.dart';
import 'package:dummy/features/login/domain/usecases/login_usecase.dart';
import 'package:equatable/equatable.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserCase loginUserCase;
  LoginBloc(this.loginUserCase) : super(LoginState()) {
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

  Future _loginApi(LoginApi event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));
    final failureorLogin = await loginUserCase(
      LoginParms(email: state.email, password: state.password),
    );
    failureorLogin.fold(
      (failure) {
        String errorMessage = 'Invalid email or password';
        if (failure is SyntextFailure &&
            failure != null &&
            failure.properties.isNotEmpty) {
          errorMessage = failure.toString();
        }
        emit(
          state.copyWith(
            loginStatus: LoginStatus.failure,
            message: errorMessage,
          ),
        );
      },
      (token) => emit(
        state.copyWith(loginStatus: LoginStatus.success, token: token.token),
      ),
    );
  }
}
