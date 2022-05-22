part of 'scan_bloc.dart';

@freezed
class ScanEvent with _$ScanEvent {
  const factory ScanEvent.resetScan() = ResetScan;

  const factory ScanEvent.startScan({
    @Default(ScanningOptions()) ScanningOptions options,
  }) = StartScan;

  const factory ScanEvent.stopScan() = StopScan;

  /// Private states - Bloc Only type check
  const factory ScanEvent.resultReceived({
    required DiscoveredDevice device,
  }) = _ResultReceived;
}
