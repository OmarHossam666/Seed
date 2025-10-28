// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionDto _$QuestionDtoFromJson(Map json) => QuestionDto(
  message: json['message'] as String,
  user: UserModel.fromJson(Map<String, dynamic>.from(json['user'] as Map)),
);

Map<String, dynamic> _$QuestionDtoToJson(QuestionDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'user': instance.user.toJson(),
    };
