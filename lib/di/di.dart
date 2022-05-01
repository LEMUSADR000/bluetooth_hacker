import 'package:bluetooth_hacker/features/scan/bloc/scan_bloc.dart';
import 'package:bluetooth_hacker/services/ble/c_ble.dart';
import 'package:bluetooth_hacker/services/ble/i_ble.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

extension GetItExtension on GetIt {
  void init() {
    getIt
      // Blocs
      ..registerLazySingleton<ScanBloc>(
        () => ScanBloc(ble: getIt()),
      )

      // Services
      ..registerLazySingleton<Ble>(
        () => ConcreteBle(ble: FlutterReactiveBle()),
      );
  }
}
