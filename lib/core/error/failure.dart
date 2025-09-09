import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  const Failure({this.properties = const <dynamic>[]});
}

class ServerFailure extends Failure {
  const ServerFailure(List<String> list);

  @override
  List<Object?> get props => [];
}

class SyntextFailure extends Failure {
  const SyntextFailure(List<String> list);
  @override
  List<Object?> get props => [];
}

class EmptyFailure extends Failure {
  const EmptyFailure(List<String> list);
  @override
  List<Object?> get props => [];
}
