part of 'scan_bloc.dart';

@freezed
class ScanEvent with _$ScanEvent {
  const factory ScanEvent.startScan() = StartScan;
  const factory ScanEvent.stopScan() = StopScan;
}
