import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  static const String _divider = '════════════════════════════════════';

  int _eventCounter = 0;

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    _log(
      type: 'CREATE',
      blocName: bloc.runtimeType.toString(),
      message: 'Bloc instance created',
    );
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    _eventCounter++;
    _log(
      type: 'CHANGE',
      blocName: bloc.runtimeType.toString(),
      message:
          'Event #$_eventCounter\nPrevious: ${change.currentState}\nNew: ${change.nextState}',
    );
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    _log(
      type: 'EVENT',
      blocName: bloc.runtimeType.toString(),
      message: 'Event triggered: $event',
    );
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    _log(
      type: 'TRANSITION',
      blocName: bloc.runtimeType.toString(),
      message: 'Transition: ${transition.event} → State change',
    );
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _log(
      type: 'ERROR',
      blocName: bloc.runtimeType.toString(),
      message: 'Exception: $error\nStackTrace: $stackTrace',
      isError: true,
    );
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    _log(
      type: 'CLOSE',
      blocName: bloc.runtimeType.toString(),
      message: 'Bloc instance closed',
    );
    _eventCounter = 0;
    super.onClose(bloc);
  }

  void _log({
    required String type,
    required String blocName,
    required String message,
    bool isError = false,
  }) {
    final timestamp = DateTime.now().toString().split('.')[0];
    final prefix = isError ? '❌' : '✓';

    print('$_divider');
    print('$prefix [$timestamp] $type | $blocName');
    print('$_divider');
    print(message);
    print('');
  }
}
