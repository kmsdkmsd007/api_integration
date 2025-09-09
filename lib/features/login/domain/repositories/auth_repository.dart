import 'package:dartz/dartz.dart';
import 'package:dummy/core/error/failure.dart';
import 'package:dummy/features/login/data/models/auth_model.dart';
import 'package:dummy/features/login/domain/entities/auth_token.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthTokenModel>> login(String email, String password);
}
