import 'package:json_annotation/json_annotation.dart';
import 'package:seed/features/authentication/domain/entities/user.dart';

part 'user_model.g.dart';

/// User model for JSON serialization
@JsonSerializable(fieldRename: FieldRename.snake)
class UserModel {
  final int id;
  final String name;
  final int age;
  final String email;
  final String education;
  final String favoriteActivities;
  final String createdAt;
  final String updatedAt;

  const UserModel({
    required this.id,
    required this.name,
    required this.age,
    required this.email,
    required this.education,
    required this.favoriteActivities,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Convert UserModel to JSON
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  /// Convert to domain entity
  User toEntity() => User(
    id: id,
    name: name,
    age: age,
    email: email,
    education: education,
    favoriteActivities: favoriteActivities,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
