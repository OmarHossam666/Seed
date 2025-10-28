import 'package:json_annotation/json_annotation.dart';
import 'package:seed/features/authentication/data/models/user_model.dart';

part 'question_dto.g.dart';

@JsonSerializable()
class QuestionDto{
final String message;
final UserModel user;

  const QuestionDto({

    required this.message,
    required this.user,
  
  });

  factory QuestionDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionDtoToJson(this);
}