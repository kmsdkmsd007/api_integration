import 'package:dartz/dartz.dart';
import 'package:dummy/core/error/failure.dart';
import 'package:dummy/features/singup/data/models/sign_up_model.dart';

abstract class SignUpRepository {
  Future<Either<Failure, SignUpModel>> registerWthEmailandPassword(
    String email,
    String password,
  );
}
