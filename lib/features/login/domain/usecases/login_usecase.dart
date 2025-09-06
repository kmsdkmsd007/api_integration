// import 'package:dartz/dartz.dart';
// import 'package:dummy/core/error/failure.dart';
// import 'package:dummy/core/usecase/usecase.dart';
// import 'package:dummy/features/login/domain/repositories/auth_repository.dart';
// import 'package:dummy/features/login/domain/entities/user.dart';
// import 'package:equatable/equatable.dart';

// class LoginUserCase implements Usecase<User, LoginParams> {
//   final AuthRepository repository;
//   LoginUserCase(this.repository);
//   @override
//   Future<Either<Failure, User>> call(String email, String password) async {
//     final result = await repository.login(email, password);
//     return result.fold(
//       (error) => Left(Failure(error.toString())),
//       (user) => Right(user),
//     );
//   }
// }

// class LoginParams extends Equatable {
//   final String email;
//   final String password;

// const  LoginParams({required this.email, required this.password});

//   @override
//   List<Object?> get props => [email, password];
// }
