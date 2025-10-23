import 'package:bloc/bloc.dart';
import 'package:seed/core/utils/logger_service.dart';
import 'package:seed/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:seed/features/authentication/presentation/bloc/authentication_state.dart';

/// BLoC for managing authentication state
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(const AuthenticationInitial()) {
    // Register event handlers
    on<LoginRequested>(_onLoginRequested);
    on<SignUpRequested>(_onSignUpRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthenticationStatus>(_onCheckAuthStatus);
  }

  /// Handle login request
  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      LoggerService.debug(
        'AuthenticationBloc: Login requested for ${event.email}',
      );
      emit(const AuthenticationLoading());

      // Simulate authentication delay
      await Future.delayed(const Duration(milliseconds: 500));

      // TODO: Implement actual authentication logic
      // For now, we'll simulate a successful login

      LoggerService.info('AuthenticationBloc: Login successful');

      emit(
        Authenticated(
          userId: 'user_123',
          userName: 'Demo User',
          email: event.email,
        ),
      );

      emit(const LoginSuccess('Login successful!'));
    } catch (e, stackTrace) {
      LoggerService.error('AuthenticationBloc: Login failed', e, stackTrace);
      emit(AuthenticationError('Login failed: ${e.toString()}'));
    }
  }

  /// Handle signup request
  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      LoggerService.debug(
        'AuthenticationBloc: Signup requested for ${event.email}',
      );
      emit(const AuthenticationLoading());

      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      // TODO: Implement actual signup logic

      LoggerService.info('AuthenticationBloc: Signup successful');

      emit(const SignUpSuccess('Account created successfully!'));
    } catch (e, stackTrace) {
      LoggerService.error('AuthenticationBloc: Signup failed', e, stackTrace);
      emit(AuthenticationError('Signup failed: ${e.toString()}'));
    }
  }

  /// Handle logout request
  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      LoggerService.debug('AuthenticationBloc: Logout requested');
      emit(const AuthenticationLoading());

      // TODO: Clear authentication data

      LoggerService.info('AuthenticationBloc: Logout successful');
      emit(const Unauthenticated());
    } catch (e, stackTrace) {
      LoggerService.error('AuthenticationBloc: Logout failed', e, stackTrace);
      emit(AuthenticationError('Logout failed: ${e.toString()}'));
    }
  }

  /// Check authentication status
  Future<void> _onCheckAuthStatus(
    CheckAuthenticationStatus event,
    Emitter<AuthenticationState> emit,
  ) async {
    try {
      LoggerService.debug('AuthenticationBloc: Checking auth status');

      // TODO: Check if user is authenticated (e.g., check token validity)

      // For now, assume unauthenticated
      emit(const Unauthenticated());
    } catch (e, stackTrace) {
      LoggerService.error(
        'AuthenticationBloc: Status check failed',
        e,
        stackTrace,
      );
      emit(const Unauthenticated());
    }
  }
}
