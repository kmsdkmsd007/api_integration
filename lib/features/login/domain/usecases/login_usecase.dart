import 'package:dartz/dartz.dart';
import 'package:dummy/core/error/failure.dart';
import 'package:dummy/core/usecase/usecase.dart';
import 'package:dummy/features/login/domain/repositories/auth_repository.dart';
import 'package:dummy/features/login/domain/entities/auth_token.dart';
import 'package:equatable/equatable.dart';

class LoginUserCase implements Usecase<AuthToken, LoginParms> {
  final AuthRepository repository;
  LoginUserCase(this.repository);
  @override
  Future<Either<Failure, AuthToken>> call(LoginParms parms) async {
    final result = await repository.login(parms.email, parms.password);
    return result;
  }
}

class LoginParms extends Equatable {
  final String email;
  final String password;
  const LoginParms({required this.password, required this.email});

  @override
  List<Object?> get props => [email, password];
}
