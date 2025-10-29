import 'package:dartz/dartz.dart';
import 'package:dummy/core/error/failure.dart';
import 'package:dummy/features/login/data/models/auth_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthTokenModel>> loginApi(
    String email,
    String password,
  );
  Future<Either<Failure, AuthTokenModel>> getlastUser();
  Future<Either<Failure, void>> clearUserCache();
}
