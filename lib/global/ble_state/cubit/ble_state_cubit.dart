import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bluetooth_hacker/services/ble/i_ble.dart';
import 'package:bluetooth_hacker/utils/log.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ble_state.dart';
part 'ble_state_cubit.freezed.dart';

class BleStateCubit extends Cubit<BleState> {
  final Ble _ble;
  late final StreamSubscription<BleStatus> _subscription;

  BleStateCubit({required Ble ble})
      : _ble = ble,
        super(const BleState.initializing()) {
    _subscription = _ble.statusStream.listen(
      _onStateChanged,
      onError: _onStateChangedError,
    );
  }

  Future<void> _onStateChanged(BleStatus update) async {
    Log.d('BLE STATE CHANGED: $update');

    if (update == BleStatus.ready) {
      emit(const BleState.ready());
    } else {
      emit(BleState.error(errorState: update));
    }
  }

  void _onStateChangedError(e, stacktrace) {
    Log.e(
      'Bluetooth State - Error on state listen\n$e',
      stackTrace: stacktrace,
    );
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();

    return super.close();
  }
}
