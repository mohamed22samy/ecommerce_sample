import 'package:equatable/equatable.dart';

abstract class Failure<T> extends Equatable {
  final T error;
  const Failure(this.error);

  @override
  List<Object> get props => [];

}

class ServerFailure<T> extends Failure<T> {
  const ServerFailure(super.error);
}
class UnauthenticatedServerFailure<T> extends Failure<T> {
  const UnauthenticatedServerFailure(super.error);
}

class DatabaseFailure<T> extends Failure<T> {
  const DatabaseFailure(super.error);
}
