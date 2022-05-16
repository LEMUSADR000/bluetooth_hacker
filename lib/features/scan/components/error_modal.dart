import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorModal extends StatelessWidget {
  const ErrorModal({required this.status, Key? key}) : super(key: key);
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
