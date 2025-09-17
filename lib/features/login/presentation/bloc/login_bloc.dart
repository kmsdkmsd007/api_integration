import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
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
    Map data = {'email': state.email, 'password': state.password};
    try {
      emit(state.copyWith(loginStatus: LoginStatus.loading));
      final response = await http.post(
        Uri.parse('https://reqres.in/api/login'),
        body: data,
      );
      if (response.statusCode == 200) {
        emit(state.copyWith(loginStatus: LoginStatus.success));
      } else {
        emit(
          state.copyWith(
            loginStatus: LoginStatus.failure,
            message: 'Invalid email or password',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(message: e.toString(), loginStatus: LoginStatus.failure),
      );
    }
  }
}
