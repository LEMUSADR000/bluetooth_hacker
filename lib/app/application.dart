import 'package:bluetooth_hacker/app/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1284, 2778), // iPhone 13 Pro Max,
      builder: (_) {
        final TextStyle style = DefaultTextStyle.of(context).style.copyWith(
              fontFamily: GoogleFonts.robotoMono().fontFamily,
              color: Colors.grey,
            );
        return PlatformApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.initialRoute,
          routes: AppRoutes.routes,
          material: (_, __) => MaterialAppData(
            theme: ThemeData(
              fontFamily: style.fontFamily,
            ),
          ),
          cupertino: (_, __) => CupertinoAppData(
            theme: CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                textStyle: style,
                actionTextStyle: style,
                tabLabelTextStyle: style,
                navTitleTextStyle: style.copyWith(fontWeight: FontWeight.bold),
                navLargeTitleTextStyle:
                    style.copyWith(fontWeight: FontWeight.bold),
                navActionTextStyle: style.copyWith(fontWeight: FontWeight.bold),
                pickerTextStyle: style,
                dateTimePickerTextStyle: style,
              ),
            ),
          ),
        );
      },
    );
  }
}
