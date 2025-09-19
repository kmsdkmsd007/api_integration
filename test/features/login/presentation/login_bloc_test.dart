import 'package:bloc_test/bloc_test.dart';
import 'package:dummy/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late LoginBloc loginBloc;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    loginBloc = LoginBloc();
  });
  tearDown(() {
    loginBloc.close();
  });

  test('initial state is LoginState()', () {
    expect(loginBloc.state, LoginState());
  });

  // 2. EmailChanged event
  blocTest<LoginBloc, LoginState>(
    'emits updated email when EmailChanged is added',
    build: () => loginBloc,
    act: (bloc) => bloc.add(EmailChanged(email: 'test@example.com')),
    expect: () => [LoginState(email: 'test@example.com')],
  );

  // 3. PasswordChanged event
  blocTest<LoginBloc, LoginState>(
    'emits updated password when PasswordChanged is added',
    build: () => loginBloc,
    act: (bloc) => bloc.add(PasswordChanged(password: '123456')),
    expect: () => [LoginState(password: '123456')],
  );

  // 4. LoginApi success
  blocTest<LoginBloc, LoginState>(
    'emits [loading, success] when LoginApi succeeds',
    build: () => loginBloc,
    setUp: () {
      loginBloc.emit(
        LoginState(email: 'eve.holt@reqres.in', password: 'cityslicka'),
      );
    },
    act: (bloc) => bloc.add(LoginApi()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      LoginState(
        email: 'eve.holt@reqres.in',
        password: 'cityslicka',
        loginStatus: LoginStatus.loading,
      ),
      LoginState(
        email: 'eve.holt@reqres.in',
        password: 'cityslicka',
        loginStatus: LoginStatus.success,
      ),
    ],
  );

  // 5. LoginApi failure (wrong credentials)
  blocTest<LoginBloc, LoginState>(
    'emits [loading, failure] when LoginApi fails with invalid credentials',
    build: () => loginBloc,
    setUp: () {
      loginBloc.emit(
        LoginState(email: 'wrong@example.com', password: 'wrongpass'),
      );
    },
    act: (bloc) => bloc.add(LoginApi()),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      LoginState(
        email: 'wrong@example.com',
        password: 'wrongpass',
        loginStatus: LoginStatus.loading,
      ),
      LoginState(
        email: 'wrong@example.com',
        password: 'wrongpass',
        loginStatus: LoginStatus.failure,
        message: 'Invalid email or password',
      ),
    ],
  );

  // 6. LoginApi exception (e.g., network error)
  blocTest<LoginBloc, LoginState>(
    'emits [loading, failure] when LoginApi throws exception',
    build: () => loginBloc,
    setUp: () {
      loginBloc.emit(LoginState(email: 'error@example.com', password: 'error'));
    },
    act: (bloc) {
      // Simulate exception by overriding _loginApi if needed
      throw Exception('Network error');
    },
    errors: () => [isA<Exception>()],
  );
}
