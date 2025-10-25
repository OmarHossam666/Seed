import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:seed/core/error/failures.dart';
import 'package:seed/core/utils/logger_service.dart';
import 'package:seed/features/authentication/data/datasources/auth_api_service.dart';
import 'package:seed/features/authentication/domain/entities/auth_response.dart';
import 'package:seed/features/authentication/domain/repositories/auth_repository.dart';

/// Implementation of authentication repository
class AuthRepositoryImpl implements IAuthRepository {
  final AuthApiService apiService;

  const AuthRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, AuthResponse>> login({
    required String email,
    required String password,
  }) async {
    try {
      LoggerService.debug('AuthRepository: Attempting login for $email');

      final response = await apiService.login({
        'email': email,
        'password': password,
      });

      LoggerService.info('AuthRepository: Login successful');
      return Right(response.toEntity());
    } on DioException catch (e) {
      LoggerService.error('AuthRepository: Login failed', e);
      return Left(_handleDioError(e));
    } catch (e, stackTrace) {
      LoggerService.error(
        'AuthRepository: Unexpected error during login',
        e,
        stackTrace,
      );
      return Left(
        ServerFailure(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> signUp({
    required String name,
    required int age,
    required String email,
    required String password,
    required String education,
    required String favoriteActivities,
  }) async {
    try {
      LoggerService.debug('AuthRepository: Attempting signup for $email');

      final response = await apiService.signUp({
        'name': name,
        'age': age,
        'email': email,
        'password': password,
        'education': education,
        'favorite_activities': favoriteActivities,
      });

      LoggerService.info('AuthRepository: Signup successful');
      return Right(response.toEntity());
    } on DioException catch (e) {
      LoggerService.error('AuthRepository: Signup failed', e);
      return Left(_handleDioError(e));
    } catch (e, stackTrace) {
      LoggerService.error(
        'AuthRepository: Unexpected error during signup',
        e,
        stackTrace,
      );
      return Left(
        ServerFailure(message: 'An unexpected error occurred: ${e.toString()}'),
      );
    }
  }

  /// Handle Dio errors and convert to appropriate Failure types
  Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure(
          message: 'Connection timeout. Please check your internet connection.',
        );
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message =
            error.response?.data?['message'] ?? 'Server error occurred';
        return ServerFailure(message: message, code: statusCode);
      case DioExceptionType.cancel:
        return const NetworkFailure(message: 'Request was cancelled');
      case DioExceptionType.connectionError:
        return const NetworkFailure(
          message:
              'No internet connection. Please check your network settings.',
        );
      default:
        return ServerFailure(
          message: error.message ?? 'An unknown error occurred',
        );
    }
  }
}
