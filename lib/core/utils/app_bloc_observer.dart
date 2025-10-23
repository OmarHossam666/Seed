import 'package:bloc/bloc.dart';
import 'package:seed/core/utils/logger_service.dart';

/// Custom BLoC observer for logging and debugging
class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    LoggerService.debug('BlocObserver: ${bloc.runtimeType} created');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    LoggerService.info('BlocObserver: ${bloc.runtimeType} - Event: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    LoggerService.debug(
      'BlocObserver: ${bloc.runtimeType} - State changed from ${change.currentState.runtimeType} to ${change.nextState.runtimeType}',
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    LoggerService.debug(
      'BlocObserver: ${bloc.runtimeType} - Transition: ${transition.event} => ${transition.nextState.runtimeType}',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    LoggerService.error(
      'BlocObserver: ${bloc.runtimeType} - Error',
      error,
      stackTrace,
    );
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    LoggerService.debug('BlocObserver: ${bloc.runtimeType} closed');
  }
}
