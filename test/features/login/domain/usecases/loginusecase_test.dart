// import 'package:dartz/dartz.dart';
// import 'package:dummy/core/error/failure.dart';
// import 'package:dummy/features/login/data/models/auth_model.dart';
// import 'package:dummy/features/login/domain/entities/auth_token.dart';
// import 'package:dummy/features/login/domain/usecases/login_usecase.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:dummy/features/login/domain/repositories/auth_repository.dart';

// class MockAuthRepository extends Mock implements AuthRepository {}

// void main() {
//   late LoginUserCase loginUserCase;
//   late MockAuthRepository mockAuthRepository;
//   setUp(() {
//     mockAuthRepository = MockAuthRepository();
//     loginUserCase = LoginUserCase(mockAuthRepository);
//   });

//   test('should success fully login ', () async {
//     const token = AuthTokenModel(token: 'khan@gmail.com', error: '');
//     when(
//       () => mockAuthRepository.loginApi('khan@gmail.com', 'password'),
//     ).thenAnswer((_) async => Right(token));

//     final result = await loginUserCase(
//       const LoginParms(password: 'password', email: 'khan@gmail.com'),
//     );
//     expect(result, Right(token));
//     verify(() => mockAuthRepository.loginApi('khan@gmail.com', 'password'));
//   });
// }
