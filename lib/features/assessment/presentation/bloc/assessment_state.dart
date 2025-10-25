import 'package:equatable/equatable.dart';
import 'package:seed/features/assessment/domain/entities/assessment.dart';
import 'package:seed/features/assessment/domain/entities/question_dto.dart';

/// Base class for all assessment states
abstract class AssessmentState extends Equatable {
  const AssessmentState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class AssessmentInitial extends AssessmentState {
  const AssessmentInitial();
}

/// Loading state
class AssessmentLoading extends AssessmentState {
  const AssessmentLoading();
}

/// Loaded state with progress information
class AssessmentLoaded extends AssessmentState {
  final int completedCount;
  final int totalCount;
  final List<Assessment> assessments;
  final bool allCompleted;

  const AssessmentLoaded({
    required this.completedCount,
    required this.totalCount,
    required this.assessments,
    required this.allCompleted,
  });

  @override
  List<Object?> get props => [
    completedCount,
    totalCount,
    assessments,
    allCompleted,
  ];

  AssessmentLoaded copyWith({
    int? completedCount,
    int? totalCount,
    List<Assessment>? assessments,
    bool? allCompleted,
  }) {
    return AssessmentLoaded(
      completedCount: completedCount ?? this.completedCount,
      totalCount: totalCount ?? this.totalCount,
      assessments: assessments ?? this.assessments,
      allCompleted: allCompleted ?? this.allCompleted,
    );
  }
}

/// Assessment completed successfully
class AssessmentCompleted extends AssessmentState {
  final AssessmentType type;
  final int completedCount;

  const AssessmentCompleted({required this.type, required this.completedCount});

  @override
  List<Object?> get props => [type, completedCount];
}

/// Error state
class AssessmentError extends AssessmentState {
  final String message;

  const AssessmentError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Reset successful
class AssessmentReset extends AssessmentState {
  const AssessmentReset();
}

/// Questions fetched successfully
class QuestionsFetched extends AssessmentState {
  final List<QuestionDto> questions;

  const QuestionsFetched(this.questions);

  @override
  List<Object?> get props => [questions];
}
/// Use case for fetching questions
class FetchQuestionsEvent {
  final String category;
  final String difficulty;

  const FetchQuestionsEvent({
    required this.category,
    required this.difficulty,
  });
}
