import 'package:bluetooth_hacker/app/routes.dart';
import 'package:bluetooth_hacker/resources/colors.dart';
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
        // final TextStyle style = DefaultTextStyle.of(context).style.copyWith(
        //       fontFamily: GoogleFonts.robotoMono().fontFamily,
        //       color: Colors.grey,
        //     );

        final TextTheme theme = Theme.of(context).textTheme.apply(
              bodyColor: LightColors.kDarkBlue,
              displayColor: LightColors.kDarkBlue,
              fontFamily: GoogleFonts.robotoMono().fontFamily,
            );

        return PlatformApp(
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.initialRoute,
          routes: AppRoutes.routes,
          material: (_, __) => MaterialAppData(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSwatch(
                primaryColorDark: LightColors.kDarkBlue,
                accentColor: LightColors.kLightYellow2,
                cardColor: LightColors.kDarkYellow,
                backgroundColor: LightColors.kLightYellow,
                errorColor: LightColors.kRed,
                brightness: Brightness.light,
              ),
              textTheme: theme,
              // fontFamily: style.fontFamily,
            ),
          ),
          cupertino: (_, __) => CupertinoAppData(
            theme: CupertinoThemeData(
              primaryColor: LightColors.kDarkYellow,
              primaryContrastingColor: LightColors.kLightYellow2,
              barBackgroundColor: LightColors.kDarkYellow,
              scaffoldBackgroundColor: LightColors.kLightYellow,
              textTheme: CupertinoTextThemeData(
                textStyle:
                    theme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
                actionTextStyle:
                    theme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
                tabLabelTextStyle:
                    theme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
                navTitleTextStyle:
                    theme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
                navLargeTitleTextStyle:
                    theme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
                navActionTextStyle:
                    theme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
                pickerTextStyle: theme.subtitle1,
                dateTimePickerTextStyle: theme.subtitle1,
              ),
            ),
          ),
        );
      },
    );
  }
}
