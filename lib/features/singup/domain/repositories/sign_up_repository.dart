import 'package:dartz/dartz.dart';
import 'package:dummy/core/error/failure.dart';
import 'package:dummy/features/singup/domain/entities/sign_up.dart';

abstract class SignUpRepository {
  Future<Either<Failure, SignUp>> registerWthEmailandPassword(
    String email,
    String password,
  );
}
