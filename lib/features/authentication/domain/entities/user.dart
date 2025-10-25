import 'package:equatable/equatable.dart';

/// User entity representing a user in the system
class User extends Equatable {
  final int id;
  final String name;
  final int age;
  final String email;
  final String education;
  final String favoriteActivities;
  final String createdAt;
  final String updatedAt;

  const User({
    required this.id,
    required this.name,
    required this.age,
    required this.email,
    required this.education,
    required this.favoriteActivities,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    age,
    email,
    education,
    favoriteActivities,
    createdAt,
    updatedAt,
  ];
}
