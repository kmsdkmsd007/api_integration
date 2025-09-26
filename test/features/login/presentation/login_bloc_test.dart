import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dummy/core/error/failure.dart';
import 'package:dummy/core/utils/enum.dart';
import 'package:dummy/features/login/domain/entities/auth_token.dart';
import 'package:dummy/features/login/domain/repositories/auth_repository.dart';
import 'package:dummy/features/login/domain/usecases/login_usecase.dart';
import 'package:dummy/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetLoginUser extends Mock implements LoginUserCase {}

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  setUpAll(() {});
  late MockGetLoginUser mockLoginUserCase;

  late LoginBloc loginBloc;

  setUp(() {
    mockLoginUserCase = MockGetLoginUser();
    loginBloc = LoginBloc(loginUserCase: mockLoginUserCase);
  });

  tearDown(() {
    loginBloc.close();
  });

  test('initial state is LoginState()', () {
    expect(loginBloc.state, LoginState());
  });

  blocTest<LoginBloc, LoginState>(
    'emits updated email when EmailChanged is added',
    build: () => LoginBloc(loginUserCase: mockLoginUserCase),
    act: (bloc) => bloc.add(EmailChanged(email: 'test@example.com')),
    expect: () => [LoginState(email: 'test@example.com')],
  );

  blocTest<LoginBloc, LoginState>(
    'emits updated password when PasswordChanged is added',
    build: () => LoginBloc(loginUserCase: mockLoginUserCase),
    act: (bloc) => bloc.add(PasswordChanged(password: '123456')),
    expect: () => [LoginState(password: '123456')],
  );

  blocTest<LoginBloc, LoginState>(
    'emits [loading, success] when LoginApi succeeds',
    build: () {
      final mockLoginUserCase = MockGetLoginUser();
      final tEmail = "eve.holt@reqres.in";
      final tPassword = "cityslicka";
      when(
        () => mockLoginUserCase.login(tEmail, tPassword),
      ).thenAnswer((_) async => Right(AuthToken(token: 'abc')));
      return LoginBloc(loginUserCase: mockLoginUserCase);
    },
    act: (bloc) {
      bloc.add(EmailChanged(email: 'eve.holt@reqres.in'));
      bloc.add(PasswordChanged(password: 'cityslicka'));
      bloc.add(LoginApi());
    },
    expect: () => [
      LoginState(email: 'eve.holt@reqres.in', loginStatus: LoginStatus.initial),
      LoginState(
        email: 'eve.holt@reqres.in',
        password: 'cityslicka',

        loginStatus: LoginStatus.initial,
      ),
      LoginState(
        email: 'eve.holt@reqres.in',
        password: 'cityslicka',
        loginStatus: LoginStatus.loading,
        message: "Submitting login request...",
      ),
      LoginState(
        email: 'eve.holt@reqres.in',
        password: 'cityslicka',
        loginStatus: LoginStatus.success,
        token: 'abc',
        message: 'Login successfully',
      ),
    ],
  );

  //
  blocTest<LoginBloc, LoginState>(
    'emits [loading, failure] when LoginApi fails with invalid credentials',
    build: () {
      final mockLoginUserCase = MockGetLoginUser();
      when(() => mockLoginUserCase.login(any(), any())).thenAnswer(
        (_) async =>
            Left(invalidCredentialFailure('Invalid email or password')),
      );
      return LoginBloc(loginUserCase: mockLoginUserCase);
    },
    act: (bloc) {
      bloc.add(EmailChanged(email: 'wrong@example.com'));
      bloc.add(PasswordChanged(password: 'wrongpass'));
      bloc.add(LoginApi());
    },
    expect: () => [
      LoginState(email: 'wrong@example.com', loginStatus: LoginStatus.initial),
      LoginState(
        email: 'wrong@example.com',
        password: 'wrongpass',
        loginStatus: LoginStatus.initial,
      ),
      LoginState(
        email: 'wrong@example.com',
        password: 'wrongpass',
        loginStatus: LoginStatus.loading,
        message: 'Submitting login request...',
      ),
      LoginState(
        email: 'wrong@example.com',
        password: 'wrongpass',
        loginStatus: LoginStatus.error,
        message: invalidCredentialFailure(
          'invalid email or password',
        ).toString(),
      ),
    ],
  );
}
