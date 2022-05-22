part of 'scan_bloc.dart';

@freezed
class ScanState with _$ScanState {
  const factory ScanState.scanning({
    required ScanningOptions options,
    required Map<String, DiscoveredDevice> scanResults,
    required List<String> ids,
  }) = Scanning;

  const factory ScanState.clearingScanResults({
    required ScanningOptions options,
    required Map<String, DiscoveredDevice> scanResults,
    required List<String> ids,
  }) = ClearingScanResults;

  const factory ScanState.notScanning({
    @Default(ScanningOptions()) ScanningOptions options,
    @Default({}) Map<String, DiscoveredDevice> scanResults,
    @Default([]) List<String> ids,
  }) = NotScanning;
}
