import 'dart:async';

import 'package:bluetooth_hacker/services/ble/i_ble.dart';
import 'package:bluetooth_hacker/services/ble/model/device.dart';
import 'package:bluetooth_hacker/utils/log.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ble_client_cubit.freezed.dart';
part 'ble_client_state.dart';

class BleServiceCubit extends Cubit<BleClientState> {
  final Ble _ble;
  late final StreamSubscription<ConnectionStateUpdate> _subscription;

  BleServiceCubit({required Ble ble})
      : _ble = ble,
        super(const Disconnected()) {
    _subscription = _ble.connectedDeviceStream.listen(
      _onStateChanged,
      onError: _onStateChangedError,
    );
  }

  Future<void> connectDevice(DiscoveredDevice discoveredDevice) async {
    try {
      const Duration connectionDuration = Duration(seconds: 10);
      final BleClient client = _ble.connectToDevice(
        discoveredDevice,
        connectionTimeout: connectionDuration,
      );
      emit(Connecting(client: client));

      await Future.delayed(connectionDuration, () {
        throw Exception('Connection Timeout');
      });
    } catch (e, stacktrace) {
      Log.e(
        'Encountered issue when trying to connect: $e',
        stackTrace: stacktrace,
      );

      emit(const Disconnected());
    }
  }

  Future<void> _onStateChanged(ConnectionStateUpdate update) async {
    if (update.deviceId != state.client?.device.id) {
      Log.e('Received unexpected state update for ${update.deviceId}');
      emit(const Disconnected());
    }

    Log.d('Connection state updated ${update.connectionState}');

    switch (update.connectionState) {
      case DeviceConnectionState.connected:
        if (state.client != null) {
          try {
            await _ble.initializeCommunication(state.client!);
          } catch (e, stacktrace) {
            Log.e(
              'Failed to establish communication $e',
              stackTrace: stacktrace,
            );
            emit(const Disconnected());
          }
          emit(Connected(client: state.client));
        }

        break;
      case DeviceConnectionState.disconnected:
        if (state.client != null) {
          emit(Disconnecting(client: state.client));

          try {
            await state.client?.killClient();
          } catch (e, stacktrace) {
            Log.e(
              'Failed to kill bluetooth client $e',
              stackTrace: stacktrace,
            );
          }
        } else {
          Log.e(
            'ERROR: Received disconnected state but no device was connected',
          );
        }

        emit(const Disconnected());
        break;
      default:
        break;
    }
  }

  void _onStateChangedError(e, stacktrace) {
    Log.e(
      'Bluetooth Client - Error on state listen\n$e',
      stackTrace: stacktrace,
    );
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();

    return super.close();
  }
}
