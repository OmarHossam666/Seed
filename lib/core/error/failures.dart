import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

/// Base class for all failures in the application
abstract class Failure extends Equatable {
  final String message;
  final int? code;

  const Failure({required this.message, this.code});

  @override
  List<Object?> get props => [message, code];
}

/// Failure for server-related errors
class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});
}

/// Failure for cache/storage-related errors
class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});
}

/// Failure for network-related errors
class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.code});
}

/// Failure for validation errors
class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, super.code});
}

/// Type alias for results that can fail
typedef Result<T> = Either<Failure, T>;
