import 'package:bluetooth_hacker/features/scan/scan_view.dart';
import 'package:flutter/widgets.dart';

abstract class AppRoutes {
  static String initialRoute = ScanView.routeName;

  static Map<String, WidgetBuilder> routes = {
    ScanView.routeName: ScanView.create,
  };
}
