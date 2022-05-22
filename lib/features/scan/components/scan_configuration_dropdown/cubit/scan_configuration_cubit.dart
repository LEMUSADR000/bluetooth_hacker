import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'scan_configuration_cubit.freezed.dart';
part 'scan_configuration_state.dart';

class ScanConfigurationCubit extends Cubit<ScanConfigurationState> {
  ScanConfigurationCubit() : super(const ScanConfigurationState.collapsed());

  void toggle() {
    if (state is Collapsed) {
      expand();
    } else if (state is Expanded) {
      collapse();
    }
  }

  void expand() => emit(const ScanConfigurationState.expanded());

  void collapse() => emit(const ScanConfigurationState.collapsed());
}
