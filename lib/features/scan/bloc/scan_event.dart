part of 'scan_bloc.dart';

abstract class ScanEvent {}

class StartScan implements ScanEvent {
  const StartScan();
}

class StopScan implements ScanEvent {
  const StopScan();
}
