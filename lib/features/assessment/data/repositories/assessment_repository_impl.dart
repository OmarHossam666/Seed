import 'package:dartz/dartz.dart';
import 'package:seed/core/error/failures.dart';
import 'package:seed/core/repositories/base_repository.dart';
import 'package:seed/core/utils/logger_service.dart';
import 'package:seed/features/assessment/data/api/question_api.dart';
import 'package:seed/features/assessment/domain/entities/assessment.dart';
import 'package:seed/features/assessment/domain/entities/question_dto.dart';
import 'package:seed/features/assessment/domain/repositories/assessment_repository.dart';

/// Implementation of IAssessmentRepository using local storage
class AssessmentRepositoryImpl implements IAssessmentRepository {
  final IPreferencesRepository preferencesRepository;
  final QuestionApi questionApi; 

  AssessmentRepositoryImpl(this.preferencesRepository, this.questionApi);

  @override
  Future<Either<Failure, List<QuestionDto>>> fetchQuestions(
      String category, String difficulty) async {
    try {
      final questions = await questionApi.fetchQuestions(
         category, difficulty);
      return Right(questions);
    } catch (e, stackTrace) {
      LoggerService.error('Error fetching questions', e, stackTrace);
      return Left(
        CacheFailure(message: 'Error fetching questions: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> setAssessmentCompleted(
    AssessmentType type,
  ) async {
    try {
      LoggerService.debug('Setting assessment completed: ${type.name}');
      final result = await preferencesRepository.setBool(type.key, true);
      if (result) {
        LoggerService.info('Assessment ${type.name} marked as completed');
        return const Right(null);
      } else {
        return const Left(
          CacheFailure(message: 'Failed to save assessment progress'),
        );
      }
    } catch (e, stackTrace) {
      LoggerService.error('Error setting assessment completed', e, stackTrace);
      return Left(
        CacheFailure(message: 'Error saving assessment: ${e.toString()}'),
      );
    }
  }

  @override
  Either<Failure, bool> isAssessmentCompleted(AssessmentType type) {
    try {
      final isCompleted = preferencesRepository.getBool(type.key);
      LoggerService.debug('Assessment ${type.name} completed: $isCompleted');
      return Right(isCompleted);
    } catch (e, stackTrace) {
      LoggerService.error(
        'Error checking assessment completion',
        e,
        stackTrace,
      );
      return Left(
        CacheFailure(message: 'Error checking assessment: ${e.toString()}'),
      );
    }
  }

  @override
  Either<Failure, int> getCompletedAssessmentsCount() {
    try {
      int count = 0;
      for (final type in AssessmentType.values) {
        if (preferencesRepository.getBool(type.key)) {
          count++;
        }
      }
      LoggerService.debug('Completed assessments count: $count');
      return Right(count);
    } catch (e, stackTrace) {
      LoggerService.error(
        'Error getting completed assessments count',
        e,
        stackTrace,
      );
      return Left(
        CacheFailure(message: 'Error counting assessments: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, void>> resetAllProgress() async {
    try {
      LoggerService.debug('Resetting all assessment progress');
      for (final type in AssessmentType.values) {
        await preferencesRepository.remove(type.key);
      }
      LoggerService.info('All assessment progress reset');
      return const Right(null);
    } catch (e, stackTrace) {
      LoggerService.error('Error resetting assessment progress', e, stackTrace);
      return Left(
        CacheFailure(message: 'Error resetting progress: ${e.toString()}'),
      );
    }
  }

  @override
  Either<Failure, List<Assessment>> getAllAssessments() {
    try {
      final assessments = AssessmentType.values.map((type) {
        final isCompleted = preferencesRepository.getBool(type.key);
        return Assessment(
          id: type.key,
          type: type.name,
          isCompleted: isCompleted,
          completedAt: isCompleted ? DateTime.now() : null,
        );
      }).toList();
      return Right(assessments);
    } catch (e, stackTrace) {
      LoggerService.error('Error getting all assessments', e, stackTrace);
      return Left(
        CacheFailure(message: 'Error getting assessments: ${e.toString()}'),
      );
    }
  }
}
