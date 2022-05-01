part of 'ble_state_cubit.dart';

@freezed
class BleState with _$BleState {
  const factory BleState.initializing() = Initializing;

  const factory BleState.ready({
    required bool needsPermissions,
  }) = Ready;

  const factory BleState.error({
    required BleStatus errorState,
  }) = Error;
}
