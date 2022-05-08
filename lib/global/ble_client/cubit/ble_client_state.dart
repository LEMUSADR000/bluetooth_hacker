part of 'ble_client_cubit.dart';

@freezed
class BleClientState with _$BleClientState {
  const factory BleClientState.connecting({
    BleClient? client,
  }) = Connecting;

  const factory BleClientState.connected({
    BleClient? client,
  }) = Connected;

  const factory BleClientState.disconnecting({
    BleClient? client,
  }) = Disconnecting;

  const factory BleClientState.disconnected({
    BleClient? client,
  }) = Disconnected;
}
