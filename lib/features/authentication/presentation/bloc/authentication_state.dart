import 'package:equatable/equatable.dart';

/// Base class for all authentication states
abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial();
}

/// Loading state
class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading();
}

/// Authenticated state
class Authenticated extends AuthenticationState {
  final String userId;
  final String userName;
  final String email;

  const Authenticated({
    required this.userId,
    required this.userName,
    required this.email,
  });

  @override
  List<Object?> get props => [userId, userName, email];
}

/// Unauthenticated state
class Unauthenticated extends AuthenticationState {
  const Unauthenticated();
}

/// Login success
class LoginSuccess extends AuthenticationState {
  final String message;

  const LoginSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// Signup success
class SignUpSuccess extends AuthenticationState {
  final String message;

  const SignUpSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// Authentication error
class AuthenticationError extends AuthenticationState {
  final String message;

  const AuthenticationError(this.message);

  @override
  List<Object?> get props => [message];
}
