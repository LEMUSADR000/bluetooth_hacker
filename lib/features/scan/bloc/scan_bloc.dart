import 'dart:async';
import 'dart:collection';

import 'package:bluetooth_hacker/services/ble/i_ble.dart';
import 'package:bluetooth_hacker/utils/log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

part 'scan_event.dart';
part 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final Ble _ble;
  StreamSubscription<DiscoveredDevice>? _scanResultsSubscription;

  ScanBloc({required Ble ble})
      : _ble = ble,
        super(StoppedScanning()) {
    on<StartScan>(_startScan);
    on<StopScan>(_stopScan);
  }

  Future<void> _startScan(StartScan event, Emitter<ScanState> emit) async {
    if (_scanResultsSubscription != null) {
      _scanResultsSubscription?.cancel();
      _scanResultsSubscription = null;
    }

    try {
      _scanResultsSubscription = _ble.startScan().listen((device) {
        emit(
          Scanning()..scanResults = (state.scanResults..[device.id] = device),
        );
      });
    } catch (e, stacktrace) {
      Log.e('Unable to start scan $e', stackTrace: stacktrace);
      emit(StoppedScanning()..scanResults = state.scanResults);
    }
  }

  Future<void> _stopScan(StopScan event, Emitter<ScanState> emit) async {
    try {
      await _scanResultsSubscription?.cancel();
    } catch (e, stacktrace) {
      Log.e('Unable to stop scanning $e', stackTrace: stacktrace);
    }

    emit(StoppedScanning()..scanResults = state.scanResults);
  }

  @override
  Future<void> close() async {
    await _scanResultsSubscription?.cancel();

    super.close();
  }
}
