import 'package:dartz/dartz.dart';
import 'package:seed/core/error/failures.dart';
import 'package:seed/features/authentication/domain/entities/auth_response.dart';

/// Authentication repository interface
abstract class IAuthRepository {
  /// Login with email and password
  /// Returns [AuthResponse] on success or [Failure] on error
  Future<Either<Failure, AuthResponse>> login({
    required String email,
    required String password,
  });

  /// Sign up a new user
  /// Returns [AuthResponse] on success or [Failure] on error
  Future<Either<Failure, AuthResponse>> signUp({
    required String name,
    required int age,
    required String email,
    required String password,
    required String education,
    required String favoriteActivities,
  });
}
