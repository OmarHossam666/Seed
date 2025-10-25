import 'package:dartz/dartz.dart';
import 'package:seed/core/error/failures.dart';
import 'package:seed/features/authentication/domain/entities/auth_response.dart';
import 'package:seed/features/authentication/domain/repositories/auth_repository.dart';

/// Use case for user signup
class SignUpUseCase {
  final IAuthRepository repository;

  const SignUpUseCase(this.repository);

  /// Execute signup with user details
  Future<Either<Failure, AuthResponse>> call({
    required String name,
    required int age,
    required String email,
    required String password,
    required String education,
    required String favoriteActivities,
  }) async {
    return await repository.signUp(
      name: name,
      age: age,
      email: email,
      password: password,
      education: education,
      favoriteActivities: favoriteActivities,
    );
  }
}
