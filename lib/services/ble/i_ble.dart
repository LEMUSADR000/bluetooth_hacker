import 'package:bluetooth_hacker/services/ble/model/device.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

/// Interface for Ble class. What is an interface? This is a big concept in OOP
/// so it's probably good to do some learning up on this.
///
/// The gist of why i'm using it here is to provide us a template class for the
/// operations which we'd like to see in anything which uses our Ble service.
/// Any functions which are not defined here will not be usable by anything
/// that is attempting to use Ble. The less that you have in your interface
/// the better!

abstract class Ble {
  Stream<ConnectionStateUpdate> get connectedDeviceStream;
  Stream<BleStatus> get statusStream;

  Stream<DiscoveredDevice> startScan();

  BleClient connectToDevice(
    DiscoveredDevice discoveredDevice, {
    required Duration connectionTimeout,
  });

  Future<void> initializeCommunication(BleClient client);
}
