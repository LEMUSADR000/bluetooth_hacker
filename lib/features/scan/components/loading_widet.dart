import 'package:bluetooth_hacker/resources/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

const _defaultStrokeWidth = 2.0;

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    this.value,
    this.strokeWidth,
    Key? key,
  }) : super(key: key);
  final double? value;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingIndicator(
        indicatorType: Indicator.ballClipRotatePulse,
        colors: const [LightColors.kLavender],
        strokeWidth: strokeWidth ?? _defaultStrokeWidth,
      ),
    );

    // return Center(
    //   child: AspectRatio(
    //     aspectRatio: 1,
    //     child: LayoutBuilder(
    //       builder: (_, constraints) {
    //         return Center(
    //           child: Container(
    //             decoration: BoxDecoration(
    //               shape: BoxShape.circle,
    //               color: LightColors.kLavender.withAlpha(0x8A),
    //             ),
    //             constraints: BoxConstraints.tightFor(
    //               height: constraints.maxWidth / 4,
    //               width: constraints.maxWidth / 4,
    //             ),
    //             child: CircularProgressIndicator(
    //               value: value,
    //               backgroundColor: LightColors.kLightYellow,
    //               color: LightColors.kDarkBlue,
    //               strokeWidth: strokeWidth ?? 4.0,
    //             ),
    //           ),
    //         );
    //       },
    //     ),
    //   ),
    // );
  }
}
