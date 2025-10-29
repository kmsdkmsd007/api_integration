import 'package:dartz/dartz.dart';
import 'package:dummy/core/error/failure.dart';
import 'package:dummy/features/login/data/datasources/auht_local_data_source.dart';
import 'package:dummy/features/login/data/datasources/auth_remote_data_source.dart';
import 'package:dummy/features/login/data/models/auth_model.dart';
import 'package:dummy/features/login/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, AuthTokenModel>> loginApi(
    String email,
    String password,
  ) async {
    try {
      final model = await remoteDataSource.loginApi(email, password);
      await localDataSource.cacheUser(model.token as AuthTokenModel);
      final user = AuthTokenModel(token: model.token);
      print(user.token);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure('some thing went wrong'));
    }
  }

  Future<Either<Failure, AuthTokenModel>> getlastUser() async {
    try {
      final user = await localDataSource.getLastUser();
      return Right(user as AuthTokenModel);
    } catch (e) {
      return Left(CacheFailure('No cached user'));
    }
  }

  Future<Either<Failure, void>> clearUserCache() async {
    try {
      await localDataSource.clearUserCache();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to clear cache'));
    }
  }
}
