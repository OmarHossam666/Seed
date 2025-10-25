import 'package:dartz/dartz.dart';
import 'package:seed/core/error/failures.dart';
import 'package:seed/features/authentication/domain/entities/auth_response.dart';
import 'package:seed/features/authentication/domain/repositories/auth_repository.dart';

/// Use case for user login
class LoginUseCase {
  final IAuthRepository repository;

  const LoginUseCase(this.repository);

  /// Execute login with email and password
  Future<Either<Failure, AuthResponse>> call({
    required String email,
    required String password,
  }) async {
    return await repository.login(email: email, password: password);
  }
}
