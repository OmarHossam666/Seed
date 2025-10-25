import 'package:get_it/get_it.dart';
import 'package:seed/core/repositories/base_repository.dart';
import 'package:seed/core/repositories/preferences_repository.dart';
import 'package:seed/features/assessment/data/repositories/assessment_repository_impl.dart';
import 'package:seed/features/assessment/domain/repositories/assessment_repository.dart';
import 'package:seed/features/assessment/domain/usecases/assessment_usecases.dart';
import 'package:seed/features/assessment/presentation/bloc/assessment_bloc.dart';
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

  // Feature: Assessment - Repository
  getIt.registerLazySingleton<IAssessmentRepository>(
    () => AssessmentRepositoryImpl(getIt<IPreferencesRepository>(), getIt()),
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
      fetchQuestions: getIt(),
    ),
  );

  // Feature: Authentication - BLoC
  getIt.registerFactory(() => AuthenticationBloc());
}
