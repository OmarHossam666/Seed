import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_dto.g.dart';

@JsonSerializable()
class QuestionDto extends Equatable {
final String message;
final User user;
  const QuestionDto({

    required this.message,
    required this.user,
  
  });

  factory QuestionDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionDtoToJson(this);
}