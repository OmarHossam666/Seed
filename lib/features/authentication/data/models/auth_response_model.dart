import 'package:json_annotation/json_annotation.dart';
import 'package:seed/features/authentication/data/models/user_model.dart';
import 'package:seed/features/authentication/domain/entities/auth_response.dart';

part 'auth_response_model.g.dart';

/// Authentication response model for JSON serialization
@JsonSerializable(explicitToJson: true)
class AuthResponseModel {
  final UserModel user;
  final String token;

  const AuthResponseModel({required this.user, required this.token});

  /// Create AuthResponseModel from JSON
  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  /// Convert AuthResponseModel to JSON
  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);

  /// Convert to domain entity
  AuthResponse toEntity() => AuthResponse(user: user.toEntity(), token: token);
}
