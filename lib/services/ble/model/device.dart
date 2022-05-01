import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

@immutable
class BleClient {
  BleClient({
    required DiscoveredDevice device,
    required QualifiedCharacteristic rx,
    required Stream<ConnectionStateUpdate> lifeline,
  })  : _device = device,
        _rx = rx,
        _lifeline = lifeline.listen((_) {}),
        super();

  final DiscoveredDevice _device;
  DiscoveredDevice get device => _device;

  final QualifiedCharacteristic _rx;
  QualifiedCharacteristic get rx => _rx;

  final StreamSubscription<ConnectionStateUpdate> _lifeline;

  late final Stream<List<int>> _rxStream;
  late final int _mtu;

  void initializeCommunications(Stream<List<int>> rxStream, int mtu) {
    _rxStream = rxStream;
    _mtu = mtu;
  }

  Future<void> killClient() async {
    await _lifeline.cancel();
  }
}
