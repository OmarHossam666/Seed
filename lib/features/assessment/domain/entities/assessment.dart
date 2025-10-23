import 'package:equatable/equatable.dart';

/// Assessment entity representing a completed assessment
class Assessment extends Equatable {
  final String id;
  final String type;
  final bool isCompleted;
  final DateTime? completedAt;

  const Assessment({
    required this.id,
    required this.type,
    required this.isCompleted,
    this.completedAt,
  });

  @override
  List<Object?> get props => [id, type, isCompleted, completedAt];

  Assessment copyWith({
    String? id,
    String? type,
    bool? isCompleted,
    DateTime? completedAt,
  }) {
    return Assessment(
      id: id ?? this.id,
      type: type ?? this.type,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}

/// Assessment types enum
enum AssessmentType {
  mcq,
  essay,
  softSkills;

  String get key {
    switch (this) {
      case AssessmentType.mcq:
        return 'mcq_completed';
      case AssessmentType.essay:
        return 'essay_completed';
      case AssessmentType.softSkills:
        return 'soft_skills_completed';
    }
  }
}
