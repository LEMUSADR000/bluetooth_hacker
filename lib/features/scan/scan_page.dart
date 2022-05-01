import 'package:bluetooth_hacker/di/di.dart';
import 'package:bluetooth_hacker/features/scan/bloc/scan_bloc.dart';
import 'package:bluetooth_hacker/global/ble_client/cubit/ble_client_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class ScanPage extends StatelessWidget {
  const ScanPage._({Key? key}) : super(key: key);
  static const routeName = '/';

  static Widget create(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ScanBloc>(),
      child: const ScanPage._(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: PlatformText('Title'),
      ),
      body: BlocBuilder<ScanBloc, ScanState>(
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
      ),
    );
  }
}
