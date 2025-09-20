import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:dummy/core/error/failure.dart';
import 'package:dummy/features/login/domain/usecases/login_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'login_event.dart';
part 'login_state.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a email or password.';

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
    final failureorLogin = await loginUserCase(
      LoginParms(email: state.email, password: state.password),
    );
    emit(state.copyWith(loginStatus: LoginStatus.loading));
    failureorLogin.fold(
      (failure) => emit(
        state.copyWith(
          loginStatus: LoginStatus.failure,
          message: state.message,
        ),
      ),
      (token) => emit(
        state.copyWith(loginStatus: LoginStatus.success, token: token.token),
      ),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case SyntextFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }
}
