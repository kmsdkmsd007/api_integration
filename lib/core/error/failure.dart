import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final List properties;
  const Failure({this.properties = const <dynamic>[]});
}



class ServerFailure extends Failure{
  @override
  List<Object?> get props => [];
}

class SyntextFailure extends Failure{
  @override
  List<Object?> get props => [];
}