import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:bluetooth_hacker/services/ble/i_ble.dart';
import 'package:bluetooth_hacker/services/ble/model/device.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:uuid/uuid.dart' as uuid;

class TestBle implements Ble {
  static const int _scanCap = 5;

  @override
  BleClient connectToDevice(
    DiscoveredDevice discoveredDevice, {
    required Duration connectionTimeout,
  }) {
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
    final Random rng = Random();

    return Stream<DiscoveredDevice>.periodic(
      const Duration(seconds: 1),
      (i) {
        final int seed = rng.nextInt(10000);
        final int rssi = -100 + rng.nextInt(200);
        final String gen = const uuid.Uuid().v4();

        return DiscoveredDevice(
          id: gen,
          name: gen.substring(0, 5),
          serviceData: const {},
          manufacturerData: Uint8List.fromList([]),
          rssi: rssi,
          serviceUuids: const [],
        );
      },
    ).take(_scanCap);
  }

  @override
  Stream<BleStatus> get statusStream =>
      Stream<BleStatus>.value(BleStatus.ready).asBroadcastStream();
}
