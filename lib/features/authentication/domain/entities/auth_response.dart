import 'package:equatable/equatable.dart';
import 'package:seed/features/authentication/domain/entities/user.dart';

/// Authentication response entity containing user data and token
class AuthResponse extends Equatable {
  final User user;
  final String token;

  const AuthResponse({required this.user, required this.token});

  @override
  List<Object?> get props => [user, token];
}
