import 'package:dartz/dartz.dart';
import 'package:dummy/core/error/failure.dart';

abstract class Usecase<type, parms> {
  Future<Either<Failure, type>> call(parms parms);
}
