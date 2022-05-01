import 'package:bluetooth_hacker/features/scan/scan_page.dart';
import 'package:flutter/widgets.dart';

abstract class AppRoutes {
  static String initialRoute = ScanPage.routeName;

  static Map<String, WidgetBuilder> routes = {
    ScanPage.routeName: ScanPage.create,
  };
}
