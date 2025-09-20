import 'package:dartz/dartz.dart';
import 'package:dummy/core/error/failure.dart';
import 'package:dummy/features/login/data/models/auth_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthTokenModel>> loginWithEmailandPass(
    String email,
    String password,
  );
}
