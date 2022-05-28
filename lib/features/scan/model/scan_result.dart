import 'dart:typed_data';

import 'package:bluetooth_hacker/resources/company_identifiers.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'scan_result.freezed.dart';

@freezed
class ScanResult with _$ScanResult {
  const factory ScanResult({
    required String id,
    required DiscoveredDevice device,
    required int rssi,
    String? name,
    int? companyIdentifier,
    String? companyName,
  }) = _ScanResult;

  factory ScanResult.fromDiscovered(DiscoveredDevice discoveredDevice) {
    int? coId;
    try {
      coId = discoveredDevice.manufacturerData
          .sublist(0, 2)
          .buffer
          .asByteData()
          .getUint16(0, Endian.little);
    } catch (_) {}

    final String? coName = identifiers[coId];

    final String trimmed = discoveredDevice.name.replaceAll(' ', '');

    return ScanResult(
      rssi: discoveredDevice.rssi,
      id: discoveredDevice.id,
      name: trimmed.isNotEmpty ? discoveredDevice.name : null,
      device: discoveredDevice,
      companyIdentifier: coId,
      companyName: coName,
    );
  }
}
