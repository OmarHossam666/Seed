import 'package:equatable/equatable.dart';
import 'package:seed/features/assessment/domain/entities/assessment.dart';

/// Base class for all assessment events
abstract class AssessmentEvent extends Equatable {
  const AssessmentEvent();

  @override
  List<Object?> get props => [];
}

/// Event to load assessment progress
class LoadAssessmentProgress extends AssessmentEvent {
  const LoadAssessmentProgress();
}

/// Event to complete an assessment
class CompleteAssessment extends AssessmentEvent {
  final AssessmentType type;

  const CompleteAssessment(this.type);

  @override
  List<Object?> get props => [type];
}

/// Event to reset all assessment progress
class ResetAllAssessments extends AssessmentEvent {
  const ResetAllAssessments();
}

/// Event to check if all assessments are completed
class CheckAllAssessmentsCompleted extends AssessmentEvent {
  const CheckAllAssessmentsCompleted();
}
