part of 'ble_state_cubit.dart';

@freezed
class BleState with _$BleState {
  const factory BleState.initializing() = Initializing;
  const factory BleState.ready() = Ready;

  const factory BleState.error({
    required BleStatus errorState,
  }) = Error;

  const factory BleState.missingRequirement({
    required List<Permissions> permission,
    required List<Service> service,
  }) = MissingRequirement;
}

enum Permissions {
  location,
}

enum Service {
  location,
  ble,
}
