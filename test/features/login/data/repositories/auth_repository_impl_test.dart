import 'package:dummy/features/login/data/models/auth_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dummy/features/login/data/repositories/auth_repository_impl.dart';
import 'package:dummy/features/login/data/datasources/auth_remote_data_source.dart';
import 'package:dummy/core/error/failure.dart';
import 'package:dartz/dartz.dart';

class MockRemoteDataSource extends Mock implements AuthRemoteDataSource {}

void main() {
  late AuthRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    repository = AuthRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  const tEmail = 'test@example.com';
  const tPassword = 'password123';
  final tAuthToken = AuthTokenModel(token: 'token123');

  test('should return AuthToken on successful login', () async {
    when(
      () => mockRemoteDataSource.loginApi(tEmail, tPassword),
    ).thenAnswer((_) async => tAuthToken);

    final result = await repository.loginApi(tEmail, tPassword);

    expect(result, Right(tAuthToken));
    verify(() => mockRemoteDataSource.loginApi(tEmail, tPassword)).called(1);
  });

  test('should return ServerFailure on exception', () async {
    when(
      () => mockRemoteDataSource.loginApi(tEmail, tPassword),
    ).thenThrow(Exception('Failed'));

    final result = await repository.loginApi(tEmail, tPassword);

    expect(result, isA<Left>());
    expect((result as Left).value, isA<ServerFailure>());
    verify(() => mockRemoteDataSource.loginApi(tEmail, tPassword)).called(1);
  });
}
