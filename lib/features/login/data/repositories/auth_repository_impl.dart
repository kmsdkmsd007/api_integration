import 'package:dartz/dartz.dart';
import 'package:dummy/core/error/failure.dart';
import 'package:dummy/core/network/network_info.dart';
import 'package:dummy/features/login/data/datasources/auht_local_data_source.dart';
import 'package:dummy/features/login/data/datasources/auth_remote_data_source.dart';
import 'package:dummy/features/login/data/models/auth_model.dart';
import 'package:dummy/features/login/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AuthTokenModel>> loginApi(
    String email,
    String password,
  ) async {
    return await getUserToken(() => remoteDataSource.loginApi(email, password));
  }

  Future<Either<Failure, AuthTokenModel>> getUserToken(
    Future<AuthTokenModel> Function() getChachedToken,
  ) async {
    if (await networkInfo.isconnetted()) {
      try {
        final token = await getChachedToken();
        await localDataSource.cacheUser(token);
        return Right(token);
      } catch (e) {
        return Left(CacheFailure('No cached user'));
      }
    } else {
      final token = await localDataSource.getLastUser();
      return Right(token as AuthTokenModel);
    }
  }

  @override
  Future<Either<Failure, void>> clearUserCache() async {
    try {
      await localDataSource.clearUserCache();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Failed to clear cache'));
    }
  }

  @override
  Future<Either<Failure, AuthTokenModel>> getlastUser() {
    return getUserToken(
      () async => (await localDataSource.getLastUser()) as AuthTokenModel,
    );
  }
}
