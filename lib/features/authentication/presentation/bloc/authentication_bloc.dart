import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:seed/core/repositories/base_repository.dart';
import 'package:seed/core/utils/logger_service.dart';
import 'package:seed/features/authentication/domain/usecases/login_usecase.dart';
import 'package:seed/features/authentication/domain/usecases/signup_usecase.dart';
import 'package:seed/features/authentication/presentation/bloc/authentication_event.dart';
import 'package:seed/features/authentication/presentation/bloc/authentication_state.dart';

/// BLoC for managing authentication state
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final LoginUseCase loginUseCase;
  final SignUpUseCase signUpUseCase;
  final IPreferencesRepository preferencesRepository;

  AuthenticationBloc({
    required this.loginUseCase,
    required this.signUpUseCase,
    required this.preferencesRepository,
  }) : super(const AuthenticationInitial()) {
    // Register event handlers with sequential processing
    on<LoginRequested>(_onLoginRequested, transformer: sequential());
    on<SignUpRequested>(_onSignUpRequested, transformer: sequential());
    on<LogoutRequested>(_onLogoutRequested, transformer: sequential());
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

      final result = await loginUseCase(
        email: event.email,
        password: event.password,
      );

      result.fold(
        (failure) {
          LoggerService.error(
            'AuthenticationBloc: Login failed - ${failure.message}',
          );
          emit(AuthenticationError(failure.message));
        },
        (authResponse) async {
          LoggerService.info('AuthenticationBloc: Login successful');

          // Save token to local storage
          await preferencesRepository.setString(
            'auth_token',
            authResponse.token,
          );
          await preferencesRepository.setString(
            'user_id',
            authResponse.user.id.toString(),
          );
          await preferencesRepository.setString(
            'user_name',
            authResponse.user.name,
          );
          await preferencesRepository.setString(
            'user_email',
            authResponse.user.email,
          );

          emit(
            Authenticated(
              userId: authResponse.user.id.toString(),
              userName: authResponse.user.name,
              email: authResponse.user.email,
            ),
          );

          emit(const LoginSuccess('Login successful!'));
        },
      );
    } catch (e, stackTrace) {
      LoggerService.error(
        'AuthenticationBloc: Unexpected error during login',
        e,
        stackTrace,
      );
      emit(
        AuthenticationError('An unexpected error occurred: ${e.toString()}'),
      );
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

      // Parse age to int
      final age = int.tryParse(event.age) ?? 0;
      if (age <= 0) {
        emit(const AuthenticationError('Please enter a valid age'));
        return;
      }

      final result = await signUpUseCase(
        name: event.name,
        age: age,
        email: event.email,
        password: event.password,
        education: event.education,
        favoriteActivities: event.favoriteActivities ?? 'Web',
      );

      result.fold(
        (failure) {
          LoggerService.error(
            'AuthenticationBloc: Signup failed - ${failure.message}',
          );
          emit(AuthenticationError(failure.message));
        },
        (authResponse) async {
          LoggerService.info('AuthenticationBloc: Signup successful');

          // Save token to local storage
          await preferencesRepository.setString(
            'auth_token',
            authResponse.token,
          );
          await preferencesRepository.setString(
            'user_id',
            authResponse.user.id.toString(),
          );
          await preferencesRepository.setString(
            'user_name',
            authResponse.user.name,
          );
          await preferencesRepository.setString(
            'user_email',
            authResponse.user.email,
          );

          emit(const SignUpSuccess('Account created successfully!'));
        },
      );
    } catch (e, stackTrace) {
      LoggerService.error(
        'AuthenticationBloc: Unexpected error during signup',
        e,
        stackTrace,
      );
      emit(
        AuthenticationError('An unexpected error occurred: ${e.toString()}'),
      );
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

      // Clear authentication data
      await preferencesRepository.remove('auth_token');
      await preferencesRepository.remove('user_id');
      await preferencesRepository.remove('user_name');
      await preferencesRepository.remove('user_email');

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

      final token = preferencesRepository.getString('auth_token');

      if (token != null && token.isNotEmpty) {
        final userId = preferencesRepository.getString('user_id') ?? '';
        final userName =
            preferencesRepository.getString('user_name') ?? '';
        final userEmail =
            preferencesRepository.getString('user_email') ?? '';

        emit(
          Authenticated(userId: userId, userName: userName, email: userEmail),
        );
      } else {
        emit(const Unauthenticated());
      }
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
