import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:seed/core/repositories/base_repository.dart';
import 'package:seed/core/repositories/preferences_repository.dart';
import 'package:seed/features/assessment/data/repositories/assessment_repository_impl.dart';
import 'package:seed/features/assessment/domain/repositories/assessment_repository.dart';
import 'package:seed/features/assessment/domain/usecases/assessment_usecases.dart';
import 'package:seed/features/assessment/presentation/bloc/assessment_bloc.dart';
import 'package:seed/features/authentication/data/datasources/auth_api_service.dart';
import 'package:seed/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:seed/features/authentication/domain/repositories/auth_repository.dart';
import 'package:seed/features/authentication/domain/usecases/login_usecase.dart';
import 'package:seed/features/authentication/domain/usecases/signup_usecase.dart';
import 'package:seed/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service locator for dependency injection
final getIt = GetIt.instance;

/// Initialize all dependencies
Future<void> initializeDependencies() async {
  // Core - SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Core - Repositories
  getIt.registerLazySingleton<IPreferencesRepository>(
    () => PreferencesRepository(getIt<SharedPreferences>()),
  );

  // Core - Dio (HTTP client)
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'http://127.0.0.1:8000',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add interceptors for logging
    dio.interceptors.add(
      LogInterceptor(requestBody: true, responseBody: true, error: true),
    );

    return dio;
  });

  // Feature: Authentication - API Service
  getIt.registerLazySingleton<AuthApiService>(
    () => AuthApiService(getIt<Dio>()),
  );

  // Feature: Authentication - Repository
  getIt.registerLazySingleton<IAuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthApiService>()),
  );

  // Feature: Authentication - Use Cases
  getIt.registerLazySingleton(() => LoginUseCase(getIt()));
  getIt.registerLazySingleton(() => SignUpUseCase(getIt()));

  // Feature: Authentication - BLoC
  getIt.registerFactory(
    () => AuthenticationBloc(
      loginUseCase: getIt(),
      signUpUseCase: getIt(),
      preferencesRepository: getIt(),
    ),
  );

  // Feature: Assessment - Repository
  getIt.registerLazySingleton<IAssessmentRepository>(
    () => AssessmentRepositoryImpl(getIt<IPreferencesRepository>()),
  );

  // Feature: Assessment - Use Cases
  getIt.registerLazySingleton(() => SetAssessmentCompleted(getIt()));
  getIt.registerLazySingleton(() => IsAssessmentCompleted(getIt()));
  getIt.registerLazySingleton(() => GetCompletedAssessmentsCount(getIt()));
  getIt.registerLazySingleton(() => ResetAssessmentProgress(getIt()));
  getIt.registerLazySingleton(() => GetAllAssessments(getIt()));

  // Feature: Assessment - BLoC
  getIt.registerFactory(
    () => AssessmentBloc(
      getCompletedCount: getIt(),
      setAssessmentCompleted: getIt(),
      getAllAssessments: getIt(),
      resetProgress: getIt(),
    ),
  );
}
