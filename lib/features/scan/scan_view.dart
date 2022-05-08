import 'package:bluetooth_hacker/di/di.dart';
import 'package:bluetooth_hacker/features/scan/bloc/scan_bloc.dart';
import 'package:bluetooth_hacker/global/ble_client/cubit/ble_client_cubit.dart';
import 'package:bluetooth_hacker/global/ble_state/cubit/ble_state_cubit.dart';
import 'package:bluetooth_hacker/resources/colors.dart';
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
      iosContentPadding: true,
      iosContentBottomPadding: true,
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
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: state.maybeWhen(
              initializing: () => const _LoadingWidget(),
              ready: () => BlocProvider(
                create: (_) =>
                    getIt<ScanBloc>()..add(const ScanEvent.startScan()),
                child: const _ScanContent(),
              ),
              missingRequirement: (
                permissions,
                services,
              ) =>
                  _MissingRequirementModal(
                permissions: permissions,
                service: services,
              ),
              error: (status) => _ErrorModal(status: status),
              orElse: () => const SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: (1 / 2).sw,
        width: (1 / 2).sw,
        child: AspectRatio(
          aspectRatio: 1,
          child: LayoutBuilder(
            builder: (_, constraints) {
              return Stack(
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular((1 / 2).sw),
                      ),
                    ),
                    color: LightColors.kDarkYellow,
                    margin: EdgeInsets.zero,
                    child: SizedBox(
                      width: constraints.maxWidth,
                      height: constraints.maxHeight,
                    ),
                  ),
                  ConstrainedBox(
                    constraints: constraints,
                    child: Transform.scale(
                      scale: 2,
                      child: const CircularProgressIndicator.adaptive(),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
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
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: 150.h,
          ),
          padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 50.w),
          alignment: Alignment.centerLeft,
          child: FittedBox(
            child: Text(
              'Scan Results',
              style: DefaultTextStyle.of(context).style.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 100.sp,
                  ),
            ),
          ),
        ),
        Flexible(
          child: BlocBuilder<ScanBloc, ScanState>(
            buildWhen: (prev, curr) => prev.ids != curr.ids,
            builder: (_, state) {
              return ListView.builder(
                itemCount: state.ids.length,
                itemBuilder: (_, i) {
                  final String id = state.ids.elementAt(i);
                  final DiscoveredDevice device = state.scanResults[id]!;

                  final Widget child = Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 20.w,
                    ),
                    child: PlatformTextButton(
                      padding: EdgeInsets.symmetric(
                        vertical: 5.h,
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
                                    style: DefaultTextStyle.of(context)
                                        .style
                                        .copyWith(
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
                                    style: DefaultTextStyle.of(context)
                                        .style
                                        .copyWith(
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

                  return _AnimatedContainer(
                    builder: (_) => child,
                  );
                },
              );
            },
          ),
        )
      ],
    );
  }
}

class _AnimatedContainer extends StatefulWidget {
  const _AnimatedContainer({required this.builder, Key? key}) : super(key: key);
  final WidgetBuilder builder;

  @override
  _AnimatedContainerState createState() => _AnimatedContainerState();
}

class _AnimatedContainerState extends State<_AnimatedContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 550),
  )..forward();
  late final _animation = CurvedAnimation(
    parent: _animationController,
    curve: decelerateEasing,
  );

  late final Animation<Offset> _offset = Tween<Offset>(
    begin: const Offset(0, 1),
    end: const Offset(0, 0),
  ).animate(_animation);

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offset,
      child: widget.builder(context),
    );
  }
}
