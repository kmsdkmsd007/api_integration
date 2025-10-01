import 'package:dartz/dartz.dart';
import 'package:dummy/core/error/failure.dart';
import 'package:dummy/features/singup/data/models/sign_up_model.dart';
import 'package:dummy/features/singup/domain/repositories/sign_up_repository.dart';

class RegisterUsecas implements SignUpRepository {
  final SignUpRepository repository;
  const RegisterUsecas(this.repository);

  @override
  Future<Either<Failure, SignUpModel>> registerWthEmailandPassword(
    String email,
    String password,
  ) {
    return repository.registerWthEmailandPassword(email, password);
  }
}
