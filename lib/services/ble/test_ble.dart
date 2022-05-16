import 'dart:async';
import 'dart:typed_data';

import 'package:bluetooth_hacker/services/ble/i_ble.dart';
import 'package:bluetooth_hacker/services/ble/model/device.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class TestBle implements Ble {
  static const int _scanCap = 15;

  @override
  BleClient connectToDevice(DiscoveredDevice discoveredDevice,
      {required Duration connectionTimeout}) {
    // TODO: implement connectToDevice
    throw UnimplementedError();
  }

  @override
  Stream<ConnectionStateUpdate> get connectedDeviceStream =>
      throw UnimplementedError();

  @override
  Future<void> initializeCommunication(BleClient client) {
    // TODO: implement initializeCommunication
    throw UnimplementedError();
  }

  @override
  Stream<DiscoveredDevice> startScan({required List<Uuid> services}) {
    return Stream<DiscoveredDevice>.periodic(
      const Duration(seconds: 1),
      (i) {
        return DiscoveredDevice(
          id: '#${i % _scanCap}',
          name: 'Test Device ${i % _scanCap}',
          serviceData: const {},
          manufacturerData: Uint8List.fromList([]),
          rssi: -1,
          serviceUuids: const [],
        );
      },
    );
  }

  @override
  Stream<BleStatus> get statusStream =>
      Stream<BleStatus>.value(BleStatus.ready).asBroadcastStream();
}
