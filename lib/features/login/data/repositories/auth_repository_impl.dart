import 'package:dartz/dartz.dart';
import 'package:dummy/core/error/failure.dart';
import 'package:dummy/features/login/data/datasources/auth_remote_data_source.dart';
import 'package:dummy/features/login/data/models/auth_model.dart';
import 'package:dummy/features/login/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AuthTokenModel>> loginApi(
    String email,
    String password,
  ) async {
    try {
      final model = await remoteDataSource.loginApi(email, password);
      final user = AuthTokenModel(token: model.token);
      print(user.token);
      return Right(user);
    } catch (e) {
      return Left(ServerFailure('some thing went wrong'));
    }
  }
}
