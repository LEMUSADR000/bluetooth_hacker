part of 'scan_bloc.dart';

abstract class ScanState {
  SplayTreeMap<String, DiscoveredDevice> get scanResults;
  set scanResults(SplayTreeMap<String, DiscoveredDevice> scanResult);
}

class Scanning implements ScanState {
  Scanning()
      : scanResults = SplayTreeMap(),
        super();

  @override
  SplayTreeMap<String, DiscoveredDevice> scanResults;
}

class StoppedScanning implements ScanState {
  StoppedScanning()
      : scanResults = SplayTreeMap(),
        super();

  @override
  SplayTreeMap<String, DiscoveredDevice> scanResults;
}
