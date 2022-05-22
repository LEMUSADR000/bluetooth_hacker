import 'dart:async';

import 'package:bluetooth_hacker/services/ble/i_ble.dart';
import 'package:bluetooth_hacker/services/ble/model/device.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class ConcreteBle implements Ble {
  ConcreteBle({required FlutterReactiveBle ble}) : _flutterReactiveBle = ble;

  // Private Fields
  final FlutterReactiveBle _flutterReactiveBle;

  @override
  BleClient connectToDevice(
    DiscoveredDevice discoveredDevice, {
    Duration connectionTimeout = const Duration(seconds: 10),
  }) {
    final Stream<ConnectionStateUpdate> heart =
        _flutterReactiveBle.connectToDevice(
      id: discoveredDevice.id,
      connectionTimeout: connectionTimeout,
    );
    return BleClient(device: discoveredDevice, lifeline: heart);
  }

  @override
  Future<void> initializeCommunication(BleClient client) async {
    final mtu = await _flutterReactiveBle.requestMtu(
      deviceId: client.device.id,
      mtu: 247,
    );

    client.initializeCommunications(mtu);
  }

  @override
  Stream<ConnectionStateUpdate> get connectedDeviceStream =>
      _flutterReactiveBle.connectedDeviceStream;

  @override
  Stream<BleStatus> get statusStream => _flutterReactiveBle.statusStream;

  @override
  Stream<DiscoveredDevice> startScan({
    required List<Uuid> services,
  }) {
    return _flutterReactiveBle.scanForDevices(
      withServices: services,
      scanMode: ScanMode.lowPower,
    );
  }
}
