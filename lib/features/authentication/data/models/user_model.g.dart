// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map json) => UserModel(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  age: (json['age'] as num).toInt(),
  email: json['email'] as String,
  education: json['education'] as String,
  favoriteActivities: json['favorite_activities'] as String,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'age': instance.age,
  'email': instance.email,
  'education': instance.education,
  'favorite_activities': instance.favoriteActivities,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};
