import 'package:bluetooth_hacker/features/scan/bloc/scan_bloc.dart';
import 'package:bluetooth_hacker/global/ble_state/cubit/ble_state_cubit.dart';
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
      ..registerLazySingleton<BleStateCubit>(
        () => BleStateCubit(ble: getIt()),
      )

      // Services
      ..registerLazySingleton<Ble>(
        // TestBle.new,
        () => ConcreteBle(ble: FlutterReactiveBle()),
      );
  }
}
