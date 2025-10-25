import 'package:dartz/dartz.dart';
import 'package:seed/core/error/failures.dart';
import 'package:seed/features/assessment/domain/entities/assessment.dart';
import 'package:seed/features/assessment/domain/entities/question_dto.dart';

/// Repository interface for assessment operations
abstract class IAssessmentRepository {
  /// Mark an assessment as completed
  Future<Either<Failure, void>> setAssessmentCompleted(AssessmentType type);

  /// Check if an assessment is completed
  Either<Failure, bool> isAssessmentCompleted(AssessmentType type);

  /// Get the count of completed assessments
  Either<Failure, int> getCompletedAssessmentsCount();

  /// Reset all assessment progress
  Future<Either<Failure, void>> resetAllProgress();

  /// Get all assessments with their completion status
  Either<Failure, List<Assessment>> getAllAssessments();

  Future<Either<Failure, List<QuestionDto>>> fetchQuestions(
      String category, String difficulty);
}
