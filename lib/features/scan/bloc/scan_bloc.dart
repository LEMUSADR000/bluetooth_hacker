import 'dart:async';

import 'package:bluetooth_hacker/services/ble/i_ble.dart';
import 'package:bluetooth_hacker/utils/log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'scan_bloc.freezed.dart';
part 'scan_event.dart';
part 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  final Ble _ble;
  StreamSubscription<DiscoveredDevice>? _scanResultsSubscription;

  ScanBloc({required Ble ble})
      : _ble = ble,
        super(const ScanState.notScanning()) {
    on<StartScan>(_startScan);
    on<StopScan>(_stopScan);
    on<_ResultReceived>(_resultReceived);
  }

  Future<void> _startScan(StartScan event, Emitter<ScanState> emit) async {
    if (_scanResultsSubscription != null) {
      _scanResultsSubscription?.cancel();
      _scanResultsSubscription = null;
    }

    try {
      _scanResultsSubscription = _ble
          .startScan(services: event.services.map(Uuid.parse).toList())
          .listen(_onScanResultReceived);
    } catch (e, stacktrace) {
      Log.e('Unable to start scan $e', stackTrace: stacktrace);
      emit(ScanState.notScanning(
        scanResults: state.scanResults,
        ids: state.ids,
      ));
    }
  }

  Future<void> _stopScan(StopScan event, Emitter<ScanState> emit) async {
    try {
      await _scanResultsSubscription?.cancel();
    } catch (e, stacktrace) {
      Log.e('Unable to stop scanning $e', stackTrace: stacktrace);
    }

    emit(ScanState.notScanning(
      scanResults: state.scanResults,
      ids: state.ids,
    ));
  }

  Future<void> _resultReceived(
    _ResultReceived event,
    Emitter<ScanState> emit,
  ) async {
    try {
      final DiscoveredDevice device = event.device;

      final List<String> ids = state.scanResults[device.id] == null
          ? [...state.ids, device.id]
          : state.ids;

      final Map<String, DiscoveredDevice> discovered = {
        ...state.scanResults,
        device.id: device,
      };

      emit(ScanState.scanning(
        scanResults: discovered,
        ids: ids,
      ));
    } catch (e, stacktrace) {
      Log.e(
        'Exception occurred when emitting discovered device $e',
        stackTrace: stacktrace,
      );
    }
  }

  void _onScanResultReceived(DiscoveredDevice device) {
    if (device.name != '') {
      add(ScanEvent.resultReceived(device: device));
    }
  }

  @override
  Future<void> close() async {
    await _scanResultsSubscription?.cancel();

    super.close();
  }
}
