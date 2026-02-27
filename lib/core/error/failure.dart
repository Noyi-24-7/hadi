import 'package:equatable/equatable.dart';

/// Base class for domain/data layer failures.
/// Use [Either]<[Failure], T> in data layer operations.
abstract class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server error occurred']);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Network error occurred']);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Cache error occurred']);
}

class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Validation failed']);
}

class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentication failed']);
}
