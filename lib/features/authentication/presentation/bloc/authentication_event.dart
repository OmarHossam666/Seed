import 'package:equatable/equatable.dart';

/// Base class for all authentication events
abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object?> get props => [];
}

/// Event to login with email and password
class LoginRequested extends AuthenticationEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

/// Event to signup
class SignUpRequested extends AuthenticationEvent {
  final String name;
  final String email;
  final String password;
  final String age;
  final String education;

  const SignUpRequested({
    required this.name,
    required this.email,
    required this.password,
    required this.age,
    required this.education,
  });

  @override
  List<Object?> get props => [name, email, password, age, education];
}

/// Event to logout
class LogoutRequested extends AuthenticationEvent {
  const LogoutRequested();
}

/// Event to check authentication status
class CheckAuthenticationStatus extends AuthenticationEvent {
  const CheckAuthenticationStatus();
}
