import 'package:bluetooth_hacker/di/di.dart';
import 'package:bluetooth_hacker/features/common/platform_refresh_indicator.dart';
import 'package:bluetooth_hacker/features/scan/bloc/scan_bloc.dart';
import 'package:bluetooth_hacker/features/scan/components/animated_in_container.dart';
import 'package:bluetooth_hacker/features/scan/components/scan_configuration_dropdown/cubit/scan_configuration_cubit.dart';
import 'package:bluetooth_hacker/global/ble_client/cubit/ble_client_cubit.dart';
import 'package:bluetooth_hacker/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
      // child: ScanConfigurationDropdown(
      //   builder: (_) => const _Results(),
      // ),
    );
  }
}

class _Results extends StatelessWidget {
  const _Results({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScanBloc, ScanState>(
      buildWhen: (prev, curr) => prev.ids != curr.ids,
      builder: (_, state) {
        return PlatformRefreshIndicator(
          indicatorSize: 75,
          onRefresh: () async {
            context.read<ScanBloc>().add(const ScanEvent.resetScan());
            await context
                .read<ScanBloc>()
                .stream
                .firstWhere((element) => element is Scanning);
          },
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: state.ids.length,
            itemBuilder: (_, i) {
              final String id = state.ids.elementAt(i);
              final DiscoveredDevice device = state.scanResults[id]!;

              final Widget child = Padding(
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
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: FittedBox(
                              child: Text(
                                device.name,
                                style:
                                    DefaultTextStyle.of(context).style.copyWith(
                                          fontSize: 48.sp,
                                          fontWeight: FontWeight.bold,
                                          color: LightColors.kLightYellow
                                              .withOpacity(0.5),
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
                                style:
                                    DefaultTextStyle.of(context).style.copyWith(
                                          fontSize: 48.sp,
                                          fontWeight: FontWeight.bold,
                                          color: LightColors.kLightYellow
                                              .withOpacity(0.5),
                                        ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  onPressed: () {
                    context.read<BleServiceCubit>().connectDevice(device);
                  },
                ),
              );

              return AnimatedInContainer(
                builder: (_) => child,
              );
            },
          ),
        );
      },
    );
  }
}
