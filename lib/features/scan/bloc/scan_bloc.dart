import 'dart:async';

import 'package:bluetooth_hacker/features/scan/model/scanning_options.dart';
import 'package:bluetooth_hacker/services/ble/i_ble.dart';
import 'package:bluetooth_hacker/utils/log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'scan_bloc.freezed.dart';
part 'scan_event.dart';
part 'scan_state.dart';

class ScanBloc extends Bloc<ScanEvent, ScanState> {
  static const Duration exitDuration = Duration(milliseconds: 250);

  final Ble _ble;
  StreamSubscription<DiscoveredDevice>? _scanResultsSubscription;

  ScanBloc({required Ble ble})
      : _ble = ble,
        super(const ScanState.notScanning()) {
    on<StartScan>(_startScan);
    on<StopScan>(_stopScan);
    on<ResetScan>(_resetScan);
    on<_ResultReceived>(_resultReceived);
  }

  Future<void> _startScan(StartScan event, Emitter<ScanState> emit) async {
    try {
      if (_scanResultsSubscription != null) {
        _scanResultsSubscription?.cancel();
        _scanResultsSubscription = null;
      }

      _scanResultsSubscription = _ble
          .startScan(services: event.options.services.map(Uuid.parse).toList())
          .listen(_onScanResultReceived);

      emit(ScanState.scanning(
        scanResults: {},
        ids: [],
        options: event.options,
      ));
    } catch (e, stacktrace) {
      Log.e('Unable to start scan $e', stackTrace: stacktrace);

      emit(ScanState.notScanning(
        scanResults: state.scanResults,
        ids: state.ids,
        options: event.options,
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
      options: state.options,
    ));
  }

  Future<void> _resetScan(ResetScan event, Emitter<ScanState> emit) async {
    try {
      emit(ScanState.clearingScanResults(
        scanResults: state.scanResults,
        ids: state.ids,
        options: state.options,
      ));

      await _scanResultsSubscription?.cancel();

      add(ScanEvent.startScan(options: state.options));
    } catch (e, stacktrace) {
      Log.e('Unable to reset scan $e', stackTrace: stacktrace);

      emit(ScanState.notScanning(
        scanResults: state.scanResults,
        ids: state.ids,
        options: state.options,
      ));
    }
  }

  Future<void> _resultReceived(
    _ResultReceived event,
    Emitter<ScanState> emit,
  ) async {
    try {
      final DiscoveredDevice device = event.device;

      final Map<String, DiscoveredDevice> discovered = {
        ...state.scanResults,
        device.id: device,
      };

      final List<DiscoveredDevice> devices =
          discovered.values.toList(growable: false);

      switch (state.options.sorting) {
        case ScanSorting.rssi:
          devices.sort((a, b) => a.rssi.compareTo(b.rssi));
          break;
        case ScanSorting.name:
          devices.sort((a, b) => a.name.compareTo(b.name));
          break;
        default:
          break;
      }

      final List<String> orderedIds =
          (state.options.direction == ScanSortingDirection.ascending
                  ? devices
                  : devices.reversed)
              .map((e) => e.id)
              .toList(growable: false);

      emit(ScanState.scanning(
        scanResults: discovered,
        ids: orderedIds,
        options: state.options,
      ));
    } catch (e, stacktrace) {
      Log.e(
        'Exception occurred when emitting discovered device $e',
        stackTrace: stacktrace,
      );

      emit(ScanState.notScanning(
        scanResults: state.scanResults,
        ids: state.ids,
        options: state.options,
      ));
    }
  }

  void _onScanResultReceived(DiscoveredDevice device) {
    final ScanningOptions options = state.options;

    bool addScanResult = true;
    if (options.ignoreNoName) {
      addScanResult = device.name != '';
    }

    if (addScanResult) {
      add(ScanEvent.resultReceived(device: device));
    }
  }

  @override
  Future<void> close() async {
    await _scanResultsSubscription?.cancel();

    super.close();
  }
}
