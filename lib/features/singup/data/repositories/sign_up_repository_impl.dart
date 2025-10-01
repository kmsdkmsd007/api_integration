import 'package:dartz/dartz.dart';
import 'package:dummy/core/error/failure.dart';
import 'package:dummy/features/singup/data/datasources/signup_remote_data_source.dart';
import 'package:dummy/features/singup/data/models/sign_up_model.dart';
import 'package:dummy/features/singup/domain/repositories/sign_up_repository.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignupRemoteDataSource remoteDataSource;
  const SignUpRepositoryImpl({required this.remoteDataSource});
  @override
  Future<Either<Failure, SignUpModel>> registerWthEmailandPassword(
    String email,
    String password,
  ) async {
    try {
      final model = await remoteDataSource.registerWithEmailPassword(
        email,
        password,
      );
      final user = SignUpModel(id: model.id, token: model.token);
      return Right(user);
    } catch (e) {
      return left(ServerFailure('something went wronge'));
    }
  }
}
