import 'package:dartz/dartz.dart';
import 'package:dummy/core/error/failure.dart';
import 'package:dummy/features/users/data/datasources/user_remote_data_source.dart';
import 'package:dummy/features/users/domain/entities/user.dart';
import 'package:dummy/features/users/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<User>>> fetchUser() async {
    try {
      final users = await remoteDataSource.getAllUsers();
      final userList = users
          .map(
            (e) => User(
              id: e.id,
              email: e.email,
              firstName: e.firstName,
              lastName: e.lastName,
              avatar: e.avatar,
            ),
          )
          .toList();
      return Right(userList);
    } catch (e) {
      print(e.toString());
      return left(ServerFailure(e.toString()));
    }
  }
}
