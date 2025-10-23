import 'package:dartz/dartz.dart';
import 'package:seed/core/error/failures.dart';
import 'package:seed/features/assessment/domain/entities/assessment.dart';
import 'package:seed/features/assessment/domain/repositories/assessment_repository.dart';

/// Use case for setting an assessment as completed
class SetAssessmentCompleted {
  final IAssessmentRepository repository;

  SetAssessmentCompleted(this.repository);

  Future<Either<Failure, void>> call(AssessmentType type) async {
    return await repository.setAssessmentCompleted(type);
  }
}

/// Use case for checking if an assessment is completed
class IsAssessmentCompleted {
  final IAssessmentRepository repository;

  IsAssessmentCompleted(this.repository);

  Either<Failure, bool> call(AssessmentType type) {
    return repository.isAssessmentCompleted(type);
  }
}

/// Use case for getting completed assessments count
class GetCompletedAssessmentsCount {
  final IAssessmentRepository repository;

  GetCompletedAssessmentsCount(this.repository);

  Either<Failure, int> call() {
    return repository.getCompletedAssessmentsCount();
  }
}

/// Use case for resetting all assessment progress
class ResetAssessmentProgress {
  final IAssessmentRepository repository;

  ResetAssessmentProgress(this.repository);

  Future<Either<Failure, void>> call() async {
    return await repository.resetAllProgress();
  }
}

/// Use case for getting all assessments
class GetAllAssessments {
  final IAssessmentRepository repository;

  GetAllAssessments(this.repository);

  Either<Failure, List<Assessment>> call() {
    return repository.getAllAssessments();
  }
}
