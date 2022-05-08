part of 'scan_bloc.dart';

@freezed
class ScanEvent with _$ScanEvent {
  const factory ScanEvent.startScan({
    @Default([]) List<String> services,
  }) = StartScan;

  const factory ScanEvent.stopScan() = StopScan;

  const factory ScanEvent.resultReceived({
    required DiscoveredDevice device,
  }) = _ResultReceived;
}
