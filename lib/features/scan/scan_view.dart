import 'package:bluetooth_hacker/di/di.dart';
import 'package:bluetooth_hacker/features/scan/components/error_modal.dart';
import 'package:bluetooth_hacker/features/scan/components/loading_widet.dart';
import 'package:bluetooth_hacker/features/scan/components/missing_requirements_modal.dart';
import 'package:bluetooth_hacker/features/scan/components/results.dart';
import 'package:bluetooth_hacker/global/ble_state/cubit/ble_state_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

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
      iosContentPadding: true,
      iosContentBottomPadding: true,
      appBar: PlatformAppBar(
        title: const Text('Scan View'),
        cupertino: (_, __) => CupertinoNavigationBarData(
          border: const Border(),
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<BleStateCubit, BleState>(
          buildWhen: (prev, curr) {
            if (prev is Error &&
                curr is Error &&
                prev.errorState == curr.errorState) {
              return false;
            }

            return true;
          },
          builder: (_, state) {
            return Column(
              children: [
                Flexible(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 350),
                    child: state.maybeWhen(
                      initializing: () => const LoadingWidget(),
                      ready: () => const Results(),
                      missingRequirement: (permissions, services) =>
                          MissingRequirementModal(
                        permissions: permissions,
                        service: services,
                      ),
                      error: (status) => ErrorModal(status: status),
                      orElse: () => const SizedBox.shrink(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
