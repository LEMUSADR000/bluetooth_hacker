import 'package:bluetooth_hacker/di/di.dart';
import 'package:bluetooth_hacker/features/common/platform_refresh_indicator.dart';
import 'package:bluetooth_hacker/features/scan/bloc/scan_bloc.dart';
import 'package:bluetooth_hacker/features/scan/components/scan_configuration_dropdown/cubit/scan_configuration_cubit.dart';
import 'package:bluetooth_hacker/global/ble_client/cubit/ble_client_cubit.dart';
import 'package:bluetooth_hacker/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:implicitly_animated_reorderable_list/implicitly_animated_reorderable_list.dart';

class Results extends StatelessWidget {
  const Results({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ScanConfigurationCubit()),
        BlocProvider(
          create: (_) => getIt<ScanBloc>()..add(const ScanEvent.startScan()),
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

    return BlocBuilder<ScanBloc, ScanState>(
      buildWhen: (prev, curr) => prev.ids != curr.ids,
      builder: (_, state) {
        return PlatformRefreshIndicator(
          indicatorSize: 75,
          onRefresh: () async {
            scanBloc.add(const ScanEvent.resetScan());
            await scanBloc.stream.firstWhere((element) => element is Scanning);
          },
          child: ImplicitlyAnimatedList<DiscoveredDevice>(
            items: state.ids
                .map((id) => state.scanResults[id]!)
                .toList(growable: false),
            areItemsTheSame: (a, b) => a.id == b.id,
            insertDuration: ScanBloc.exitDuration,
            removeDuration: ScanBloc.exitDuration,
            updateDuration: ScanBloc.exitDuration,
            itemBuilder: (_, anim, device, __) {
              return SlideTransition(
                position: anim.drive(Tween<Offset>(
                  begin: const Offset(1, 0),
                  end: const Offset(0, 0),
                )),
                child: _ScanResult(device: device),
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
                child: _ScanResult(device: device),
              );
            },
          ),
        );
      },
    );
  }
}

class _ScanResult extends StatelessWidget {
  const _ScanResult({
    required this.device,
    Key? key,
  }) : super(key: key);

  String get id => device.id;
  final DiscoveredDevice device;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 25.h,
        horizontal: 20.w,
      ),
      child: PlatformTextButton(
        padding: EdgeInsets.symmetric(
          vertical: 25.h,
          horizontal: 25.w,
        ),
        color: LightColors.kGreen,
        onPressed: () => context.read<BleServiceCubit>().connectDevice(device),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: FittedBox(
                    child: Text(
                      device.name,
                      style: DefaultTextStyle.of(context).style.copyWith(
                            fontSize: 48.sp,
                            fontWeight: FontWeight.bold,
                            color: LightColors.kLightYellow.withOpacity(0.5),
                          ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  child: FittedBox(
                    child: Text(
                      device.id,
                      style: DefaultTextStyle.of(context).style.copyWith(
                            fontSize: 48.sp,
                            fontWeight: FontWeight.bold,
                            color: LightColors.kLightYellow.withOpacity(0.5),
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
