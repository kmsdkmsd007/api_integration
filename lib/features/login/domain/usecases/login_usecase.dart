import 'package:dartz/dartz.dart';
import 'package:dummy/core/error/failure.dart';
import 'package:dummy/features/login/data/models/auth_model.dart';
import 'package:dummy/features/login/domain/repositories/auth_repository.dart';
import 'package:dummy/features/login/domain/entities/auth_token.dart';

class LoginUserCase {
  final AuthRepository repository;
  LoginUserCase(this.repository);

  Future<Either<Failure, AuthToken>> login(
    String email,
    String password,
  ) async {
    return await repository.loginApi(email, password);
  }

  Future<Either<Failure, AuthTokenModel>> getlastUser() {
    return repository.getlastUser();
  }

  Future<Either<Failure, void>> clearUserCache() {
    return repository.clearUserCache();
  }
}
