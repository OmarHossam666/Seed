import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:seed/core/utils/logger_service.dart';
import 'package:seed/features/assessment/domain/entities/assessment.dart';
import 'package:seed/features/assessment/domain/usecases/assessment_usecases.dart';
import 'package:seed/features/assessment/presentation/bloc/assessment_event.dart';
import 'package:seed/features/assessment/presentation/bloc/assessment_state.dart' hide FetchQuestionsEvent;

/// BLoC for managing assessment state
class AssessmentBloc extends Bloc<AssessmentEvent, AssessmentState> {
  final GetCompletedAssessmentsCount getCompletedCount;
  final SetAssessmentCompleted setAssessmentCompleted;
  final GetAllAssessments getAllAssessments;
  final ResetAssessmentProgress resetProgress;
  final FetchQuestions fetchQuestions;

  AssessmentBloc({
    required this.getCompletedCount,
    required this.setAssessmentCompleted,
    required this.getAllAssessments,
    required this.resetProgress,
    required this.fetchQuestions,
  }) : super(const AssessmentInitial()) {
    // Register event handlers
    on<LoadAssessmentProgress>(_onLoadProgress, transformer: restartable());
    on<CompleteAssessment>(_onCompleteAssessment, transformer: sequential());
    on<ResetAllAssessments>(_onResetProgress, transformer: droppable());
    on<CheckAllAssessmentsCompleted>(_onCheckAllCompleted);
    on<FetchQuestionsEvent>(_onFetchQuestions);
  }

  /// Handle loading assessment progress
  Future<void> _onLoadProgress(
    LoadAssessmentProgress event,
    Emitter<AssessmentState> emit,
  ) async {
    try {
      LoggerService.debug('AssessmentBloc: Loading progress');
      emit(const AssessmentLoading());

      // Get completed count
      final countResult = getCompletedCount();

      await countResult.fold(
        (failure) async {
          LoggerService.error(
            'AssessmentBloc: Failed to load count - ${failure.message}',
          );
          emit(AssessmentError(failure.message));
        },
        (count) async {
          LoggerService.info('AssessmentBloc: Loaded count - $count');

          // Get all assessments
          final assessmentsResult = getAllAssessments();

          assessmentsResult.fold(
            (failure) {
              LoggerService.error(
                'AssessmentBloc: Failed to load assessments - ${failure.message}',
              );
              emit(AssessmentError(failure.message));
            },
            (assessments) {
              final totalCount = AssessmentType.values.length;
              final allCompleted = count == totalCount;

              LoggerService.info(
                'AssessmentBloc: All completed - $allCompleted',
              );

              emit(
                AssessmentLoaded(
                  completedCount: count,
                  totalCount: totalCount,
                  assessments: assessments,
                  allCompleted: allCompleted,
                ),
              );
            },
          );
        },
      );
    } catch (e, stackTrace) {
      LoggerService.error(
        'AssessmentBloc: Exception in _onLoadProgress',
        e,
        stackTrace,
      );
      emit(AssessmentError('Failed to load progress: ${e.toString()}'));
    }
  }

  /// Handle completing an assessment
  Future<void> _onCompleteAssessment(
    CompleteAssessment event,
    Emitter<AssessmentState> emit,
  ) async {
    try {
      LoggerService.debug(
        'AssessmentBloc: Completing assessment - ${event.type.name}',
      );

      final result = await setAssessmentCompleted(event.type);

      await result.fold(
        (failure) async {
          LoggerService.error(
            'AssessmentBloc: Failed to complete assessment - ${failure.message}',
          );
          emit(AssessmentError(failure.message));
        },
        (_) async {
          LoggerService.info(
            'AssessmentBloc: Assessment completed - ${event.type.name}',
          );

          // Reload progress after completion
          final countResult = getCompletedCount();

          countResult.fold(
            (failure) {
              emit(AssessmentError(failure.message));
            },
            (count) {
              emit(
                AssessmentCompleted(type: event.type, completedCount: count),
              );

              // Immediately load updated progress
              add(const LoadAssessmentProgress());
            },
          );
        },
      );
    } catch (e, stackTrace) {
      LoggerService.error(
        'AssessmentBloc: Exception in _onCompleteAssessment',
        e,
        stackTrace,
      );
      emit(AssessmentError('Failed to complete assessment: ${e.toString()}'));
    }
  }

  /// Handle resetting all progress
  Future<void> _onResetProgress(
    ResetAllAssessments event,
    Emitter<AssessmentState> emit,
  ) async {
    try {
      LoggerService.debug('AssessmentBloc: Resetting progress');
      emit(const AssessmentLoading());

      final result = await resetProgress();

      result.fold(
        (failure) {
          LoggerService.error(
            'AssessmentBloc: Failed to reset - ${failure.message}',
          );
          emit(AssessmentError(failure.message));
        },
        (_) {
          LoggerService.info('AssessmentBloc: Reset successful');
          emit(const AssessmentReset());

          // Reload progress after reset
          add(const LoadAssessmentProgress());
        },
      );
    } catch (e, stackTrace) {
      LoggerService.error(
        'AssessmentBloc: Exception in _onResetProgress',
        e,
        stackTrace,
      );
      emit(AssessmentError('Failed to reset progress: ${e.toString()}'));
    }
  }

  /// Check if all assessments are completed
  Future<void> _onCheckAllCompleted(
    CheckAllAssessmentsCompleted event,
    Emitter<AssessmentState> emit,
  ) async {
    try {
      final countResult = getCompletedCount();

      countResult.fold(
        (failure) {
          emit(AssessmentError(failure.message));
        },
        (count) {
          final totalCount = AssessmentType.values.length;
          final allCompleted = count == totalCount;

          if (state is AssessmentLoaded) {
            final currentState = state as AssessmentLoaded;
            emit(
              currentState.copyWith(
                completedCount: count,
                allCompleted: allCompleted,
              ),
            );
          }
        },
      );
    } catch (e, stackTrace) {
      LoggerService.error(
        'AssessmentBloc: Exception in _onCheckAllCompleted',
        e,
        stackTrace,
      );
      emit(AssessmentError('Failed to check completion: ${e.toString()}'));
    }
  }
  /// Handle fetching questions
  Future<void> _onFetchQuestions(
    FetchQuestionsEvent event,
    Emitter<AssessmentState> emit,
  ) async {
    try {
      LoggerService.debug(
        'AssessmentBloc: Fetching questions - Category: ${event.category}, Difficulty: ${event.difficulty}',
      );
      emit(const AssessmentLoading());

      final result = await fetchQuestions(event.category, event.difficulty);

      result.fold(
        (failure) {
          LoggerService.error(
            'AssessmentBloc: Failed to fetch questions - ${failure.message}',
          );
          emit(AssessmentError(failure.message));
        },
        (questions) {
          LoggerService.info(
            'AssessmentBloc: Fetched ${questions.length} questions',
          );
          emit(QuestionsFetched(questions));
        },
      );
    } catch (e, stackTrace) {
      LoggerService.error(
        'AssessmentBloc: Exception in _onFetchQuestions',
        e,
        stackTrace,
      );
      emit(AssessmentError('Failed to fetch questions: ${e.toString()}'));
    }
  }
}
