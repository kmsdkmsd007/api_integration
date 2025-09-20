import 'package:dartz/dartz.dart';
import 'package:dummy/core/error/failure.dart';
import 'package:dummy/features/login/data/datasources/auth_remote_data_source.dart';
import 'package:dummy/features/login/data/models/auth_model.dart';
import 'package:dummy/features/login/domain/entities/auth_token.dart';
import 'package:dummy/features/login/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, AuthTokenModel>> loginWithEmailandPass(
    String email,
    String password,
  ) async {
    try {
      final model = await remoteDataSource.loginWithEmailandPass(
        email,
        password,
      );
      return Right(model);
    } catch (e) {
      return Left(ServerFailure([e.toString()]));
    }
  }
}
