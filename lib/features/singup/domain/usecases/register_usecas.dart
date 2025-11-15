import 'package:dartz/dartz.dart';
import 'package:dummy/core/error/failure.dart';
import 'package:dummy/features/singup/domain/entities/sign_up.dart';
import 'package:dummy/features/singup/domain/repositories/sign_up_repository.dart';

class RegisterUsecas implements SignUpRepository {
  final SignUpRepository repository;
  const RegisterUsecas(this.repository);

  @override
  Future<Either<Failure, SignUp>> registerWthEmailandPassword(
    String email,
    String password,
  ) {
    return repository.registerWthEmailandPassword(email, password);
  }
}
