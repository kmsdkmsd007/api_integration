import 'package:dartz/dartz.dart';
import 'package:dummy/core/error/failure.dart';
import 'package:dummy/features/users/domain/entities/user.dart';
import 'package:dummy/features/users/domain/repositories/user_repository.dart';

class FetchUsecas implements UserRepository {
  final UserRepository repository;
  const FetchUsecas(this.repository);
  @override
  Future<Either<Failure, List<User>>> fetchUser() async {
    return repository.fetchUser();
  }
}
