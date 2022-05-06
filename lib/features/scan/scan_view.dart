import 'package:bluetooth_hacker/di/di.dart';
import 'package:bluetooth_hacker/features/scan/bloc/scan_bloc.dart';
import 'package:bluetooth_hacker/global/ble_client/cubit/ble_client_cubit.dart';
import 'package:bluetooth_hacker/global/ble_state/cubit/ble_state_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScanView extends StatelessWidget {
  const ScanView._({Key? key}) : super(key: key);
  static const routeName = '/';

  static Widget create(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BleStateCubit>(),
      child: const ScanView._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Scan View'),
      ),
      body: BlocBuilder<BleStateCubit, BleState>(
        buildWhen: (prev, curr) {
          if (prev is Error &&
              curr is Error &&
              prev.errorState == curr.errorState) {
            return false;
          }

          return true;
        },
        builder: (_, state) {
          print('building state $state');

          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: state.maybeWhen(
              ready: () => const _ScanContent(),
              missingRequirement: (
                permissions,
                services,
              ) =>
                  _MissingRequirementModal(
                permissions: permissions,
                service: services,
              ),
              error: (status) => _ErrorModal(status: status),
              orElse: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MissingRequirementModal extends StatelessWidget {
  const _MissingRequirementModal({
    required this.permissions,
    required this.service,
    Key? key,
  }) : super(key: key);

  final List<Permissions> permissions;
  final List<Service> service;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class _ErrorModal extends StatelessWidget {
  const _ErrorModal({required this.status, Key? key}) : super(key: key);
  final BleStatus status;

  @override
  Widget build(BuildContext context) {
    final String description;
    switch (status) {
      case BleStatus.unknown:
        description = 'UNKNOWN';
        break;
      case BleStatus.unsupported:
        description = 'UNSUPPORTED';
        break;
      case BleStatus.unauthorized:
        description = 'UNAUTHORIZED';
        break;
      case BleStatus.poweredOff:
        description =
            'BLUETOOTH SERVICE DISABLED. PLEASE NAVIGATE TO SETTINGS AND RE-ENABLE BLUETOOTH.';
        break;
      case BleStatus.locationServicesDisabled:
        description =
            'LOCATION SERVICES DISABLED. PLEASE NAVIGATE TO SETTINGS AND RE-ENABLE OR GRANT LOCATION PERMISSIONS.';
        break;
      default:
        throw Exception('WE SHOULDNT BE HERE');
    }

    return Container(
      key: ValueKey(description),
      padding: EdgeInsets.symmetric(horizontal: 0.25.sw),
      alignment: Alignment.center,
      child: FittedBox(
        child: Text(
          'BLE STATUS:\n$description',
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 100.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _ScanContent extends StatelessWidget {
  const _ScanContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanBloc, ScanState>(
      builder: (_, state) {
        final Iterable<DiscoveredDevice> devices = state.scanResults.values;

        return ListView.builder(
          itemCount: devices.length,
          itemBuilder: (_, i) {
            return ListTile(
              title: Text(
                devices.elementAt(i).name,
              ),
              onTap: () {
                context
                    .read<BleServiceCubit>()
                    .connectDevice(devices.elementAt(i));
              },
            );
          },
        );
      },
    );
  }
}
