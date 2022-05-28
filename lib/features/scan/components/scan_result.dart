import 'package:bluetooth_hacker/features/scan/model/scan_result.dart';
import 'package:bluetooth_hacker/global/ble_client/cubit/ble_client_cubit.dart';
import 'package:bluetooth_hacker/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScanResultButton extends StatelessWidget {
  const ScanResultButton({
    required this.scanResult,
    Key? key,
  }) : super(key: key);

  final ScanResult scanResult;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 25.h,
        horizontal: 25.w,
      ),
      constraints: BoxConstraints.tightFor(height: (1 / 7).sh),
      child: PlatformElevatedButton(
        padding: EdgeInsets.symmetric(
          vertical: 25.h,
          horizontal: 25.w,
        ),
        color: LightColors.kGreen85,
        onPressed: () =>
            context.read<BleServiceCubit>().connectDevice(scanResult.device),
        child: Column(
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: FittedBox(
                      child: Text(
                        'name',
                        style: DefaultTextStyle.of(context)
                            .style
                            .copyWith(color: LightColors.kLightYellow),
                      ),
                    ),
                  ),
                  Flexible(
                    child: FittedBox(
                      child: Text(
                        scanResult.name ?? 'N/A',
                        style: DefaultTextStyle.of(context).style.copyWith(
                            color: LightColors.kLightYellow.withOpacity(0.5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: FittedBox(
                      child: Text(
                        'manufacturer',
                        style: DefaultTextStyle.of(context)
                            .style
                            .copyWith(color: LightColors.kLightYellow),
                      ),
                    ),
                  ),
                  Flexible(
                    child: FittedBox(
                      child: Text(
                        scanResult.companyName ?? 'N/A',
                        style: DefaultTextStyle.of(context).style.copyWith(
                            color: LightColors.kLightYellow.withOpacity(0.65)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
