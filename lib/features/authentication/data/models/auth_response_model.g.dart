// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponseModel _$AuthResponseModelFromJson(Map json) => AuthResponseModel(
  user: UserModel.fromJson(Map<String, dynamic>.from(json['user'] as Map)),
  token: json['token'] as String,
);

Map<String, dynamic> _$AuthResponseModelToJson(AuthResponseModel instance) =>
    <String, dynamic>{'user': instance.user.toJson(), 'token': instance.token};
