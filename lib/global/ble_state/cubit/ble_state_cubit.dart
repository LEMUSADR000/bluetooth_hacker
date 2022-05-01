import 'package:bloc/bloc.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ble_state.dart';
part 'ble_state_cubit.freezed.dart';

class BleStateCubit extends Cubit<BleState> {
  BleStateCubit() : super(const BleState.connecting());
}
