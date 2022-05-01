import 'package:bluetooth_hacker/utils/log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    Log.e('[${bloc.runtimeType}]', error: error, stackTrace: stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}
