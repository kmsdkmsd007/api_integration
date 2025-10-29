import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure();
}

class ServerFailure extends Failure {
  const ServerFailure(this.message);
  final String message;

  @override
  List<Object?> get props => [];
}

class invalidCredentialFailure extends Failure {
  const invalidCredentialFailure(this.message);
  final String message;

  @override
  List<Object?> get props => [];
}

class CacheFailure extends Failure {
  const CacheFailure(this.message);
  final String message;

  @override
  List<Object?> get props => [];
}
