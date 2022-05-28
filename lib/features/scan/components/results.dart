import 'package:bluetooth_hacker/di/di.dart';
import 'package:bluetooth_hacker/features/common/custom_refresh_indicator.dart';
import 'package:bluetooth_hacker/features/scan/bloc/scan_bloc.dart';
import 'package:bluetooth_hacker/features/scan/components/scan_configuration_dropdown/cubit/scan_configuration_cubit.dart';
import 'package:bluetooth_hacker/features/scan/components/scan_result.dart';
import 'package:bluetooth_hacker/features/scan/model/scan_result.dart';
import 'package:bluetooth_hacker/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';

class Results extends StatelessWidget {
  const Results({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ScanConfigurationCubit()),
        BlocProvider(
          create: (_) => getIt<ScanBloc>()..add(const ScanEvent.startScan(
              // options: ScanningOptions(
              //   services: ['deca0001-10c7-43a8-8c9f-42b70e03808d'],
              // ),
              )),
        ),
      ],
      child: const _Results(),
    );
  }
}

class _Results extends StatelessWidget {
  const _Results({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScanBloc scanBloc = context.read<ScanBloc>();

    return ColoredBox(
      color: LightColors.kLavender.withAlpha(0x8A),
      child: BlocBuilder<ScanBloc, ScanState>(
        buildWhen: (prev, curr) => prev.ids != curr.ids,
        builder: (_, state) {
          return CustomLoadingIndicator(
            onRefresh: () async {
              scanBloc.add(const ScanEvent.resetScan());
              await scanBloc.stream
                  .firstWhere((element) => element is Scanning);
            },
            child: ImplicitlyAnimatedList<ScanResult>(
              items: state.ids
                  .map((id) => state.scanResults[id]!)
                  .toList(growable: false),
              areItemsTheSame: (a, b) => a.id == b.id,
              insertDuration: ScanBloc.scanResultAnimationDuration,
              removeDuration: ScanBloc.scanResultAnimationDuration,
              updateDuration: ScanBloc.scanResultAnimationDuration,
              itemBuilder: (_, anim, device, __) {
                return SlideTransition(
                  position: anim.drive(Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: const Offset(0, 0),
                  )),
                  child: ScanResultButton(scanResult: device),
                );
              },
              removeItemBuilder: (_, anim, device) {
                /// NOTE: This animation runs in reverse no matter what your
                /// arguments, so just flip the begin/end values that you would
                /// otherwise use to achieve the same animation
                return SlideTransition(
                  position: anim.drive(Tween<Offset>(
                    begin: const Offset(-1, 0),
                    end: const Offset(0, 0),
                  )),
                  child: ScanResultButton(scanResult: device),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
